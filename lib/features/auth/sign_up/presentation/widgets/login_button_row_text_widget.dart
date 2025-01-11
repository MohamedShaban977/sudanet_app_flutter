
import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../../core/app_manage/strings_manager.dart';
import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/routes/magic_router.dart';
import '../../../../../core/routes/routes_name.dart';

class LoginButtonRowTextWidget extends StatelessWidget {
  const LoginButtonRowTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppStrings.youHaveAnAccount.tr(), style: context.titleLarge),
        const SizedBox(width: AppSize.s11),
        GestureDetector(
          onTap: () => MagicRouterName.navigateAndPopAll(RoutesNames.loginRoute),
          child: Text(AppStrings.login.tr(), style: context.displaySmall),
        ),
      ],
    );
  }
}
