import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../core/app_manage/color_manager.dart';
import '../core/app_manage/strings_manager.dart';
import '../core/app_manage/values_manager.dart';
import '../core/packages/quickalert/models/quickalert_type.dart';
import '../core/packages/quickalert/widgets/quickalert_dialog.dart';
import '../core/packages/snackbar_content/awesome_snackbar_content.dart';
import '../core/routes/magic_router.dart';
import '../core/routes/routes_name.dart';

class ToastAndSnackBar {
  static toastError({required String message}) {
    return Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
      backgroundColor: Colors.redAccent,
      gravity: ToastGravity.SNACKBAR,
      textColor: Colors.white,
      timeInSecForIosWeb: 10,
    );
  }

  static toastSuccess({required String message}) {
    return Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
      backgroundColor: Colors.green,
      gravity: ToastGravity.SNACKBAR,
      textColor: Colors.white,
      timeInSecForIosWeb: 5,
    );
  }

  static showSnackBarError(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static showSnackBaSuccess(BuildContext context, {required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 5),
      ),
    );
  }

  static showSnackBarFailure(BuildContext context,
      {required String title, required String message}) {
    final snackBar = SnackBar(
      elevation: 0,
      // dismissDirection: ,
      // showCloseIcon: true,
      duration: const Duration(days: 1),

      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.failure,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showSnackBarHelp(BuildContext context,
      {required String title, required String message}) {
    final snackBar = SnackBar(
      elevation: 0,
      duration: const Duration(days: 1),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.help,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showSnackBarWarning(BuildContext context,
      {required String title,
      required String message,
      int? durationMilliseconds}) {
    final snackBar = SnackBar(
      elevation: 0,
      duration: durationMilliseconds != null
          ? Duration(milliseconds: durationMilliseconds)
          : const Duration(days: 1),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.warning,
      ),
    );
    ScaffoldMessenger.of(context)
      ..hideCurrentMaterialBanner()
      ..showSnackBar(snackBar);
  }

  static showSnackBarSuccess(BuildContext context,
      {required String title,
      required String message,
      int? durationMilliseconds}) {
    final snackBar = SnackBar(
      elevation: 0,
      duration: durationMilliseconds != null
          ? Duration(milliseconds: durationMilliseconds)
          : const Duration(days: 1),
      behavior: SnackBarBehavior.fixed,
      backgroundColor: Colors.transparent,
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: ContentType.success,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static alertMustBeLogged() {
    QuickAlert.show(
      context: MagicRouter.currentContext!,
      type: QuickAlertType.warning,
      title: 'Oops...',
      text: AppStrings.youMustBeLogged.tr(),
      borderRadius: AppSize.s8,
      widget: Column(children: [
        ElevatedButton(
            onPressed: () =>
                MagicRouterName.navigateAndPopAll(RoutesNames.loginRoute),
            child: Text(AppStrings.signIn.tr())),
        ElevatedButton(
            onPressed: () => MagicRouter.pop(),
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              backgroundColor: ColorManager.white,
              foregroundColor: ColorManager.primary,
            ),
            child: Text(AppStrings.cancel.tr()))
      ]),
    );
  }
}
