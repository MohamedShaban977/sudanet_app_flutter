import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../categories/domain/entities/categories_entity.dart';
import '../../../courses/domain/entities/courses_entity.dart';
import '../../domain/entities/slider_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../data_sources/home_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDataSource dataSource;

  HomeRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, CollectionResponseEntity<CategoriesEntity>>>
      getCategoriesRepo() async {
    try {
      final res = await dataSource.getCategoriesDataSource();
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, CollectionResponseEntity<CoursesEntity>>>
      getCoursesRepo() async {
    try {
      final res = await dataSource.getCoursesDataSource();
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, CollectionResponseEntity<SliderEntity>>>
      getSliders() async {
    try {
      final res = await dataSource.getSliders();
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
