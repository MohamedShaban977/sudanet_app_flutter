import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../../domain/entities/contact_info_entity.dart';
import '../../domain/use_cases/contact_info_use_case.dart';

part 'contact_info_state.dart';

class ContactInfoCubit extends Cubit<ContactInfoState> {
  ContactInfoCubit({required this.contactInfoUseCase})
      : super(ContactInfoInitial());
  final ContactInfoUseCase contactInfoUseCase;

  ContactInfoCubit get(context) => BlocProvider.of(context);

  late ContactInfoEntity contactInfo = const ContactInfoEntity(
    about: '-',
    facebookLink: '-',
    instegramLink: '-',
    mail1: '-',
    mail2: '-',
    mail3: '-',
    phone1: '-',
    phone2: '-',
    phone3: '-',
    whatsapp1: '-',
    whatsapp2: '-',
    whatsapp3: '',
    twitterLink: '-',
    youtubeLink: '-',
    terms: '-',
  );

  Future<void> getContactInfo() async {
    emit(GetContactInfoLoadingState());
    Either<Failure, BaseResponseEntity<ContactInfoEntity>> response =
        await contactInfoUseCase.call(NoParams());

    response.fold(
        (failure) => emit(
              GetContactInfoErrorState(
                error: HandleFailure.mapFailureToMsg(failure),
              ),
            ), (response) {
      contactInfo = response.data!;
      emit(GetContactInfoSuccessState(response: response));
    });
  }
}
