import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../entities/categories_entity.dart';

abstract class CategoriesRepository {
  Future<Either<Failure, CollectionResponseEntity<CategoriesEntity>>>
      getCategoriesRepo();
}
