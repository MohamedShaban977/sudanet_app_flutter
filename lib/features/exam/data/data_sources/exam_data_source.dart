import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/service_response.dart';
import '../../presentation/screens/exam_screen.dart';
import '../models/end_exam_response.dart';
import '../models/exam_ready_response.dart';
import '../models/exam_response.dart';
import '../models/save_answer_request.dart';

abstract class ExamDataSource {
  Future<BaseResponse<ExamReadyResponse>> getExamReady({required String examId, required ExamType type});

  Future<BaseResponse<ExamModel>> getExamQuestionOrPercentage({required String examId, required ExamType type});

  Future<BaseResponse<bool>> saveAnswer({required SaveAnswerRequest request, required ExamType type});

  Future<BaseResponse<EndExamResponse>> endExam({required String studentExamId, required ExamType type});
}

class ExamDataSourceImpl implements ExamDataSource {
  final ApiConsumer consumer;

  ExamDataSourceImpl(this.consumer);

  @override
  Future<BaseResponse<ExamReadyResponse>> getExamReady({required String examId, required ExamType type}) async {
    final response = await consumer.get(
      type == ExamType.homework ? EndPoint.getHomeWorkReady : EndPoint.getExamReady,
      queryParameters: {"Id": examId},
    );

    final res = BaseResponse<ExamReadyResponse>.fromJson(
      response,
      (data) => ExamReadyResponse.fromJson(data),
    );

    return res;
  }

  @override
  Future<BaseResponse<ExamModel>> getExamQuestionOrPercentage({required String examId, required ExamType type}) async {
    final response = await consumer.get(
      type == ExamType.homework ? EndPoint.getHomeWork : EndPoint.getExam,
      queryParameters: {"Id": examId},
    );

    final res = BaseResponse<ExamModel>.fromJson(
      response,
      (data) => ExamModel.fromJson(data),
    );

    return res;
  }

  @override
  Future<BaseResponse<bool>> saveAnswer({required SaveAnswerRequest request, required ExamType type}) async {
    final response = await consumer.post(
      type == ExamType.homework ? EndPoint.saveHomeWorkAnswer : EndPoint.saveAnswer,
      data: request.toJson(),
      isFormData: true,
    );

    final res = BaseResponse<bool>.fromJson(response);

    return res;
  }

  @override
  Future<BaseResponse<EndExamResponse>> endExam({required String studentExamId, required ExamType type}) async {
    final response = await consumer.post(
      type == ExamType.homework ? EndPoint.endHomeWork : EndPoint.endExam,
      data: {type == ExamType.homework ? 'StudentHomeWorkId' : "StudentExamId": studentExamId},
      isFormData: true,
    );

    final res = BaseResponse<EndExamResponse>.fromJson(
      response,
      (data) => EndExamResponse.fromJson(data),
    );

    return res;
  }
}
