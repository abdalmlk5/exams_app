import '../../../../config/base_state/base_state.dart';
import '../../data/models/subject_model.dart';

class ExploreState {
  final BaseState<List<SubjectModel>> exploreState;

  const ExploreState({
    this.exploreState = const BaseState<List<SubjectModel>>(isLoading: true),
  });

  ExploreState copyWith({BaseState<List<SubjectModel>>? stateParam}) {
    return ExploreState(exploreState: stateParam ?? exploreState);
  }
}
