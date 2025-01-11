part of 'forget_password_cubit.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoadingState extends ForgetPasswordState {}

class ForgetPasswordSuccessState extends ForgetPasswordState {
  final BaseResponseEntity<String> response;

  const ForgetPasswordSuccessState({required this.response});

  @override
  List<Object> get props => [response];
}

class ForgetPasswordErrorState extends ForgetPasswordState {
  final String error;

  const ForgetPasswordErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class PassVisibilityState extends ForgetPasswordState {}

class PassUnVisibilityState extends ForgetPasswordState {}
