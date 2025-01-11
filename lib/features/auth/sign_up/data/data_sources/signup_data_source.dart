
import '../../../../../../core/api/api_consumer.dart';
import '../../../../../../core/api/end_point.dart';
import '../../../../../core/api/service_response.dart';
import '../../../login/data/models/login_response.dart';
import '../models/signup_request.dart';

abstract class SignUpDataSource {
  Future<BaseResponse<UserData>> signUpDataSource(SignUpRequest request);
}

class SignUpDataSourceImpl implements SignUpDataSource {
  ApiConsumer apiConsumer;

  SignUpDataSourceImpl({required this.apiConsumer});

  @override
  Future<BaseResponse<UserData>> signUpDataSource(SignUpRequest request) async {
    final response = await apiConsumer.post(
      EndPoint.register,
      data: request.toJson(),
      isFormData: true,
    );
    // final res = SignUpResponse.fromJson(response);

    final res = BaseResponse<UserData>.fromJson(
      response,
      (data) => UserData.fromJson(data),
    );

    return res;
  }
}

/*
{
  "type":"https://tools.ietf.org/html/rfc7231#section-6.5.1",
  "title":"One or more validation errors occurred.",
  "status":400,
  "traceId":"|94ce66ec-41887e4d1037a7d5.",
  "errors":{
     "Name":["من فضلك أدخل الأسم بالكامل"]
  }
}*/
