import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../data_sources/exams_by_subject_data_source.dart';
import '../models/exams_by_subject_item_model.dart';

abstract class ExamsBySubjectRepository {
  Future<Either<Failure, CollectionResponse<ExamsBySubjectItemModel>>> getExamsBySubject(String subjectId);
  Future<Either<Failure, CollectionResponse<ExamsBySubjectItemModel>>> getExamsNotification();
}

class ExamsBySubjectRepositoryImpl extends ExamsBySubjectRepository {
  final ExamsBySubjectDataSource dataSource;

  ExamsBySubjectRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, CollectionResponse<ExamsBySubjectItemModel>>> getExamsBySubject(String subjectId) async {
    try {
      final res = await dataSource.getExamsBySubject(subjectId);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, CollectionResponse<ExamsBySubjectItemModel>>> getExamsNotification() async {
    try {
      final res = await dataSource.getExamsNotifications();
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
