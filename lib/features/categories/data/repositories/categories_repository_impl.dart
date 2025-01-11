import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/categories_entity.dart';
import '../../domain/repositories/categories_repository.dart';
import '../data_sources/categories_data_source.dart';

class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesDataSource dataSource;

  CategoriesRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, CollectionResponseEntity<CategoriesEntity>>>
      getCategoriesRepo() async {
    try {
      final res = await dataSource.getAllCategories();
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
