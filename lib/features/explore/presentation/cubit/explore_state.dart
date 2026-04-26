import 'package:equatable/equatable.dart';
import 'package:exams_app/features/explore/domain/entities/subject_entity.dart';

import '../../../../config/base_state/base_state.dart';

class ExploreState extends Equatable {
  final BaseState<List<SubjectEntity>> exploreState;

  const ExploreState({
    this.exploreState = const BaseState<List<SubjectEntity>>(isLoading: true),
  });

  ExploreState copyWith({BaseState<List<SubjectEntity>>? stateParam}) {
    return ExploreState(exploreState: stateParam ?? exploreState);
  }

  @override
  List<Object?> get props => [exploreState];
}
