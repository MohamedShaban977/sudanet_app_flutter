part of 'contact_info_cubit.dart';

abstract class ContactInfoState extends Equatable {
  const ContactInfoState();

  @override
  List<Object> get props => [];
}

class ContactInfoInitial extends ContactInfoState {}

class GetContactInfoLoadingState extends ContactInfoState {}

class GetContactInfoSuccessState extends ContactInfoState {
  final BaseResponseEntity<ContactInfoEntity> response;

  const GetContactInfoSuccessState({required this.response});

  @override
  List<Object> get props => [response];
}

class GetContactInfoErrorState extends ContactInfoState {
  final String error;

  const GetContactInfoErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
