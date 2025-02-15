import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../../app/injection_container.dart';
import '../../../../../core/app_manage/color_manager.dart';
import '../../../../../core/app_manage/strings_manager.dart';
import '../../../../../core/service/locale_service/manager/locale_cubit.dart';

class CustomButtonChangeLanguageWidget extends StatelessWidget {
  const CustomButtonChangeLanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 50.0,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: ColorManager.primary)),
        fillColor: ColorManager.white,
        elevation: 5.0,
        highlightElevation: 5.0,
        highlightColor: ColorManager.primary.withValues(alpha: 0.3),
        splashColor: ColorManager.primary.withValues(alpha: 0.3),
        child: Text(
          AppStrings.lang.tr(),
          textAlign: TextAlign.center,
          style: context.displayLarge.copyWith(
            color: ColorManager.primary,
          ),
        ),
        onPressed: () => sl<LocaleCubit>().get(context).changeLang(context),
      ),
    );
  }
}
