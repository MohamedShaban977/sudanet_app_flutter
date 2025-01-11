import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../categories/domain/entities/categories_entity.dart';
import '../../../courses/domain/entities/courses_entity.dart';
import '../entities/slider_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, CollectionResponseEntity<SliderEntity>>> getSliders();

  Future<Either<Failure, CollectionResponseEntity<CoursesEntity>>>
      getCoursesRepo();

  Future<Either<Failure, CollectionResponseEntity<CategoriesEntity>>>
      getCategoriesRepo();
}
