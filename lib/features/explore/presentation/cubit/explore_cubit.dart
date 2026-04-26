import 'package:exams_app/features/explore/domain/entities/subject_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import '../../domain/use_cases/get_subjects_use_case.dart';
import 'explore_event.dart';
import 'explore_state.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  List<SubjectEntity> allSubjects = [];
  final GetSubjectsUseCase getSubjectsUseCase;

  ExploreCubit(this.getSubjectsUseCase) : super(const ExploreState());

  void doEvent(ExploreEvent event) {
    switch (event) {
      case GetAllSubjectsEvent():
        _getSubjects();
        break;
      case GetFilteredSubjectsListEvent():
        _getFilteredSubjectsList(event.searchText);
        break;
    }
  }

  void _getSubjects() async {
    emit(
      state.copyWith(
        stateParam: const BaseState<List<SubjectEntity>>(isLoading: true),
      ),
    );
    final result = await getSubjectsUseCase.call();
    switch (result) {
      case SuccessBaseResponse():
        allSubjects = result.data;
        emit(
          state.copyWith(
            stateParam: BaseState<List<SubjectEntity>>(
              isLoading: false,
              data: result.data,
            ),
          ),
        );
      case ErrorBaseResponse<List<SubjectEntity>>():
        emit(
          state.copyWith(
            stateParam: BaseState<List<SubjectEntity>>(
              isLoading: false,
              errorMessage: result.errorMessage,
            ),
          ),
        );
    }
  }

  void _getFilteredSubjectsList(String searchText) {
    final filteredSubjects = allSubjects
        .where(
          (subject) =>
              subject.name?.toLowerCase().contains(searchText.toLowerCase()) ??
              false,
        )
        .toList();
    emit(
      state.copyWith(
        stateParam: BaseState<List<SubjectEntity>>(
          isLoading: false,
          data: filteredSubjects,
        ),
      ),
    );
  }
}
