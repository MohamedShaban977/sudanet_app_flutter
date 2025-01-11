import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String? message;

  const ServerException([this.message]);

  @override
  List<Object?> get props => [message];

  @override
  String toString() => '$message';
}

class FetchDataException extends ServerException {
  const FetchDataException([message]) : super("Error During Communication");
}

class BadRequestException extends ServerException {
  const BadRequestException([message]) : super("Bad Request ${message ?? ''}");
}

class UnauthorizedException extends ServerException {
  const UnauthorizedException([message])
      : super("Unauthorized  ${message ?? ''}");
}

class MethodNotAllowed extends ServerException {
  const MethodNotAllowed([message]) : super("Method Not Allowed");
}

class NotFoundException extends ServerException {
  const NotFoundException([message]) : super("Requested Info Not Found");
}

class ConflictException extends ServerException {
  const ConflictException([message]) : super("Conflict Occurred");
}

class InternalServerErrorException extends ServerException {
  const InternalServerErrorException([message])
      : super("Internal Server Error");
}

class NoInternetConnectionException extends ServerException {
  const NoInternetConnectionException([message])
      : super("No Internet Connection");
}

class ErrorOtherException extends ServerException {
  const ErrorOtherException({required String? message})
      : super("Error Other Exception $message");
}

class CacheException implements Exception {}
