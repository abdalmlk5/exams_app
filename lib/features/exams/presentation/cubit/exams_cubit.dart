import 'package:exams_app/config/cache_helper/cache_helper.dart';
import 'package:exams_app/features/exams/data/models/exam_model.dart';
import 'package:exams_app/features/exams/domain/use_cases/get_exams_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import 'exams_event.dart';
import 'exams_state.dart';

@injectable
class ExamsCubit extends Cubit<ExamsState> {
  final GetExamsUseCase getSubjectsUseCase;

  ExamsCubit(this.getSubjectsUseCase) : super(ExamsState()) {
    _getSubjects();
  }

  void doEvent(ExamsEvent event) {
    switch (event) {
      case GetAllExamsEvent():
        _getSubjects();
        break;
    }
  }

  void _getSubjects({String? token}) async {
    String? effectiveToken = token ?? await CacheHelper.getToken();

    if (effectiveToken == null) {
      emit(
        state.copyWith(
          stateParam: const BaseState<List<ExamModel>>(
            isLoading: false,
            errorMessage: "No token found",
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        stateParam: const BaseState<List<ExamModel>>(isLoading: true),
      ),
    );
    final result = await getSubjectsUseCase.call(effectiveToken);
    switch (result) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            stateParam: BaseState<List<ExamModel>>(
              isLoading: false,
              data: result.data,
            ),
          ),
        );
      case ErrorBaseResponse<List<ExamModel>>():
        emit(
          state.copyWith(
            stateParam: BaseState<List<ExamModel>>(
              isLoading: false,
              errorMessage: result.errorMessage,
            ),
          ),
        );
    }
  }
}
