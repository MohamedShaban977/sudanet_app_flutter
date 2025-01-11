import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/exam_response.dart';
import '../../data/models/save_answer_request.dart';
import '../../presentation/screens/exam_screen.dart';
import '../entities/end_exam_entity.dart';
import '../entities/exam_ready_entity.dart';

abstract class ExamRepository {
  Future<Either<Failure, BaseResponseEntity<ExamReadyEntity>>> getExamReady(
      {required String examId, required ExamType type});

  Future<Either<Failure, BaseResponseEntity<ExamModel>>> getExamQuestionOrPercentage(
      {required String examId, required ExamType type});

  Future<Either<Failure, BaseResponseEntity<bool>>> saveAnswer(
      {required SaveAnswerRequest request, required ExamType type});

  Future<Either<Failure, BaseResponseEntity<EndExamEntity>>> endExam(
      {required String studentExamId, required ExamType type});
}
