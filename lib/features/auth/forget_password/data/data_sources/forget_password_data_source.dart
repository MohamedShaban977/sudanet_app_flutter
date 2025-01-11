import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/end_point.dart';
import '../../../../../core/api/service_response.dart';
import '../models/forget_password_request.dart';

abstract class ForgetPasswordDataSource {
  Future<BaseResponse<String>> forgetPasswordDataSource(
      ForgetPasswordRequest request);
}

class ForgetPasswordDataSourceImpl implements ForgetPasswordDataSource {
  ApiConsumer apiConsumer;

  ForgetPasswordDataSourceImpl({required this.apiConsumer});

  @override
  Future<BaseResponse<String>> forgetPasswordDataSource(
      ForgetPasswordRequest request) async {
    final response = await apiConsumer.post(
      EndPoint.resetPassword,
      data: request.toJson(),
      isFormData: true,
    );

    final res = BaseResponse<String>.fromJson(response);
    return res;
  }
}
