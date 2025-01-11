import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/courses_entity.dart';
import '../../domain/repositories/courses_repository.dart';
import '../data_sources/courses_data_sources.dart';

class CourseRepositoryImpl implements CourseRepository {
  final CoursesDataSource dataSource;

  CourseRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, CollectionResponseEntity<CoursesEntity>>>
      getCourses() async {
    try {
      final res = await dataSource.getCoursesDataSource();
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
