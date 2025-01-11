// import 'package:dartz/dartz.dart';
// import 'package:sudanet_app/features/exam/data/models/exam_response.dart';
//
// import '../../../../core/api/service_response.dart';
// import '../../../../core/error/failures.dart';
// import '../../../../core/useCases/use_case.dart';
// import '../../data/models/save_answer_request.dart';
// import '../entities/end_exam_entity.dart';
// import '../entities/exam_ready_entity.dart';
// import '../repositories/exam_repository.dart';
//
// class GetExamReadyUseCases implements UseCase<BaseResponseEntity<ExamReadyEntity>, String> {
//   final ExamRepository repository;
//
//   GetExamReadyUseCases({required this.repository});
//
//   @override
//   Future<Either<Failure, BaseResponseEntity<ExamReadyEntity>>> call(String examId) => repository.getExamReady(examId);
// }
//
// class GetExamQuestionOrPercentageUseCases implements UseCase<BaseResponseEntity<ExamModel>, String> {
//   final ExamRepository repository;
//
//   GetExamQuestionOrPercentageUseCases({required this.repository});
//
//   @override
//   Future<Either<Failure, BaseResponseEntity<ExamModel>>> call(String examId) =>
//       repository.getExamQuestionOrPercentage(examId);
// }
//
// class SaveAnswerUseCases implements UseCase<BaseResponseEntity<bool>, SaveAnswerRequest> {
//   final ExamRepository repository;
//
//   SaveAnswerUseCases({required this.repository});
//
//   @override
//   Future<Either<Failure, BaseResponseEntity<bool>>> call(SaveAnswerRequest request) => repository.saveAnswer(request);
// }
//
// class EndExamUseCases implements UseCase<BaseResponseEntity<EndExamEntity>, String> {
//   final ExamRepository repository;
//
//   EndExamUseCases({required this.repository});
//
//   @override
//   Future<Either<Failure, BaseResponseEntity<EndExamEntity>>> call(String studentExamId) =>
//       repository.endExam(studentExamId);
// }
