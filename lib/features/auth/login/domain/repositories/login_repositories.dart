import 'package:dartz/dartz.dart';

import '../../../../../core/api/service_response.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/login_request.dart';
import '../entities/login_entity.dart';

abstract class LoginRepository {
  Future<Either<Failure, BaseResponseEntity<UserEntity>>> loginUser(
      LoginRequest request);
}
