import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../core/app_manage/color_manager.dart';
import 'argon_button.dart';

class TimerButton extends StatelessWidget {
  final double? height, width;
  final Function() onCounterDone;
  final Color? color;
  final Color? textColors;
  final String text;

  const TimerButton(
      {super.key,
      this.height,
      this.width,
      required this.onCounterDone,
      this.color,
      this.textColors,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return ArgonTimerButton(
      height: height ?? 50.0,
      width: width ?? context.width * 0.6,
      onTap: (startTimer, btnState) {
        if (btnState == ButtonState.Idle) {
          onCounterDone();
          startTimer(10);
        }
      },
      loader: (timeLeft) {
        return Container(
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.circular(50),
          ),
          margin: const EdgeInsets.all(5),
          alignment: Alignment.center,
          width: 40,
          height: 40,
          child: Text(
            "$timeLeft",
            style:
                context.labelLarge.copyWith(color: textColors ?? Colors.white),
          ),
        );
      },
      color: color ?? ColorManager.secondary,
      borderRadius: height ?? 50.0,
      animationDuration: const Duration(milliseconds: 500),
      borderSide: BorderSide(color: ColorManager.secondary, width: 2),
      child: Text(
        text,
        style: context.labelLarge.copyWith(color: textColors ?? Colors.white),
      ),
    );
  }
}
