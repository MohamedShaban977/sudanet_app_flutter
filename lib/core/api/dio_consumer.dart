import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import '../../app/injection_container.dart';
import '../error/exceptions.dart';
import 'api_consumer.dart';
import 'app_interceptor.dart';
import 'end_point.dart';
import 'status_code.dart';

class DioConsumer implements ApiConsumer {
  final Dio client;

  DioConsumer({required this.client}) {
    if (!kIsWeb) {
      (client.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate =
          (HttpClient client) {
        client.badCertificateCallback =
            (X509Certificate cert, String host, int port) => true;
        return client;
      };
    }
    client.options
      ..baseUrl = EndPoint.baseUrl
      ..responseType = ResponseType.plain
      ..followRedirects = false
      ..receiveDataWhenStatusError = true
      ..receiveTimeout = const Duration(seconds: 60)
      ..connectTimeout = const Duration(seconds: 60)
      ..validateStatus = (status) {
        return status! < StatusCode.internalServerError;
      };
    client.interceptors.add(sl<AppInterceptors>());
    // if (kDebugMode) {
    //   client.interceptors.add(sl<LogInterceptor>());
    // }
  }

  @override
  Future get(String path, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await client.get(path, queryParameters: queryParameters);
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future post(
    String path, {
    Map<String, dynamic>? data,
    bool isFormData = false,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.post(
        path,
        data: isFormData ? FormData.fromMap(data!) : data,
        queryParameters: queryParameters,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future put(
    String path, {
    bool isFormData = false,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.put(
        path,
        data: isFormData ? FormData.fromMap(data!) : data,
        queryParameters: queryParameters,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  @override
  Future delete(
    String path, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await client.delete(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return _handleResponseAsJson(response);
    } on DioError catch (error) {
      _handleDioError(error);
    }
  }

  dynamic _handleResponseAsJson(Response<dynamic> response) {
    if (response.statusCode == StatusCode.ok) {
      final responseJson = jsonDecode(response.data.toString());
      return responseJson;
    } else {
      _handleResponseError(response);
    }
  }

  dynamic _handleDioError(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
      case DioErrorType.sendTimeout:
      case DioErrorType.receiveTimeout:
        throw const FetchDataException();
      case DioErrorType.badResponse:
        debugPrint(error.message);
        _handleResponseDioError(error);
        break;
      case DioErrorType.cancel:
        break;
      case DioErrorType.connectionError:
        if (error.error is SocketException) {
          throw NoInternetConnectionException(error.message);
        }
        break;
      case DioErrorType.unknown:
        throw ErrorOtherException(message: error.message);

      case DioErrorType.badCertificate:
        throw const ConflictException();
    }
  }

  void _handleResponseDioError(DioError error) {
    switch (error.response?.statusCode) {
      case StatusCode.badRequest:
        throw const BadRequestException();
      case StatusCode.unauthorized:
        throw const UnauthorizedException();

      case StatusCode.forbidden:
        throw const UnauthorizedException();

      case StatusCode.notFound:
        throw const NotFoundException();
      case StatusCode.conflict:
        throw const ConflictException();
      case StatusCode.internalServerError:
        throw const InternalServerErrorException();
      case StatusCode.movedParameter:
        throw ErrorOtherException(message: error.message);
    }
  }

  void _handleResponseError(Response<dynamic> response) {
    switch (response.statusCode) {
      case StatusCode.badRequest:
        throw BadRequestException(response.data);
      case StatusCode.unauthorized:
        throw UnauthorizedException(response.data);
      case StatusCode.forbidden:
        throw const UnauthorizedException();
      case StatusCode.notFound:
        throw const NotFoundException();
      case StatusCode.methodNotAllowed:
        throw const MethodNotAllowed();
      case StatusCode.conflict:
        throw const ConflictException();
      case StatusCode.internalServerError:
        throw const InternalServerErrorException();
      case StatusCode.movedParameter:
        throw ErrorOtherException(message: '${response.data}');
    }
  }
}
