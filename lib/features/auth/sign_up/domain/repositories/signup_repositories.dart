import 'package:dartz/dartz.dart';

import '../../../../../core/api/service_response.dart';
import '../../../../../core/error/failures.dart';
import '../../../login/domain/entities/login_entity.dart';
import '../../data/models/signup_request.dart';

abstract class SignUpRepository {
  Future<Either<Failure, BaseResponseEntity<UserEntity>>> signUpUser(
      SignUpRequest request);
}
