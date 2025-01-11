import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../entities/courses_entity.dart';
import '../repositories/courses_repository.dart';

class CoursesUseCases
    implements UseCase<CollectionResponseEntity<CoursesEntity>, NoParams> {
  final CourseRepository repository;

  CoursesUseCases({required this.repository});

  @override
  Future<Either<Failure, CollectionResponseEntity<CoursesEntity>>> call(
          NoParams params) =>
      repository.getCourses();
}
