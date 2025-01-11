import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/end_point.dart';
import '../../../../../core/api/service_response.dart';
import '../models/login_request.dart';
import '../models/login_response.dart';

abstract class LoginDataSource {
  Future<BaseResponse<UserData>> loginDataSource(LoginRequest request);
}

class LoginDataSourceImpl implements LoginDataSource {
  ApiConsumer apiConsumer;

  LoginDataSourceImpl({required this.apiConsumer});

  @override
  Future<BaseResponse<UserData>> loginDataSource(LoginRequest request) async {
    final response = await apiConsumer.post(
      EndPoint.login,
      data: request.toJson(),
      isFormData: true,
    );
    final res = BaseResponse<UserData>.fromJson(
      response,
      (data) => UserData.fromJson(data),
    );

    return res;
  }
}
