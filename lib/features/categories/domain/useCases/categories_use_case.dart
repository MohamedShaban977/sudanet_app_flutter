import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../entities/categories_entity.dart';
import '../repositories/categories_repository.dart';

class GetAllCategoriesUseCases
    implements UseCase<CollectionResponseEntity<CategoriesEntity>, NoParams> {
  final CategoriesRepository repository;

  GetAllCategoriesUseCases({required this.repository});

  @override
  Future<Either<Failure, CollectionResponseEntity<CategoriesEntity>>> call(
          NoParams params) =>
      repository.getCategoriesRepo();
}
