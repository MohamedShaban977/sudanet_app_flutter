import 'package:flutter/material.dart';

import '../models/quickalert_options.dart';
import '../models/quickalert_type.dart';

class QuickAlertButtons extends StatelessWidget {
  final QuickAlertOptions? options;

  const QuickAlertButtons({
    super.key,
    this.options,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      child: options!.widget ??
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              cancelBtn(context),
              okayBtn(context),
            ],
          ),
    );
  }

  Widget okayBtn(context) {
    final showCancelBtn = options!.type == QuickAlertType.confirm
        ? true
        : options!.showCancelBtn!;

    final okayBtn = buildButton(
      context: context,
      isOkayBtn: true,
      text: options!.confirmBtnText!,
      borderRadiusOkayBtn: options!.borderRadiusOkayBtn!,
      onTap: options!.onConfirmBtnTap ?? () => Navigator.pop(context),
    );

    if (showCancelBtn) {
      return Expanded(child: okayBtn);
    } else {
      return okayBtn;
    }
  }

  Widget cancelBtn(context) {
    final showCancelBtn = options!.type == QuickAlertType.confirm
        ? true
        : options!.showCancelBtn!;

    final cancelBtn = buildButton(
      context: context,
      isOkayBtn: false,
      text: options!.cancelBtnText!,
      onTap: options!.onCancelBtnTap ?? () => Navigator.pop(context),
    );

    if (showCancelBtn) {
      return Expanded(child: cancelBtn);
    } else {
      return Container();
    }
  }

  Widget buildButton({
    BuildContext? context,
    required bool isOkayBtn,
    required String text,
    VoidCallback? onTap,
    double borderRadiusOkayBtn = 15.0,
  }) {
    final btnText = Text(
      text,
      style: defaultTextStyle(isOkayBtn),
    );

    final okayBtn = MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadiusOkayBtn),
      ),
      color: options!.confirmBtnColor ?? Theme.of(context!).primaryColor,
      onPressed: onTap,
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(7.5),
          child: btnText,
        ),
      ),
    );

    final cancelBtn = GestureDetector(
      onTap: onTap,
      child: Center(
        child: btnText,
      ),
    );

    return isOkayBtn ? okayBtn : cancelBtn;
  }

  TextStyle defaultTextStyle(bool isOkayBtn) {
    final textStyle = TextStyle(
      color: isOkayBtn ? Colors.white : Colors.grey,
      fontWeight: FontWeight.w600,
      fontSize: 18.0,
    );

    if (isOkayBtn) {
      return options!.confirmBtnTextStyle ?? textStyle;
    } else {
      return options!.cancelBtnTextStyle ?? textStyle;
    }
  }
}
