import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../../../core/app_manage/assets_manager.dart';
import '../../../../../../core/app_manage/strings_manager.dart';
import '../../../../../../core/app_manage/values_manager.dart';
import '../../../../../../core/validation/validation.dart';
import '../../../../../../widgets/custom_button_with_loading.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../login/presentation/screens/responsive/mobile_login_screen.dart';
import '../../../../login/presentation/widgets/custom_button_lang_widget.dart';

class MobileForgetPasswordScreen extends StatelessWidget {
  const MobileForgetPasswordScreen({
    super.key,
    required this.onTap,
    required this.email,
  });

  final TextEditingController email;
  final Future<dynamic> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: IntrinsicHeight(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: AppSize.s40),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  HelperButtonWidget(),
                  CustomButtonBackWidget()
                ],
              ),

              /// image
              Image.asset(ImageAssets.newLogo, alignment: Alignment.center),
              const SizedBox(height: AppSize.s38),

              ///
              Text(AppStrings.forgetPassword.tr(), style: context.displayLarge),

              const SizedBox(height: AppSize.s13),

              const SizedBox(height: AppSize.s40),

              /// email
              CustomTextFormField(
                hint: AppStrings.email.tr(),
                prefixWidget: const SizedBox(),
                controller: email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) => Validator.isValidEmail(email.text),
              ),

              const SizedBox(height: AppSize.s30),

              /// signUp button
              CustomButtonWithLoading(
                text: AppStrings.sendCode.tr(),
                onTap: onTap,
              ),

              const SizedBox(height: AppSize.s16),
            ],
          ),
        ),
      ),
    );
  }
}
