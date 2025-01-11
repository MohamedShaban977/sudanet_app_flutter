import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../entities/contact_info_entity.dart';

abstract class ContactInfoRepository {
  Future<Either<Failure, BaseResponseEntity<ContactInfoEntity>>>
      getContactInfo();
}
