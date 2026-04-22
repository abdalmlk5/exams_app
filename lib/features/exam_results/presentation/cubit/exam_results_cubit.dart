import 'package:bloc/bloc.dart';
import 'package:exams_app/features/exam_results/domain/entities/exam_result_entity.dart';
import 'package:injectable/injectable.dart';
import '../../domain/usecases/get_exam_results_usecase.dart';
import '../../domain/usecases/save_exam_result_usecase.dart';
import 'exam_results_event.dart';
import 'exam_results_state.dart';

@injectable
class ExamResultsCubit extends Cubit<ExamResultsState> {
  final GetExamResultsUseCase getExamResultsUseCase;
  final SaveExamResultUseCase saveExamResultUseCase;

  ExamResultsCubit(this.getExamResultsUseCase, this.saveExamResultUseCase)
      : super(const ExamResultsState());

  void doIntent(ExamResultsEvent event) {
    if (event is GetExamResultsEvent) {
      _getResults();
    } else if (event is SaveExamResultEvent) {
      _saveResult(event.result);
    }
  }

  Future<void> _getResults() async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      final results = await getExamResultsUseCase();
      // Sort results by subject then by title
      results.sort((a, b) {
        int cmp = a.subject.compareTo(b.subject);
        if (cmp != 0) return cmp;
        return a.title.compareTo(b.title);
      });
      emit(state.copyWith(
        isLoading: false,
        allResults: results,
      ));
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _saveResult(ExamResultEntity result) async {
    try {
      await saveExamResultUseCase(result);
      _getResults(); 
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
