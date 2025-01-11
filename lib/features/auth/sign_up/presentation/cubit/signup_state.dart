part of 'signup_cubit.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class SignUpSuccessState extends SignUpState {
  final BaseResponseEntity<UserEntity> response;

  const SignUpSuccessState({required this.response});

  @override
  List<Object> get props => [response];
}

class SignUpErrorState extends SignUpState {
  final String error;

  const SignUpErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

class PassVisibilityState extends SignUpState {}

class PassUnVisibilityState extends SignUpState {}
