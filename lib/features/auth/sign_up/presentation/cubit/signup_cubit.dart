import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/api/service_response.dart';
import '../../../../../core/error/failures.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../../data/models/signup_request.dart';
import '../../domain/use_cases/signup_use_case.dart';

part 'signup_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit({required this.signupUseCases}) : super(SignUpInitial());

  final SignUpUseCases signupUseCases;

  SignUpCubit get(context) => BlocProvider.of(context);

  Future<void> signUp(SignUpRequest request) async {
    emit(SignUpLoadingState());
    Either<Failure, BaseResponseEntity<UserEntity>> response =
        await signupUseCases.call(request);

    response.fold(
      (failure) =>
          emit(SignUpErrorState(error: HandleFailure.mapFailureToMsg(failure))),
      (response) => emit(SignUpSuccessState(response: response)),
    );
  }

  IconData suffix = Icons.remove_red_eye;
  bool isPassword = true;

  void changePassVisibility() {
    emit(PassUnVisibilityState());
    isPassword = !isPassword;
    suffix = isPassword ? Icons.remove_red_eye : Icons.visibility_off_outlined;
    emit(PassVisibilityState());
  }
}
