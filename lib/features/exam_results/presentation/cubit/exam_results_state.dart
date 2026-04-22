import 'package:equatable/equatable.dart';
import 'package:exams_app/features/exam_results/domain/entities/exam_result_entity.dart';

class ExamResultsState extends Equatable {
  final List<ExamResultEntity> allResults;
  final bool isLoading;
  final String? errorMessage;

  const ExamResultsState({
    this.allResults = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ExamResultsState copyWith({
    List<ExamResultEntity>? allResults,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ExamResultsState(
      allResults: allResults ?? this.allResults,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        allResults,
        isLoading,
        errorMessage,
      ];
}
