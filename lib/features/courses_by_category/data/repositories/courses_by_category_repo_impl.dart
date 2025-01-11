import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../courses/domain/entities/courses_entity.dart';
import '../../domain/repositories/courses_by_category_repo.dart';
import '../data_sources/courses_by_category_data_source.dart';

class CoursesByCategoryRepoImpl implements CourseByCategoryRepo {
  final CoursesByCategoryDataSource dataSource;

  CoursesByCategoryRepoImpl({required this.dataSource});

  @override
  Future<Either<Failure, CollectionResponseEntity<CoursesEntity>>>
      getCoursesByCategory(String categoryId) async {
    try {
      final res = await dataSource.getCoursesByCategoryDataSource(categoryId);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
