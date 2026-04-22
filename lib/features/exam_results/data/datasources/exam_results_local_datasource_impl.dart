import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/exam_result_model.dart';
import 'exam_results_local_datasource_contract.dart';

@Injectable(as: ExamResultsLocalDataSourceContract)
class ExamResultsLocalDataSourceImpl implements ExamResultsLocalDataSourceContract {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'exam_results.db');
    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE exam_results (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            examId TEXT,
            title TEXT,
            subject TEXT,
            duration INTEGER,
            numberOfQuestions INTEGER,
            correctAnswers INTEGER,
            timeTakenMinutes INTEGER,
            createdAt TEXT,
            detailedAnswers TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Robust check before adding column
          var columns = await db.rawQuery('PRAGMA table_info(exam_results)');
          bool exists = columns.any((column) => column['name'] == 'detailedAnswers');
          if (!exists) {
            await db.execute('ALTER TABLE exam_results ADD COLUMN detailedAnswers TEXT');
          }
        }
      },
    );
  }

  @override
  Future<void> saveExamResult(ExamResultModel result) async {
    final db = await database;
    
    // Final safety check: if for some reason the column is still missing, add it
    try {
      await db.insert(
        'exam_results',
        result.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      if (e.toString().contains('no column named detailedAnswers')) {
        await db.execute('ALTER TABLE exam_results ADD COLUMN detailedAnswers TEXT');
        // Retry insert
        await db.insert(
          'exam_results',
          result.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      } else {
        rethrow;
      }
    }
  }

  @override
  Future<List<ExamResultModel>> getExamResults() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'exam_results',
      orderBy: 'createdAt DESC',
    );
    return List.generate(maps.length, (i) => ExamResultModel.fromMap(maps[i]));
  }
}
