import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../../../app/injection_container.dart';
import '../../../../../../core/app_manage/assets_manager.dart';
import '../../../../../../core/app_manage/color_manager.dart';
import '../../../../../../core/app_manage/strings_manager.dart';
import '../../../../../../core/app_manage/values_manager.dart';
import '../../../../../../core/routes/magic_router.dart';
import '../../../../../../core/routes/routes_name.dart';
import '../../../../../../core/validation/validation.dart';
import '../../../../../../widgets/custom_button_with_loading.dart';
import '../../../../../../widgets/custom_text_form_field.dart';
import '../../cubit/login_cubit.dart';

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen(
      {super.key,
      required this.email,
      required this.password,
      required this.onTap,
      this.onPressedTestLogin});

  final TextEditingController email;
  final TextEditingController password;
  final Future<dynamic> Function() onTap;
  final void Function()? onPressedTestLogin;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.height,
      width: context.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: kToolbarHeight,
            color: Color(0xff528A89),
          ),
          const SizedBox(height: 16),

          /// image
          Image.asset(
            ImageAssets.appLogo,
            alignment: Alignment.center,
            width: 250,
            height: 250,
          ),

          ///
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Card(
              color: Color(0xFFF0F0F0),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    const SizedBox(height: AppSize.s50),

                    CustomTextFormField(
                      hint: AppStrings.email.tr(),
                      prefixIcon: Icons.person_2_rounded,
                      controller: email,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      validator: (value) =>
                          Validator.isValidUserName(email.text),
                    ),

                    const SizedBox(height: AppSize.s16),

                    ///
                    BlocBuilder<LoginCubit, LoginState>(
                      builder: (context, state) {
                        final cubit = sl<LoginCubit>().get(context);
                        return CustomTextFormField(
                          hint: AppStrings.password.tr(),
                          controller: password,
                          obscureText: cubit.isPassword,
                          iconData: cubit.suffix,
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          onTapIcon: () => cubit.changePassVisibility(),
                          validator: (value) =>
                              Validator.isValidPassword(password.text),
                        );
                      },
                    ),

                    const SizedBox(height: 16),

                    /// login button
                    CustomButtonWithLoading(
                      text: AppStrings.login.tr(),
                      onTap: onTap,
                      width: context.width * 0.4,
                      color: Color(0xff528A89),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),

          ElevatedButton(
            onPressed: onPressedTestLogin,
            child: const Text('Login Test'),
          ),

          const Spacer(),
          Container(
            height: kToolbarHeight,
            width: context.width,
            color: Color(0xff528A89),
          ),
        ],
      ),
    );
  }
}

class HelperButtonWidget extends StatelessWidget {
  const HelperButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: ColorManager.primary)),
        fillColor: ColorManager.white,
        elevation: 5.0,
        highlightElevation: 5.0,
        highlightColor: ColorManager.secondary.withValues(alpha: 0.3),
        splashColor: ColorManager.secondary.withValues(alpha: 0.3),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'مساعدة',
              style: context.labelLarge.copyWith(color: ColorManager.primary),
            ),
            const SizedBox(width: 10.0),
            const Icon(FontAwesomeIcons.circleQuestion,
                color: ColorManager.primary),
          ],
        ),
        onPressed: () => MagicRouterName.navigateTo(RoutesNames.contactInfo),
        // splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
      ),
    );
  }
}
