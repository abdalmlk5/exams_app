import 'package:exams_app/features/exams/data/models/exam_model.dart';

import '../../../../config/base_state/base_state.dart';

class ExamsState {
  BaseState<List<ExamModel>> examsState = BaseState<List<ExamModel>>(
    isLoading: true,
    data: null,
  );
  ExamsState({BaseState<List<ExamModel>>? state}) {
    examsState =
        state ?? BaseState<List<ExamModel>>(isLoading: true, data: null);
  }

  ExamsState copyWith({BaseState<List<ExamModel>>? stateParam}) {
    return ExamsState(state: stateParam ?? examsState);
  }
}
