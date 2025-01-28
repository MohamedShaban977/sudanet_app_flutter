import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../../../categories/domain/entities/categories_entity.dart';
import '../../../courses/domain/entities/courses_entity.dart';
import '../entities/slider_entity.dart';
import '../repositories/home_repository.dart';

class HomeCategoriesUseCases
    implements UseCase<CollectionResponseEntity<CategoriesEntity>, NoParams> {
  final HomeRepository repository;

  HomeCategoriesUseCases({required this.repository});

  @override
  Future<Either<Failure, CollectionResponseEntity<CategoriesEntity>>> call(
          NoParams params) =>
      repository.getCategoriesRepo();
}

class HomeCourseUseCases
    implements UseCase<CollectionResponseEntity<CoursesEntity>, NoParams> {
  final HomeRepository repository;

  HomeCourseUseCases({required this.repository});

  @override
  Future<Either<Failure, CollectionResponseEntity<CoursesEntity>>> call(
          NoParams params) =>
      repository.getCoursesRepo();
}

class SliderUseCases
    implements UseCase<CollectionResponseEntity<SliderEntity>, NoParams> {
  final HomeRepository repository;

  SliderUseCases({required this.repository});

  @override
  Future<Either<Failure, CollectionResponseEntity<SliderEntity>>> call(
          NoParams params) =>
      repository.getSliders();
}
