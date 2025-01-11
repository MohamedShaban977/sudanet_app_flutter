import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../../../courses/domain/entities/courses_entity.dart';
import '../repositories/courses_by_category_repo.dart';

class CoursesByCategoryUseCases
    implements UseCase<CollectionResponseEntity<CoursesEntity>, String> {
  final CourseByCategoryRepo repository;

  CoursesByCategoryUseCases({required this.repository});

  @override
  Future<Either<Failure, CollectionResponseEntity<CoursesEntity>>> call(
          String categoryId) =>
      repository.getCoursesByCategory(categoryId);
}
