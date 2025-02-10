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

class TabletForgetPasswordScreen extends StatelessWidget {
  const TabletForgetPasswordScreen({
    super.key,
    required this.email,
    required this.onTap,
  });

  final TextEditingController email;

  final Future<dynamic> Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      child: Column(
        children: [
          const SizedBox(height: AppSize.s40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [HelperButtonWidget(), CustomButtonBackWidget()],
          ),
          Expanded(
            child: Center(
              child: IntrinsicHeight(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: AppSize.s40),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                /// image
                                Image.asset(ImageAssets.appLogo,
                                    alignment: Alignment.center),
                                const SizedBox(height: AppSize.s38),

                                ///
                                Text(AppStrings.forgetPassword.tr(),
                                    style: context.displayLarge),

                                const SizedBox(height: AppSize.s13),

                                ///
                                // Text(AppStrings.pleaseLoginToComplete.tr(),
                                //     style: context.titleLarge),
                              ],
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 7,
                            child: Column(
                              children: [
                                ///

                                const SizedBox(height: AppSize.s50),
                                const SizedBox(height: AppSize.s50),

                                /// email
                                CustomTextFormField(
                                  hint: AppStrings.email.tr(),
                                  prefixWidget: const SizedBox(),
                                  controller: email,
                                  keyboardType: TextInputType.emailAddress,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) =>
                                      Validator.isValidEmail(email.text),
                                ),

                                const SizedBox(height: AppSize.s37),

                                ///  button
                                CustomButtonWithLoading(
                                  text: AppStrings.sendCode.tr(),
                                  onTap: onTap,
                                ),

                                const SizedBox(height: AppSize.s37),
                              ],
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                      // const Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
