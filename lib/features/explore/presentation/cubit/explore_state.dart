import '../../../../config/base_state/base_state.dart';
import '../../data/models/subject_model.dart';

class ExploreState {
  BaseState<List<SubjectModel>> exploreState = BaseState<List<SubjectModel>>(
    isLoading: true,
    data: null,
  );
  ExploreState({BaseState<List<SubjectModel>>? state}) {
    exploreState =
        state ?? BaseState<List<SubjectModel>>(isLoading: true, data: null);
  }

  ExploreState copyWith({BaseState<List<SubjectModel>>? stateParam}) {
    return ExploreState(state: stateParam ?? exploreState);
  }
}
