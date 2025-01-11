import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/service_response.dart';
import '../models/courses_response.dart';

abstract class CoursesDataSource {
  Future<CollectionResponse<CoursesResponse>> getCoursesDataSource();
}

class CoursesDataSourceImpl implements CoursesDataSource {
  final ApiConsumer consumer;

  const CoursesDataSourceImpl({required this.consumer});

  @override
  Future<CollectionResponse<CoursesResponse>> getCoursesDataSource() async {
    final response = await consumer.get(EndPoint.getCoursesByCategoriesId,
        queryParameters: {"CategoryId": "0"});

    final res = CollectionResponse<CoursesResponse>.fromJson(response,
        (list) => list.map((e) => CoursesResponse.fromJson(e)).toList());

    return res;
  }
}
