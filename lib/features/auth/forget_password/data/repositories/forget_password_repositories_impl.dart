import 'package:dartz/dartz.dart';

import '../../../../../core/api/service_response.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/forget_password_repositories.dart';
import '../data_sources/forget_password_data_source.dart';
import '../models/forget_password_request.dart';

class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgetPasswordDataSource dataSource;

  ForgetPasswordRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, BaseResponseEntity<String>>> forgetPassword(
      ForgetPasswordRequest request) async {
    try {
      final res = await dataSource.forgetPasswordDataSource(request);

      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
