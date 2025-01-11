import 'package:dartz/dartz.dart';

import '../../../../../core/api/service_response.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../../domain/repositories/signup_repositories.dart';
import '../data_sources/signup_data_source.dart';
import '../models/signup_request.dart';

class SignUpRepositoryImpl implements SignUpRepository {
  final SignUpDataSource dataSource;

  SignUpRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, BaseResponseEntity<UserEntity>>> signUpUser(
      SignUpRequest request) async {
    try {
      final res = await dataSource.signUpDataSource(request);

      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
