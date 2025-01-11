
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/service_response.dart';
import '../models/homework_item_model.dart';

abstract class HomeworksStudentDataSource {
  Future<CollectionResponse<HomeworkItemModel>> getHomeworkBySubject(String subjectId);
}

class HomeworksStudentDataSourceImpl implements HomeworksStudentDataSource {
  final ApiConsumer consumer;

  HomeworksStudentDataSourceImpl({required this.consumer});

  @override
  Future<CollectionResponse<HomeworkItemModel>> getHomeworkBySubject(String subjectId) async {
    final response = await consumer.get(
      EndPoint.getStudentHomeWorks,
      queryParameters: {
        "CourseId": subjectId,
      },
    );

    final res = CollectionResponse<HomeworkItemModel>.fromJson(
      response,
      (list) => list.map((e) => HomeworkItemModel.fromJson(e)).toList(),
    );

    return res;
  }
}
