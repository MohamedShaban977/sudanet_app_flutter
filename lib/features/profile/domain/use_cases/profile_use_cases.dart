import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../../data/models/change_password_request.dart';
import '../../data/models/personal_info_response.dart';
import '../entities/personal_info_entity.dart';
import '../entities/user_my_courses_entity.dart';
import '../repositories/profile_repository.dart';

class GetPersonalInfoUseCase
    implements UseCase<BaseResponseEntity<PersonInfoEntity>, NoParams> {
  final ProfileRepository repository;

  GetPersonalInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity<PersonInfoEntity>>> call(
          NoParams params) =>
      repository.getPersonInfo();
}

class SavePersonalInfoUseCase
    implements UseCase<BaseResponseEntity<bool>, PersonInfoResponse> {
  final ProfileRepository repository;

  SavePersonalInfoUseCase({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity<bool>>> call(
          PersonInfoResponse params) =>
      repository.savePersonInfo(params);
}

class ChangePasswordUseCase
    implements UseCase<BaseResponseEntity<bool>, ChangePasswordRequest> {
  final ProfileRepository repository;

  ChangePasswordUseCase({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity<bool>>> call(
          ChangePasswordRequest params) =>
      repository.changePassword(params);
}

class GetUserMyCoursesUseCase
    implements
        UseCase<CollectionResponseEntity<UserMyCoursesEntity>, NoParams> {
  final ProfileRepository repository;

  GetUserMyCoursesUseCase({required this.repository});

  @override
  Future<Either<Failure, CollectionResponseEntity<UserMyCoursesEntity>>> call(
          NoParams params) =>
      repository.getUserMyCourses();
}
