import 'dart:convert';
import '../../domain/entities/exam_result_entity.dart';

class ExamResultModel {
  final int? id;
  final String examId;
  final String title;
  final String subject;
  final int duration;
  final int numberOfQuestions;
  final int correctAnswers;
  final int timeTakenMinutes;
  final String createdAt;
  final List<DetailedAnswerModel> detailedAnswers;

  ExamResultModel({
    this.id,
    required this.examId,
    required this.title,
    required this.subject,
    required this.duration,
    required this.numberOfQuestions,
    required this.correctAnswers,
    required this.timeTakenMinutes,
    required this.createdAt,
    required this.detailedAnswers,
  });

  factory ExamResultModel.fromMap(Map<String, dynamic> map) {
    return ExamResultModel(
      id: map['id'] as int?,
      examId: map['examId'] as String,
      title: map['title'] as String,
      subject: map['subject'] as String,
      duration: map['duration'] as int,
      numberOfQuestions: map['numberOfQuestions'] as int,
      correctAnswers: map['correctAnswers'] as int,
      timeTakenMinutes: map['timeTakenMinutes'] as int,
      createdAt: map['createdAt'] as String,
      detailedAnswers: map['detailedAnswers'] != null 
          ? (jsonDecode(map['detailedAnswers'] as String) as List)
              .map((e) => DetailedAnswerModel.fromMap(e as Map<String, dynamic>))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'examId': examId,
      'title': title,
      'subject': subject,
      'duration': duration,
      'numberOfQuestions': numberOfQuestions,
      'correctAnswers': correctAnswers,
      'timeTakenMinutes': timeTakenMinutes,
      'createdAt': createdAt,
      'detailedAnswers': jsonEncode(detailedAnswers.map((e) => e.toMap()).toList()),
    };
  }

  ExamResultEntity toEntity() {
    return ExamResultEntity(
      id: id,
      examId: examId,
      title: title,
      subject: subject,
      duration: duration,
      numberOfQuestions: numberOfQuestions,
      correctAnswers: correctAnswers,
      timeTakenMinutes: timeTakenMinutes,
      createdAt: createdAt,
      detailedAnswers: detailedAnswers.map((e) => e.toEntity()).toList(),
    );
  }

  factory ExamResultModel.fromEntity(ExamResultEntity entity) {
    return ExamResultModel(
      id: entity.id,
      examId: entity.examId,
      title: entity.title,
      subject: entity.subject,
      duration: entity.duration,
      numberOfQuestions: entity.numberOfQuestions,
      correctAnswers: entity.correctAnswers,
      timeTakenMinutes: entity.timeTakenMinutes,
      createdAt: entity.createdAt,
      detailedAnswers: entity.detailedAnswers
          .map((e) => DetailedAnswerModel.fromEntity(e))
          .toList(),
    );
  }
}

class DetailedAnswerModel {
  final String questionText;
  final List<OptionModel> options;
  final String correctAnswerKey;
  final String userSelectedKey;
  final String type;

  DetailedAnswerModel({
    required this.questionText,
    required this.options,
    required this.correctAnswerKey,
    required this.userSelectedKey,
    required this.type,
  });

  factory DetailedAnswerModel.fromMap(Map<String, dynamic> map) {
    final List<dynamic> optionsList = map['options'] as List;
    
    return DetailedAnswerModel(
      questionText: map['questionText'] as String,
      options: optionsList.asMap().entries.map((entry) {
        final index = entry.key;
        final e = entry.value;
        if (e is String) {
          // HEALING LOGIC: Guess key for old data (A1, A2, A3...)
          return OptionModel(text: e, key: "A${index + 1}");
        }
        return OptionModel.fromMap(e as Map<String, dynamic>);
      }).toList(),
      correctAnswerKey: map['correctAnswerKey'] as String,
      userSelectedKey: map['userSelectedKey'] as String,
      type: map['type'] as String? ?? 'radio',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'questionText': questionText,
      'options': options.map((e) => e.toMap()).toList(),
      'correctAnswerKey': correctAnswerKey,
      'userSelectedKey': userSelectedKey,
      'type': type,
    };
  }

  DetailedAnswerEntity toEntity() {
    return DetailedAnswerEntity(
      questionText: questionText,
      options: options.map((e) => e.toEntity()).toList(),
      correctAnswerKey: correctAnswerKey,
      userSelectedKey: userSelectedKey,
      type: type,
    );
  }

  factory DetailedAnswerModel.fromEntity(DetailedAnswerEntity entity) {
    return DetailedAnswerModel(
      questionText: entity.questionText,
      options: entity.options
          .map((e) => OptionModel.fromEntity(e))
          .toList(),
      correctAnswerKey: entity.correctAnswerKey,
      userSelectedKey: entity.userSelectedKey,
      type: entity.type,
    );
  }
}

class OptionModel {
  final String text;
  final String key;

  OptionModel({required this.text, required this.key});

  factory OptionModel.fromMap(Map<String, dynamic> map) {
    return OptionModel(
      text: map['text'] as String,
      key: map['key'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'key': key,
    };
  }

  OptionEntity toEntity() {
    return OptionEntity(text: text, key: key);
  }

  factory OptionModel.fromEntity(OptionEntity entity) {
    return OptionModel(text: entity.text, key: entity.key);
  }
}
