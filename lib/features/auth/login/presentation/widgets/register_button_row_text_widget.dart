import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../../core/app_manage/color_manager.dart';
import '../../../../../core/app_manage/strings_manager.dart';
import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/routes/magic_router.dart';
import '../../../../../core/routes/routes_name.dart';

class RegisterButtonRowTextWidget extends StatelessWidget {
  const RegisterButtonRowTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppStrings.dontHaveAnAccount.tr(), style: context.titleLarge),
        const SizedBox(width: AppSize.s11),
        GestureDetector(
          onTap: () => MagicRouterName.navigateTo(RoutesNames.signupRoute),
          child: Text(AppStrings.signUp.tr(),
              style: context.displayMedium.copyWith(
                  color: ColorManager.textGray, fontWeight: FontWeight.w800)),
        ),
      ],
    );
  }
}
