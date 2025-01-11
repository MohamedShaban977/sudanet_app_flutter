import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_point.dart';
import '../../../../core/api/service_response.dart';
import '../models/contact_info_response.dart';

abstract class ContactInfoDataSource {
  Future<BaseResponse<ContactInfoResponse>> getHelpContactInfo();
}

class ContactInfoDataSourceImpl implements ContactInfoDataSource {
  ApiConsumer apiConsumer;

  ContactInfoDataSourceImpl({required this.apiConsumer});

  @override
  Future<BaseResponse<ContactInfoResponse>> getHelpContactInfo() async {
    final response = await apiConsumer.get(EndPoint.getContactInfo);
    final res = BaseResponse<ContactInfoResponse>.fromJson(
      response,
      (data) => ContactInfoResponse.fromJson(data),
    );

    return res;
  }
}
