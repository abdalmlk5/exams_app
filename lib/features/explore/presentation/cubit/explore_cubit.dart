import 'package:exams_app/config/cache/cache_helper.dart';
import 'package:exams_app/core/utils/app_keys.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_response/base_response.dart';
import '../../../../config/base_state/base_state.dart';
import '../../data/models/subject_model.dart';
import '../../domain/use_cases/get_subjects_use_case.dart';
import 'explore_event.dart';
import 'explore_state.dart';

@injectable
class ExploreCubit extends Cubit<ExploreState> {
  List<SubjectModel> allSubjects = [];
  final GetSubjectsUseCase getSubjectsUseCase;
  final CacheHelper _cacheHelper;

  ExploreCubit(this.getSubjectsUseCase, this._cacheHelper)
    : super(ExploreState()) {
    _getSubjects();
  }

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

  void _getSubjects({String? token}) async {
    String? effectiveToken =
        token ?? await _cacheHelper.readData(key: AppKeys.tokenKey);

    if (effectiveToken == null) {
      emit(
        state.copyWith(
          stateParam: const BaseState<List<SubjectModel>>(
            isLoading: false,
            errorMessage: "No token found",
          ),
        ),
      );
      return;
    }

    emit(
      state.copyWith(
        stateParam: const BaseState<List<SubjectModel>>(isLoading: true),
      ),
    );
    final result = await getSubjectsUseCase.call();
    switch (result) {
      case SuccessBaseResponse():
        allSubjects.clear();
        allSubjects = result.data;
        emit(
          state.copyWith(
            stateParam: BaseState<List<SubjectModel>>(
              isLoading: false,
              data: result.data,
            ),
          ),
        );
      case ErrorBaseResponse<List<SubjectModel>>():
        emit(
          state.copyWith(
            stateParam: BaseState<List<SubjectModel>>(
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
        stateParam: BaseState<List<SubjectModel>>(
          isLoading: false,
          data: filteredSubjects,
        ),
      ),
    );
  }
}
