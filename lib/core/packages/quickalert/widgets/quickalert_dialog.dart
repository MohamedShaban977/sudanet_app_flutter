import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/packages/quickalert/widgets/quickalert_container.dart';

import '../models/quickalert_animtype.dart';
import '../models/quickalert_options.dart';
import '../models/quickalert_type.dart';
import '../utils/animate.dart';

/// QuickAlert
class QuickAlert {
  /// Instantly display animated alert dialogs such as success, error, warning, confirm, loading or even a custom dialog.
  static Future show({
    /// BuildContext
    required BuildContext context,

    /// Title of the dialog
    String? title,

    /// Text of the dialog
    String? text,

    /// Custom Widget of the dialog
    Widget? widget,

    /// Alert type [success, error, warning, confirm, info, loading, custom]
    required QuickAlertType type,

    /// Animation type  [scale, rotate, slideInDown, slideInUp, slideInLeft, slideInRight]
    QuickAlertAnimType animType = QuickAlertAnimType.scale,

    /// Barrier Dismissible
    bool barrierDismissible = true,

    /// Triggered when confirm button is tapped
    VoidCallback? onConfirmBtnTap,

    /// Triggered when cancel button is tapped
    VoidCallback? onCancelBtnTap,

    /// Confirmation button text
    String confirmBtnText = 'Okay',

    /// Cancel button text
    String cancelBtnText = 'Cancel',

    /// Color for confirm button
    Color confirmBtnColor = Colors.blue,

    /// TextStyle for confirm button
    TextStyle? confirmBtnTextStyle,

    /// TextStyle for cancel button
    TextStyle? cancelBtnTextStyle,

    /// Background Color for dialog
    Color backgroundColor = Colors.white,

    /// Color of title
    Color titleColor = Colors.black,

    /// Color of text
    Color textColor = Colors.black,

    /// Barrier Color of dialog
    Color? barrierColor,

    /// Determines if cancel button is shown or not
    bool showCancelBtn = false,

    /// Dialog Border Radius
    double borderRadius = 15.0,
    double borderRadiusOkayBtn = 15.0,

    /// Asset path of your Image file
    String? customAsset,
    Widget? customWidget,

    /// Width of the dialog
    double? width,

    /// Determines how long the dialog stays open for before closing, [default] is null. When it is null, it won't auto close
    Duration? autoCloseDuration,
  }) {
    if (autoCloseDuration != null) {
      Future.delayed(autoCloseDuration, () {
        if(context.mounted) {
          Navigator.of(context, rootNavigator: true).pop();
        }
      });
    }

    final options = QuickAlertOptions(
      title: title,
      text: text,
      widget: widget,
      type: type,
      animType: animType,
      barrierDismissible: barrierDismissible,
      onConfirmBtnTap: onConfirmBtnTap,
      onCancelBtnTap: onCancelBtnTap,
      confirmBtnText: confirmBtnText,
      cancelBtnText: cancelBtnText,
      confirmBtnColor: confirmBtnColor,
      confirmBtnTextStyle: confirmBtnTextStyle,
      cancelBtnTextStyle: cancelBtnTextStyle,
      backgroundColor: backgroundColor,
      titleColor: titleColor,
      textColor: textColor,
      showCancelBtn: showCancelBtn,
      borderRadius: borderRadius,
      borderRadiusOkayBtn: borderRadiusOkayBtn,
      customAsset: customAsset,
      customWidget: customWidget,
      width: width,
    );

    final child = AlertDialog(
      contentPadding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      content: QuickAlertContainer(
        options: options,
      ),
    );

    return showGeneralDialog(
      barrierColor: barrierColor ?? Colors.black.withValues(alpha: 0.5),
      transitionBuilder: (context, anim1, __, widget) {
        switch (animType) {
          case QuickAlertAnimType.scale:
            return Animate.scale(child: child, animation: anim1);

          case QuickAlertAnimType.rotate:
            return Animate.rotate(child: child, animation: anim1);

          case QuickAlertAnimType.slideInDown:
            return Animate.slideInDown(child: child, animation: anim1);

          case QuickAlertAnimType.slideInUp:
            return Animate.slideInUp(child: child, animation: anim1);

          case QuickAlertAnimType.slideInLeft:
            return Animate.slideInLeft(child: child, animation: anim1);

          case QuickAlertAnimType.slideInRight:
            return Animate.slideInRight(child: child, animation: anim1);
}
      },
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible:
          autoCloseDuration != null ? false : barrierDismissible,
      barrierLabel: '',
      context: context,
      pageBuilder: (context, _, __) => Container(),
    );
  }
}
