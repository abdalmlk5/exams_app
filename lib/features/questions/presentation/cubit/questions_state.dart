part of 'questions_cubit.dart';

class ExamData extends Equatable {
  final List<QuestionEntity> questions;
  final int currentIndex;
  final Map<String, String> selectedAnswers; // questionId -> answerKey
  final CheckQuestionsResponseEntity? result;

  // Timer metadata
  final int remainingTimeInSeconds;
  final int totalTimeInMinutes;
  final bool isTimeOut;

  const ExamData({
    required this.questions,
    this.currentIndex = 0,
    this.selectedAnswers = const {},
    this.result,
    this.remainingTimeInSeconds = 0,
    this.totalTimeInMinutes = 0,
    this.isTimeOut = false,
  });

  ExamData copyWith({
    List<QuestionEntity>? questions,
    int? currentIndex,
    Map<String, String>? selectedAnswers,
    CheckQuestionsResponseEntity? result,
    int? remainingTimeInSeconds,
    int? totalTimeInMinutes,
    bool? isTimeOut,
  }) {
    return ExamData(
      questions: questions ?? this.questions,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      result: result ?? this.result,
      remainingTimeInSeconds:
          remainingTimeInSeconds ?? this.remainingTimeInSeconds,
      totalTimeInMinutes: totalTimeInMinutes ?? this.totalTimeInMinutes,
      isTimeOut: isTimeOut ?? this.isTimeOut,
    );
  }

  // UI Helpers
  QuestionEntity? get currentQuestion =>
      questions.isNotEmpty &&
          currentIndex >= 0 &&
          currentIndex < questions.length
      ? questions[currentIndex]
      : null;

  int get answeredQuestionsCount => selectedAnswers.length;

  /// Formats the remaining time to mm:ss
  String get formattedRemainingTime {
    if (remainingTimeInSeconds <= 0) return "00:00";
    final int minutes = remainingTimeInSeconds ~/ 60;
    final int seconds = remainingTimeInSeconds % 60;
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
    remainingTimeInSeconds,
    totalTimeInMinutes,
    isTimeOut,
  ];
}
