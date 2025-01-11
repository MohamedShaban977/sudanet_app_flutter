/*

import 'package:sudanet_app/core/app_manage/extension_manager.dart';

import '../../domain/entities/signup_entity.dart';

class SignUpResponse extends SignUpEntity {
  SignUpResponse({
    final User? user,
    final String? message,
  }) : super(user: user, message: message.orEmpty());

  factory SignUpResponse.fromJson(Map<String, dynamic> json) => SignUpResponse(
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        message: json["message"],
      );
}

class User extends UserEntity {
  User({
    final int? id,
    final dynamic lastLogin,
    final bool? isSuperuser,
    final String? username,
    final String? firstName,
    final String? lastName,
    final String? email,
    final bool? isStaff,
    final bool? isActive,
    final DateTime? dateJoined,
    final List<dynamic>? groups,
    final List<dynamic>? userPermissions,
  }) : super(
            id: id.orZero(),
            lastLogin: lastLogin,
            isSuperuser: isSuperuser.orEmptyB(),
            username: username.orEmpty(),
            firstName: firstName.orEmpty(),
            lastName: lastName.orEmpty(),
            email: email.orEmpty(),
            isStaff: isStaff.orEmptyB(),
            isActive: isActive.orEmptyB(),
            dateJoined: dateJoined,
            groups: groups,
            userPermissions: userPermissions);

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        lastLogin: json["last_login"],
        isSuperuser: json["is_superuser"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        isStaff: json["is_staff"],
        isActive: json["is_active"],
        dateJoined: json["date_joined"] == null
            ? null
            : DateTime.parse(json["date_joined"]),
        groups: json["groups"] == null
            ? []
            : List<dynamic>.from(json["groups"]!.map((x) => x)),
        userPermissions: json["user_permissions"] == null
            ? []
            : List<dynamic>.from(json["user_permissions"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "last_login": lastLogin,
        "is_superuser": isSuperuser,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "is_staff": isStaff,
        "is_active": isActive,
        "date_joined": dateJoined?.toIso8601String(),
        "groups":
            groups == null ? [] : List<dynamic>.from(groups!.map((x) => x)),
        "user_permissions": userPermissions == null
            ? []
            : List<dynamic>.from(userPermissions!.map((x) => x)),
      };
}
*/
