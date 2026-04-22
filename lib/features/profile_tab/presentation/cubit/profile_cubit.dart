import 'package:bloc/bloc.dart';
import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/profile_tab/domain/use_cases/get_profile_use_case.dart';
import 'package:exams_app/features/profile_tab/presentation/cubit/profile_events.dart';
import 'package:exams_app/features/profile_tab/presentation/cubit/profile_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/profile_user_entity.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  ProfileUserEntity? _originalUser;

  ProfileCubit(this.getProfileUseCase) : super(const ProfileState());

  void doEvent(ProfileEvents event) {
    switch (event) {
      case GetProfileDataEvent():
        _getProfileData(event.token);
        break;
      case ProfileDataChangedEvent():
        _checkIfDataChanged(event.user);
        break;
    }
  }

  Future<void> _getProfileData(String? token) async {
    // If data is already loaded, don't fetch again
    if (state.profileState.data != null) return;

    emit(
      state.copyWith(
        stateParam: const BaseState<ProfileUserEntity>(isLoading: true),
      ),
    );
    final result = await getProfileUseCase.call();

    switch (result) {
      case SuccessBaseResponse<ProfileUserEntity>():
        _originalUser = result.data;
        emit(
          state.copyWith(
            stateParam: BaseState<ProfileUserEntity>(
              isLoading: false,
              data: result.data,
            ),
          ),
        );
        break;
      case ErrorBaseResponse<ProfileUserEntity>():
        emit(
          state.copyWith(
            stateParam: BaseState<ProfileUserEntity>(
              isLoading: false,
              errorMessage: result.errorMessage,
            ),
          ),
        );
        break;
    }
  }

  void _checkIfDataChanged(ProfileUserEntity newUser) {
    if (_originalUser == null) return;

    final isChanged =
        newUser.username != _originalUser?.username ||
        newUser.firstName != _originalUser?.firstName ||
        newUser.lastName != _originalUser?.lastName ||
        newUser.email != _originalUser?.email ||
        newUser.phoneNumber != _originalUser?.phoneNumber;

    emit(state.copyWith(isDataChanged: isChanged));
  }
}
