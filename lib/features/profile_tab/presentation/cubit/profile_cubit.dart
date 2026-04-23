import 'package:bloc/bloc.dart';
import 'package:exams_app/config/base_response/base_response.dart';
import 'package:exams_app/features/profile_tab/domain/use_cases/get_profile_use_case.dart';
import 'package:exams_app/features/profile_tab/domain/use_cases/update_profile_use_case.dart';
import 'package:exams_app/features/profile_tab/presentation/cubit/profile_events.dart';
import 'package:exams_app/features/profile_tab/presentation/cubit/profile_state.dart';
import 'package:injectable/injectable.dart';

import '../../../../config/base_state/base_state.dart';
import '../../domain/entities/profile_user_entity.dart';

@lazySingleton
class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  ProfileUserEntity? _originalUser;
  ProfileUserEntity? _currentUser;

  ProfileCubit(this.getProfileUseCase, this.updateProfileUseCase)
    : super(const ProfileState());

  void doEvent(ProfileEvents event) {
    switch (event) {
      case GetProfileDataEvent():
        _getProfileData();
        break;
      case ProfileDataChangedEvent():
        _currentUser = event.user;
        _checkIfDataChanged(event.user);
        break;
      case UpdateProfileEvent():
        _updateProfile();
        break;
    }
  }

  Future<void> _getProfileData() async {
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

  Future<void> _updateProfile() async {
    if (_currentUser == null || _originalUser == null) return;

    final diff = <String, dynamic>{};
    if (_currentUser?.username != _originalUser?.username) {
      diff['username'] = _currentUser?.username;
    }
    if (_currentUser?.firstName != _originalUser?.firstName) {
      diff['firstName'] = _currentUser?.firstName;
    }
    if (_currentUser?.lastName != _originalUser?.lastName) {
      diff['lastName'] = _currentUser?.lastName;
    }
    if (_currentUser?.email != _originalUser?.email) {
      diff['email'] = _currentUser?.email;
    }
    if (_currentUser?.phoneNumber != _originalUser?.phoneNumber) {
      diff['phone'] = _currentUser?.phoneNumber;
    }

    if (diff.isEmpty) return;

    emit(
      state.copyWith(
        status: ProfileStatus.loading,
        stateParam: state.profileState.copyWith(isLoading: true),
      ),
    );

    final result = await updateProfileUseCase.call(diff);

    switch (result) {
      case SuccessBaseResponse<ProfileUserEntity>():
        _originalUser = result.data;
        emit(
          state.copyWith(
            isDataChanged: false,
            status: ProfileStatus.updateSuccess,
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
            status: ProfileStatus.error,
            stateParam: state.profileState.copyWith(
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
