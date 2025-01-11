part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final BaseResponseEntity<UserEntity> response;

  const LoginSuccessState({required this.response});

  @override
  List<Object> get props => [response];
}

class LoginErrorState extends LoginState {
  final String error;

  const LoginErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class PassVisibilityState extends LoginState {}

class PassUnVisibilityState extends LoginState {}
