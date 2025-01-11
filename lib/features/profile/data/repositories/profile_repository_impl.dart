import 'package:dartz/dartz.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/personal_info_entity.dart';
import '../../domain/entities/user_my_courses_entity.dart';
import '../../domain/repositories/profile_repository.dart';
import '../data_sources/profile_info_data_source.dart';
import '../models/change_password_request.dart';
import '../models/personal_info_response.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileDataSource dataSource;

  const ProfileRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, BaseResponseEntity<PersonInfoEntity>>>
      getPersonInfo() async {
    try {
      final res = await dataSource.getPersonalInfo();
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity<bool>>> savePersonInfo(
      PersonInfoResponse request) async {
    try {
      final res = await dataSource.savePersonalInfo(request);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity<bool>>> changePassword(
      ChangePasswordRequest request) async {
    try {
      final res = await dataSource.changePassword(request);
      return res.data.orEmptyB()
          ? Right(res)
          : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, CollectionResponseEntity<UserMyCoursesEntity>>>
      getUserMyCourses() async {
    try {
      final res = await dataSource.getUserMyCourses();
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
