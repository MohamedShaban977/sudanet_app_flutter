
import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/service_response.dart';
import '../models/change_password_request.dart';
import '../models/personal_info_response.dart';
import '../models/user_my_course_response.dart';

abstract class ProfileDataSource {
  Future<BaseResponse<PersonInfoResponse>> getPersonalInfo();

  Future<BaseResponse<bool>> savePersonalInfo(PersonInfoResponse request);

  Future<BaseResponse<bool>> changePassword(ChangePasswordRequest request);

  Future<CollectionResponse<UserMyCoursesResponse>> getUserMyCourses();
}

class ProfileDataSourceImpl implements ProfileDataSource {
  final ApiConsumer consumer;

  const ProfileDataSourceImpl({required this.consumer});

  @override
  Future<BaseResponse<PersonInfoResponse>> getPersonalInfo() async {
    final response = await consumer.get(
      EndPoint.getUserPersonalInfo,
    );

    final res = BaseResponse<PersonInfoResponse>.fromJson(
      response,
      (data) => PersonInfoResponse.fromJson(data),
    );

    return res;
  }

  @override
  Future<BaseResponse<bool>> savePersonalInfo(
      PersonInfoResponse request) async {
    final response = await consumer.post(
      EndPoint.saveUserPersonalInfo,
      data: request.toJson(),
      isFormData: true,
    );

    final res = BaseResponse<bool>.fromJson(response);

    return res;
  }

  @override
  Future<BaseResponse<bool>> changePassword(
      ChangePasswordRequest request) async {
    final response = await consumer.post(
      EndPoint.changePassword,
      data: request.toJson(),
      isFormData: true,
    );

    final res = BaseResponse<bool>.fromJson(response);

    return res;
  }

  @override
  Future<CollectionResponse<UserMyCoursesResponse>> getUserMyCourses() async {
    final response = await consumer.get(EndPoint.getUserCourses);

    final res = CollectionResponse<UserMyCoursesResponse>.fromJson(response,
        (list) => list.map((e) => UserMyCoursesResponse.fromJson(e)).toList());

    return res;
  }
}
