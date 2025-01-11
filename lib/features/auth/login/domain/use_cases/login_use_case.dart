import 'package:dartz/dartz.dart';

import '../../../../../core/api/service_response.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/useCases/use_case.dart';
import '../../data/models/login_request.dart';
import '../entities/login_entity.dart';
import '../repositories/login_repositories.dart';

class LoginUseCases
    implements UseCase<BaseResponseEntity<UserEntity>, LoginRequest> {
  final LoginRepository repository;

  LoginUseCases({required this.repository});

  @override
  Future<Either<Failure, BaseResponseEntity<UserEntity>>> call(
          LoginRequest request) =>
      repository.loginUser(request);
}
