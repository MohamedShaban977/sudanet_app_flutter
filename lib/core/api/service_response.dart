import 'package:equatable/equatable.dart';

// {
// "success": true,
// "message": "تمت العملية بنجاح",
// "data": [],
// "statusCode": 200
// }

/// Base Service Response
class BaseResponseEntity<T> extends Equatable {
  final bool success;
  final String message;
  final T? data;
  final int statusCode;

  const BaseResponseEntity({
    required this.success,
    required this.message,
    required this.data,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [success, message, data, statusCode];
}

class BaseResponse<T> extends BaseResponseEntity<T> {
  const BaseResponse({
    required bool success,
    required String message,
    required T? data,
    required int statusCode,
  }) : super(
            success: success,
            message: message,
            data: data,
            statusCode: statusCode);

  factory BaseResponse.fromJson(Map<String, dynamic> json,
      [Function(Map<String, dynamic> data)? build]) {
    return BaseResponse<T>(
      success: json["success"],
      message: json["message"] ?? '',
      data: json["data"] != null
          ? build == null
              ? json["data"]
              : build(json["data"])
          : null,
      statusCode: json["statusCode"],
    );
  }
}

/// Base Response collection
class CollectionResponseEntity<T> extends Equatable {
  final bool success;
  final String message;
  final List<T>? data;
  final int statusCode;

  const CollectionResponseEntity({
    required this.message,
    required this.success,
    required this.data,
    required this.statusCode,
  });

  @override
  List<Object?> get props => [success, message, data];
}

class CollectionResponse<T> extends CollectionResponseEntity<T> {
  const CollectionResponse({
    required bool success,
    required String message,
    required List<T>? data,
    required int statusCode,
  }) : super(
            success: success,
            message: message,
            data: data,
            statusCode: statusCode);

  factory CollectionResponse.fromJson(Map<String, dynamic> json,
      [Function(List<dynamic> list)? build]) {
    return CollectionResponse<T>(
      success: json["success"],
      message: json["message"],
      data: json["data"] != null
          ? build == null
              ? json["data"]
              : build(json["data"])
          : [],
      statusCode: json["statusCode"],
    );
  }
}
