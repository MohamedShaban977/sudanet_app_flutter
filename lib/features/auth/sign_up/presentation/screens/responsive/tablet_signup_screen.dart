import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../../../app/injection_container.dart';
import '../../../../../../core/app_manage/assets_manager.dart';
import '../../../../../../core/app_manage/strings_manager.dart';
import '../../../../../../core/app_manage/values_manager.dart';
import '../../../../../../core/validation/validation.dart';
import '../../../../../../widgets/custom_button_with_loading.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../../../login/presentation/screens/responsive/mobile_login_screen.dart';
import '../../../../login/presentation/widgets/custom_button_lang_widget.dart';
import '../../cubit/signup_cubit.dart';
import '../../widgets/login_button_row_text_widget.dart';

class TabletSignupScreen extends StatelessWidget {
  const TabletSignupScreen(
      {Key? key,
      required this.password,
      required this.onTap,
      required this.fullName,
      required this.email,
      required this.phoneNumber,
      required this.phoneNumberParent})
      : super(key: key);

  final TextEditingController fullName;
  final TextEditingController password;
  final TextEditingController email;
  final TextEditingController phoneNumber;
  final TextEditingController phoneNumberParent;
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
                                Image.asset(ImageAssets.newLogo,
                                    alignment: Alignment.center),
                                const SizedBox(height: AppSize.s38),

                                ///
                                Text(AppStrings.newAccount.tr(),
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

                                /// full Name
                                CustomTextFormField(
                                  hint: AppStrings.fullName.tr(),
                                  controller: fullName,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) =>
                                      Validator.isValidUserName(fullName.text),
                                ),

                                const SizedBox(height: AppSize.s12),

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

                                const SizedBox(height: AppSize.s12),

                                /// phoneNumber
                                CustomTextFormField(
                                  hint: AppStrings.phoneNumber.tr(),
                                  prefixWidget: const SizedBox(),
                                  controller: phoneNumber,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) =>
                                      Validator.isValidPhone(phoneNumber.text),
                                ),

                                const SizedBox(height: AppSize.s12),

                                /// phoneNumberParent
                                CustomTextFormField(
                                  hint: AppStrings.phoneNumberParent.tr(),
                                  prefixWidget: const SizedBox(),
                                  controller: phoneNumberParent,
                                  keyboardType: TextInputType.name,
                                  textInputAction: TextInputAction.next,
                                  validator: (value) => Validator.isValidPhone(
                                      phoneNumberParent.text),
                                ),

                                const SizedBox(height: AppSize.s12),

                                /// password
                                BlocBuilder<SignUpCubit, SignUpState>(
                                  builder: (context, state) {
                                    final cubit =
                                        sl<SignUpCubit>().get(context);
                                    return CustomTextFormField(
                                      hint: AppStrings.passwordFormat.tr(),
                                      prefixWidget: const SizedBox(),
                                      controller: password,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.next,
                                      obscureText: cubit.isPassword,
                                      iconData: cubit.suffix,
                                      onTapIcon: () =>
                                          cubit.changePassVisibility(),
                                      validator: (value) =>
                                          Validator.isValidPassword(
                                              password.text),
                                    );
                                  },
                                ),
                                const SizedBox(height: AppSize.s12),

                                /// login button
                                CustomButtonWithLoading(
                                  text: AppStrings.signUp.tr(),
                                  onTap: onTap,
                                ),

                                const SizedBox(height: AppSize.s37),

                                ///
                                const LoginButtonRowTextWidget(),
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
