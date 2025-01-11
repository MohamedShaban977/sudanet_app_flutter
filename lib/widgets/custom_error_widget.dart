import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';


import '../core/app_manage/color_manager.dart';
import '../core/app_manage/strings_manager.dart';
import '../core/app_manage/values_manager.dart';

class CustomErrorWidget extends StatelessWidget {
  final VoidCallback? onPress;
  final String? error;

  const CustomErrorWidget({super.key, this.onPress, this.error});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Icon(
            Icons.warning_amber_rounded,
            color: ColorManager.error,
            size: AppSize.s150,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: AppPadding.p12),
          child: Text(
            AppStrings.somethingWentWrong.tr(),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ),
        Text(
          '$error',
          style: context.titleLarge,
        ),
        Text(
          AppStrings.tryAgain.tr(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        Container(
          height: 55,
          width: context.width * 0.55,
          margin: const EdgeInsets.symmetric(vertical: 15),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: ColorManager.white,
                backgroundColor: ColorManager.primary,
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50))),
            child: Text(
              AppStrings.reloadScreen.tr(),
              style: const TextStyle(
                  color: ColorManager.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            onPressed: () {
              if (onPress != null) {
                onPress!();
              }
            },
          ),
        )
      ],
    );
  }
}
