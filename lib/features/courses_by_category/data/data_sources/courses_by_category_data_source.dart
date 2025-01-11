
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/service_response.dart';
import '../../../courses/data/models/courses_response.dart';

abstract class CoursesByCategoryDataSource {
  Future<CollectionResponse<CoursesResponse>> getCoursesByCategoryDataSource(
      String categoryId);
}

class CoursesByCategoryDataSourceImpl implements CoursesByCategoryDataSource {
  final ApiConsumer consumer;

  CoursesByCategoryDataSourceImpl({required this.consumer});

  @override
  Future<CollectionResponse<CoursesResponse>> getCoursesByCategoryDataSource(
      String categoryId) async {
    final response = await consumer.get(EndPoint.getCoursesByCategoriesId,
        queryParameters: {"CategoryId": categoryId});

    final res = CollectionResponse<CoursesResponse>.fromJson(response,
        (list) => list.map((e) => CoursesResponse.fromJson(e)).toList());

    return res;
  }
}
