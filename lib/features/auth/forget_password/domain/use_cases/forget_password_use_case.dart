import 'package:dartz/dartz.dart';

import '../../../../../core/api/service_response.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/useCases/use_case.dart';
import '../../data/models/forget_password_request.dart';
import '../repositories/forget_password_repositories.dart';

class ForgetPasswordUseCases
    implements UseCase<BaseResponseEntity<String>, ForgetPasswordRequest> {
  final ForgetPasswordRepository repository;

  ForgetPasswordUseCases({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity<String>>> call(
          ForgetPasswordRequest request) =>
      repository.forgetPassword(request);
}
