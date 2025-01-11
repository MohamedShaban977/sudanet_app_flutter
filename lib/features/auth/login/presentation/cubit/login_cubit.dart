import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/api/service_response.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/login_request.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/use_cases/login_use_case.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginUseCases}) : super(LoginInitial());

  final LoginUseCases loginUseCases;

  LoginCubit get(context) => BlocProvider.of(context);

  Future<void> login(LoginRequest request) async {
    emit(LoginLoadingState());
    Either<Failure, BaseResponseEntity<UserEntity>> response =
        await loginUseCases.call(request);

    response.fold(
      (failure) =>
          emit(LoginErrorState(error: HandleFailure.mapFailureToMsg(failure))),
      (response) => emit(LoginSuccessState(response: response)),
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
