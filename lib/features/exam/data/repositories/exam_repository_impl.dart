import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/end_exam_entity.dart';
import '../../domain/entities/exam_ready_entity.dart';
import '../../domain/repositories/exam_repository.dart';
import '../../presentation/screens/exam_screen.dart';
import '../data_sources/exam_data_source.dart';
import '../models/exam_response.dart';
import '../models/save_answer_request.dart';

class ExamRepositoryImpl implements ExamRepository {
  final ExamDataSource dataSource;

  ExamRepositoryImpl(this.dataSource);

  @override
  Future<Either<Failure, BaseResponseEntity<ExamReadyEntity>>> getExamReady(
      {required String examId, required ExamType type}) async {
    try {
      final res = await dataSource.getExamReady(examId: examId, type: type);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponse<ExamModel>>> getExamQuestionOrPercentage(
      {required String examId, required ExamType type}) async {
    try {
      final res = await dataSource.getExamQuestionOrPercentage(examId: examId, type: type);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity<bool>>> saveAnswer(
      {required SaveAnswerRequest request, required ExamType type}) async {
    try {
      final res = await dataSource.saveAnswer(request: request, type: type);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity<EndExamEntity>>> endExam(
      {required String studentExamId, required ExamType type}) async {
    try {
      final res = await dataSource.endExam(studentExamId: studentExamId, type: type);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
