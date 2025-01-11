import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  String? token;
  final String name;
  final String? guid;
  final int expiresIn;

  UserEntity(
      {required this.token,
      required this.name,
      required this.guid,
      required this.expiresIn});

  @override
  List<Object?> get props => [token, name, guid, expiresIn];

  factory UserEntity.fromJson(Map<String, dynamic> json) => UserEntity(
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
