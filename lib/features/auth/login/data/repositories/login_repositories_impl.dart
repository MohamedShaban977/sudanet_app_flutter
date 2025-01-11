import 'package:dartz/dartz.dart';

import '../../../../../core/api/service_response.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/entities/login_entity.dart';
import '../../domain/repositories/login_repositories.dart';
import '../../presentation/manger/user_secure_storage.dart';
import '../data_sources/login_data_source.dart';
import '../models/login_request.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginDataSource dataSource;

  LoginRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, BaseResponseEntity<UserEntity>>> loginUser(
      LoginRequest request) async {
    // try {
    //   final res = await dataSource.loginDataSource(request);
    //   res.refresh.isNotEmpty
    //       ? await sl<CacheHelper>().saveData(
    //           key: Constants.cachedDataLogin,
    //           value: json.encode(res.access),
    //         )
    //       : null;
    //   return res.refresh.isNotEmpty
    //       ? Right(res)
    //       : left(const ServerFailure(AppStrings.errorOccurred));
    // } on ServerException catch (error) {
    //   return left(ServerFailure(error.message));
    // }

    try {
      var res = await dataSource.loginDataSource(request);
      res.success ? await UserSecureStorage.setUser(data: res.data!) : null;

      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
