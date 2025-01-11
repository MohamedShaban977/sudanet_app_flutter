import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../entities/courses_entity.dart';

abstract class CourseRepository {
  Future<Either<Failure, CollectionResponseEntity<CoursesEntity>>> getCourses();
}
