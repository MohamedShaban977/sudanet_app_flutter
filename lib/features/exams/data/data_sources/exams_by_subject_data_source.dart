
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/service_response.dart';
import '../models/exams_by_subject_item_model.dart';

abstract class ExamsBySubjectDataSource {
  Future<CollectionResponse<ExamsBySubjectItemModel>> getExamsBySubject(String subjectId);

  Future<CollectionResponse<ExamsBySubjectItemModel>> getExamsNotifications();
}

class ExamsBySubjectDataSourceImpl implements ExamsBySubjectDataSource {
  final ApiConsumer consumer;

  ExamsBySubjectDataSourceImpl({required this.consumer});

  @override
  Future<CollectionResponse<ExamsBySubjectItemModel>> getExamsBySubject(String subjectId) async {
    final response = await consumer.get(EndPoint.getStudentExamsBySubject, queryParameters: {
      "CourseId": subjectId,
    });

    final res = CollectionResponse<ExamsBySubjectItemModel>.fromJson(
      response,
      (list) => list.map((e) => ExamsBySubjectItemModel.fromJson(e)).toList(),
    );

    return res;
  }

  @override
  Future<CollectionResponse<ExamsBySubjectItemModel>> getExamsNotifications() async {
    final response = await consumer.get(EndPoint.getStudentExamNotifications);

    final res = CollectionResponse<ExamsBySubjectItemModel>.fromJson(
      response,
      (list) => list.map((e) => ExamsBySubjectItemModel.fromJson(e)).toList(),
    );

    return res;
  }
}
