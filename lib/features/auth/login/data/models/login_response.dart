
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../domain/entities/login_entity.dart';

class UserData extends UserEntity {
  UserData({
    final String? token,
    final String? name,
    final String? guid,
    final int? expiresIn,
  }) : super(
          token: token,
          name: name.orEmpty(),
          guid: guid,
          expiresIn: expiresIn.orZero(),
        );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        token: json["token"],
        name: json["name"],
        guid: json["guid"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "guid": guid,
        "expires_in": expiresIn,
      };
}
