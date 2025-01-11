import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../../data/models/change_password_request.dart';
import '../../data/models/personal_info_response.dart';
import '../../domain/entities/personal_info_entity.dart';
import '../../domain/entities/user_my_courses_entity.dart';
import '../../domain/use_cases/profile_use_cases.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.getPersonalInfoUseCase,
    required this.savePersonalInfoUseCase,
    required this.changePasswordUseCase,
    required this.getUserMyCoursesUseCase,
  }) : super(ProfileInitial());

  final GetPersonalInfoUseCase getPersonalInfoUseCase;
  final SavePersonalInfoUseCase savePersonalInfoUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final GetUserMyCoursesUseCase getUserMyCoursesUseCase;

  ProfileCubit get(context) => BlocProvider.of(context);

  Future<void> getPersonalInfo() async {
    emit(GetPersonalInfoLoadingState());
    Either<Failure, BaseResponseEntity<PersonInfoEntity>> response =
        await getPersonalInfoUseCase.call(NoParams());
    response.fold(
      (failure) => emit(GetPersonalInfoErrorState(
          error: HandleFailure.mapFailureToMsg(failure))),
      (response) => emit(GetPersonalInfoSuccessState(response: response)),
    );
  }

  final List<UserMyCoursesEntity> myCourses = [];

  Future<void> getUserMyCourses() async {
    emit(GetUserMyCoursesLoadingState());
    Either<Failure, CollectionResponseEntity<UserMyCoursesEntity>> response =
        await getUserMyCoursesUseCase.call(NoParams());
    response.fold(
        (failure) => emit(GetUserMyCoursesErrorState(
            error: HandleFailure.mapFailureToMsg(failure))), (response) {
      myCourses.clear();
      myCourses.addAll(response.data!);
      emit(GetUserMyCoursesSuccessState(response: response));
    });
  }

  Future<void> savePersonalInfo(PersonInfoResponse request) async {
    emit(SavePersonalInfoLoadingState());
    Either<Failure, BaseResponseEntity<bool>> response =
        await savePersonalInfoUseCase.call(request);
    response.fold(
      (failure) => emit(SavePersonalInfoErrorState(
          error: HandleFailure.mapFailureToMsg(failure))),
      (response) => emit(SavePersonalInfoSuccessState(response: response)),
    );
  }

  Future<void> changePassword(ChangePasswordRequest request) async {
    emit(ChangePasswordLoadingState());
    Either<Failure, BaseResponseEntity<bool>> response =
        await changePasswordUseCase.call(request);
    response.fold(
      (failure) => emit(ChangePasswordErrorState(
          error: HandleFailure.mapFailureToMsg(failure))),
      (response) => emit(ChangePasswordSuccessState(response: response)),
    );
  }

  IconData suffixCurrantPassword = Icons.remove_red_eye;
  bool isCurrantPassword = true;

  void changeCurrantPasswordVisibility() {
    emit(ChangePassLoadingState());
    isCurrantPassword = !isCurrantPassword;
    suffixCurrantPassword = isCurrantPassword
        ? Icons.remove_red_eye
        : Icons.visibility_off_outlined;
    emit(ChangeCurrantPasswordVisibilityState());
  }

  IconData suffixNewPassword = Icons.remove_red_eye;
  bool isNewPassword = true;

  void changeNewPasswordVisibility() {
    emit(ChangePassLoadingState());
    isNewPassword = !isNewPassword;
    suffixNewPassword =
        isNewPassword ? Icons.remove_red_eye : Icons.visibility_off_outlined;
    emit(ChangeCurrantPasswordVisibilityState());
  }

  IconData suffixConfirmPassword = Icons.remove_red_eye;
  bool isConfirmPassword = true;

  void changeConfirmPasswordVisibility() {
    emit(ChangePassLoadingState());
    isConfirmPassword = !isConfirmPassword;
    suffixConfirmPassword = isConfirmPassword
        ? Icons.remove_red_eye
        : Icons.visibility_off_outlined;
    emit(ChangeConfirmPasswordVisibilityState());
  }
}
