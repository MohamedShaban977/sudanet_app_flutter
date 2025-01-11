part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class GetPersonalInfoLoadingState extends ProfileState {}

class GetPersonalInfoSuccessState extends ProfileState {
  final BaseResponseEntity<PersonInfoEntity> response;

  const GetPersonalInfoSuccessState({required this.response});
}

class GetPersonalInfoErrorState extends ProfileState {
  final String error;

  const GetPersonalInfoErrorState({required this.error});
}

///
///
class GetUserMyCoursesLoadingState extends ProfileState {}

class GetUserMyCoursesSuccessState extends ProfileState {
  final CollectionResponseEntity<UserMyCoursesEntity> response;

  const GetUserMyCoursesSuccessState({required this.response});
}

class GetUserMyCoursesErrorState extends ProfileState {
  final String error;

  const GetUserMyCoursesErrorState({required this.error});
}

///
class SavePersonalInfoLoadingState extends ProfileState {}

class SavePersonalInfoSuccessState extends ProfileState {
  final BaseResponseEntity<bool> response;

  const SavePersonalInfoSuccessState({required this.response});
}

class SavePersonalInfoErrorState extends ProfileState {
  final String error;

  const SavePersonalInfoErrorState({required this.error});
}

///
class ChangePasswordLoadingState extends ProfileState {}

class ChangePasswordSuccessState extends ProfileState {
  final BaseResponseEntity<bool> response;

  const ChangePasswordSuccessState({required this.response});
}

class ChangePasswordErrorState extends ProfileState {
  final String error;

  const ChangePasswordErrorState({required this.error});
}

class ChangePassLoadingState extends ProfileState {}

///
class ChangeCurrantPasswordVisibilityState extends ProfileState {}

///
class ChangeNewPasswordVisibilityState extends ProfileState {}

///
class ChangeConfirmPasswordVisibilityState extends ProfileState {}
