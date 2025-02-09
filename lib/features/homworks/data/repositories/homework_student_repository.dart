import 'package:dartz/dartz.dart';
import 'package:sudanet_app_flutter/features/homworks/data/models/written_homework_item_model.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../data_sources/homework_student_data_source.dart';
import '../models/homework_item_model.dart';

abstract class HomeworksStudentRepository {
  Future<Either<Failure, CollectionResponse<HomeworkItemModel>>>
      getHomeworkBySubject(String subjectId);
  Future<Either<Failure, CollectionResponse<WrittenHomeworkItemModel>>>
      getWrittenHomeworkBySubject(String subjectId);
}

class HomeworksStudentRepositoryImpl extends HomeworksStudentRepository {
  final HomeworksStudentDataSource dataSource;

  HomeworksStudentRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, CollectionResponse<HomeworkItemModel>>>
      getHomeworkBySubject(String subjectId) async {
    try {
      final res = await dataSource.getHomeworkBySubject(subjectId);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, CollectionResponse<WrittenHomeworkItemModel>>>
      getWrittenHomeworkBySubject(String subjectId) async {
    try {
      final res = await dataSource.getWrittenHomeworkBySubject(subjectId);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
