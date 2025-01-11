import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../entities/contact_info_entity.dart';
import '../repositories/contact_info_repository.dart';

class ContactInfoUseCase
    implements UseCase<BaseResponseEntity<ContactInfoEntity>, NoParams> {
  final ContactInfoRepository repository;

  ContactInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity<ContactInfoEntity>>> call(
          NoParams params) =>
      repository.getContactInfo();
}
