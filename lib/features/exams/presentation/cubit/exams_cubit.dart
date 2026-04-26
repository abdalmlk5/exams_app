import 'package:exams_app/features/exams/domain/entities/exam_entity.dart';
import 'package:exams_app/features/exams/domain/use_cases/get_exams_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import 'exams_event.dart';
import 'exams_state.dart';

@injectable
class ExamsCubit extends Cubit<ExamsState> {
  final GetExamsUseCase getExamsUseCase;

  ExamsCubit(this.getExamsUseCase) : super(const ExamsState());

  void doEvent(ExamsEvent event) {
    switch (event) {
      case GetAllExamsEvent():
        _getExams(subject: event.subject);
        break;
    }
  }

  void _getExams({String? subject}) async {
    emit(
      state.copyWith(
        stateParam: const BaseState<List<ExamEntity>>(isLoading: true),
      ),
    );
    final result = await getExamsUseCase.call(subject: subject);
    switch (result) {
      case SuccessBaseResponse():
        emit(
          state.copyWith(
            stateParam: BaseState<List<ExamEntity>>(
              isLoading: false,
              data: result.data,
            ),
          ),
        );
      case ErrorBaseResponse<List<ExamEntity>>():
        emit(
          state.copyWith(
            stateParam: BaseState<List<ExamEntity>>(
              isLoading: false,
              errorMessage: result.errorMessage,
            ),
          ),
        );
    }
  }
}
