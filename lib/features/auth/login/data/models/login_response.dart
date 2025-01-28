
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../domain/entities/login_entity.dart';

// ignore: must_be_immutable
class UserData extends UserEntity {
  UserData({
    super.token,
    final String? name,
    super.guid,
    final int? expiresIn,
  }) : super(
          name: name.orEmpty(),
          expiresIn: expiresIn.orZero(),
        );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        token: json["token"],
        name: json["name"],
        guid: json["guid"],
        expiresIn: json["expires_in"],
      );

  @override
  Map<String, dynamic> toJson() => {
        "token": token,
        "name": name,
        "guid": guid,
        "expires_in": expiresIn,
      };
}
