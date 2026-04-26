import 'package:equatable/equatable.dart';
import 'package:exams_app/features/exams/domain/entities/exam_entity.dart';

import '../../../../config/base_state/base_state.dart';

class ExamsState extends Equatable {
  final BaseState<List<ExamEntity>> examsState;

  const ExamsState({
    this.examsState = const BaseState<List<ExamEntity>>(isLoading: true),
  });

  ExamsState copyWith({BaseState<List<ExamEntity>>? stateParam}) {
    return ExamsState(examsState: stateParam ?? examsState);
  }

  @override
  List<Object?> get props => [examsState];
}
