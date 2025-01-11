import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/change_password_request.dart';
import '../../data/models/personal_info_response.dart';
import '../entities/personal_info_entity.dart';
import '../entities/user_my_courses_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, BaseResponseEntity<PersonInfoEntity>>> getPersonInfo();

  Future<Either<Failure, BaseResponseEntity<bool>>> savePersonInfo(
      PersonInfoResponse request);

  Future<Either<Failure, BaseResponseEntity<bool>>> changePassword(
      ChangePasswordRequest request);

  Future<Either<Failure, CollectionResponseEntity<UserMyCoursesEntity>>>
      getUserMyCourses();
}
