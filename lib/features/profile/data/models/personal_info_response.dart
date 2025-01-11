
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../domain/entities/personal_info_entity.dart';

class PersonInfoResponse extends PersonInfoEntity {
  PersonInfoResponse({
    final String? name,
    final String? parentPhone,
    final String? email,
    final String? phoneNumber,
  }) : super(
          name: name.orEmpty(),
          email: email.orEmpty(),
          phoneNumber: phoneNumber.orEmpty(),
          parentPhone: parentPhone.orEmpty(),
        );

  factory PersonInfoResponse.fromJson(Map<String, dynamic> json) =>
      PersonInfoResponse(
        name: json["name"],
        parentPhone: json["parentPhone"],
        email: json["email"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "parentPhone": parentPhone,
        "email": email,
        "phoneNumber": phoneNumber,
      };
}
