import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/api/status_code.dart';
import 'package:sudanet_app_flutter/features/auth/login/presentation/manger/user_secure_storage.dart';

import '../../app/injection_container.dart';
import '../../widgets/toast_and_snackbar.dart';
import '../app_manage/contents_manager.dart';
import '../cache/cache_data_shpref.dart';
import '../routes/magic_router.dart';

class AppInterceptors extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    /// => PATH
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');

    /// => QUERY
    debugPrint(
        'REQUEST[${options.method}] => QUERY: ${options.queryParameters}');

    /// => BODY
    if (options.data.runtimeType == FormData) {
      // var form = FormData.fromMap({});
      // // form.;
      debugPrint(
          'REQUEST[${options.method}] => Request Data: ${options.data.fields}');

      if (options.data?.files != [] && options.data?.files?.length != 0) {
        debugPrint(
            'REQUEST[${options.method}] => MultipartFile: ${options.data?.files?.single.value.filename}');
        debugPrint(
            'REQUEST[${options.method}] => MultipartFile: ${options.data?.files?.single.value.isFinalized}');
      }
    } else {
      debugPrint('REQUEST[${options.method}] => Request Data: ${options.data}');
    }

    options.headers[HttpHeaders.acceptHeader] = ContentType.json;
    options.headers[HttpHeaders.contentTypeHeader] =
        options.data.runtimeType == FormData
            ? Headers.multipartFormDataContentType
            : Headers.jsonContentType;

    options.headers[HttpHeaders.acceptLanguageHeader] =
        sl<CacheHelper>().getData(key: Constants.locale);

    if (UserSecureStorage.getToken() != null) {
      options.headers[HttpHeaders.authorizationHeader] =
          'Bearer ${UserSecureStorage.getToken()}';
    }

    // if (sl<CacheHelper>().getToken() != null) {
    //   options.headers = {
    //     "Content-Type": options.data.runtimeType == FormData
    //         ? 'multipart/form-data'
    //         : "application/json",
    //     'Accept': '*/*',
    //     'Authorization': 'Bearer ${sl<CacheHelper>().getToken()}',
    //   };
    // } else {
    // options.headers = {
    //   "Content-Type": options.data.runtimeType == FormData
    //       ? 'multipart/form-data'
    //       : "application/json",
    // };
    // }

    /// => Headers
    debugPrint('REQUEST[${options.method}] => Headers: ${options.headers}');

    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    log('RESPONSE[${response.statusCode}] => data: ${response.data}');

    if (response.statusCode == StatusCode.badRequest) {
      var error = jsonDecode(response.data);
      ToastAndSnackBar.showSnackBarFailure(MagicRouter.currentContext!,
          title: response.statusMessage!, message: error['title']!);
    }

    if (response.statusCode == StatusCode.unauthorized) {
      // var error = jsonDecode(response.data);
      // ToastAndSnackBar.showSnackBarFailure(MagicRouter.currentContext!,
      //     title: response.statusMessage!, message: error['title']!);
      ToastAndSnackBar.alertMustBeLogged();
      // MagicRouterName.navigateAndPopAll(RoutesNames.loginRoute);
    }

    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    debugPrint('ERROR[${err.type}] => Error: ${err.error}');

    if (err.type == DioExceptionType.unknown) {
      // MagicRouterName.navigateTo(RoutesNames.loginRoute);
      ToastAndSnackBar.showSnackBarFailure(MagicRouter.currentContext!,
          title: 'ERROR ${err.type.name}', message: err.message!);
    }

    return super.onError(err, handler);
  }
}
