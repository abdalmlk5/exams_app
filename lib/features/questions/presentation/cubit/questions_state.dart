part of 'questions_cubit.dart';

class ExamData extends Equatable {
  final List<QuestionEntity> questions;
  final int currentIndex;
  final Map<String, String> selectedAnswers; // questionId -> answerKey
  final CheckQuestionsResponseEntity? result;

  // Timer metadata
  final int remainingTimeInMinuts;
  final int totalTimeInMinuts;
  final bool isTimeOut;

  const ExamData({
    required this.questions,
    this.currentIndex = 0,
    this.selectedAnswers = const {},
    this.result,
    this.remainingTimeInMinuts = 0,
    this.totalTimeInMinuts = 0,
    this.isTimeOut = false,
  });

  ExamData copyWith({
    List<QuestionEntity>? questions,
    int? currentIndex,
    Map<String, String>? selectedAnswers,
    CheckQuestionsResponseEntity? result,
    int? remainingTimeInMinuts,
    int? totalTimeInMinuts,
    bool? isTimeOut,
  }) {
    return ExamData(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      result: result ?? this.result,
      remainingTimeInMinuts:
          remainingTimeInMinuts ?? this.remainingTimeInMinuts,
      totalTimeInMinuts: totalTimeInMinuts ?? this.totalTimeInMinuts,
      isTimeOut: isTimeOut ?? this.isTimeOut,
    );
  }

  // UI Helper
  QuestionEntity? get currentQuestion =>
      questions.isNotEmpty &&
          currentIndex >= 0 &&
          currentIndex < questions.length
      ? questions[currentIndex]
      : null;

  int get answeredQuestionsCount => selectedAnswers.length;

  /// Formats the remaining time to mm:ss
  String get formattedRemainingTime {
    if (remainingTimeInMinuts <= 0) return "00:00";
    final int minutes = remainingTimeInMinuts ~/ 60;
    final int seconds = remainingTimeInMinuts % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool get isLastQuestion =>
      questions.isNotEmpty && currentIndex == questions.length - 1;

  @override
  List<Object?> get props => [
    questions,
    currentIndex,
    selectedAnswers,
    result,
    remainingTimeInMinuts,
    totalTimeInMinuts,
    isTimeOut,
  ];
}
