import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../courses/domain/entities/courses_entity.dart';

abstract class CourseByCategoryRepo {
  Future<Either<Failure, CollectionResponseEntity<CoursesEntity>>>
      getCoursesByCategory(String categoryId);
}
