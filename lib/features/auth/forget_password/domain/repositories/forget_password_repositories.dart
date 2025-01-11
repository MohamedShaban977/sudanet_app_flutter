import 'package:dartz/dartz.dart';

import '../../../../../core/api/service_response.dart';
import '../../../../../core/error/failures.dart';
import '../../data/models/forget_password_request.dart';

abstract class ForgetPasswordRepository {
  Future<Either<Failure, BaseResponseEntity<String>>> forgetPassword(
      ForgetPasswordRequest request);
}
