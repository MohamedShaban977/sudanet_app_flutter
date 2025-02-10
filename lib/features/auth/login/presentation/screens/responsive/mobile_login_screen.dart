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
      {super.key, required this.email, required this.password, required this.onTap, this.onPressedTestLogin});

  final TextEditingController email;
  final TextEditingController password;
  final Future<dynamic> Function() onTap;
  final void Function()? onPressedTestLogin;

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
              const SizedBox(height: kToolbarHeight),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // const CustomButtonChangeLanguageWidget(),
                //  HelperButtonWidget(),
                  // GestureDetector(
                  //   onTap: () => MagicRouterName.navigateReplacementTo(
                  //       RoutesNames.mainLayoutApp),
                  //   child: Text(
                  //     AppStrings.registerLater.tr(),
                  //     style: context.displayMedium.copyWith(
                  //         color: ColorManager.primary,
                  //         fontWeight: FontWeight.bold),
                  //   ),
                  // )
                ],
              ),
              const SizedBox(height: AppSize.s40),

              /// image
              Image.asset(
                ImageAssets.appLogo,
                alignment: Alignment.center,
                width: 200,
                height: 200,
              ),
              const SizedBox(height: AppSize.s38),

              ///
              Text(AppStrings.signIn.tr(), style: context.displayLarge),

              const SizedBox(height: AppSize.s40),

              ///
              CustomTextFormField(
                hint: AppStrings.email.tr(),
                prefixIcon: Icons.person_2_rounded,
                controller: email,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                validator: (value) => Validator.isValidUserName(email.text),
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
                    validator: (value) => Validator.isValidPassword(password.text),
                  );
                },
              ),

              const SizedBox(height: AppSize.s30),
              Row(
                children: [
                  GestureDetector(
                    onTap: () => MagicRouterName.navigateTo(RoutesNames.forgetPasswordRoute),
                    child: Text(AppStrings.forgetPassword.tr(),
                        style: context.displayMedium.copyWith(color: ColorManager.textGray)),
                  ),
                ],
              ),
              const SizedBox(height: AppSize.s30),

              /// login button
              CustomButtonWithLoading(
                text: AppStrings.login.tr(),
                onTap: onTap,
              ),

              const SizedBox(height: AppSize.s37),
              ElevatedButton(
                onPressed: onPressedTestLogin,
                child: const Text('Login Test'),
              ),

              ///
              // const RegisterButtonRowTextWidget(),
              const SizedBox(height: AppSize.s37),

              /*     Align(
                alignment: AlignmentDirectional.centerStart,
                child: HelperButonWidget(),
              ),*/

              /// image
            ],
          ),
        ),
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
            borderRadius: BorderRadius.circular(8.0), side: const BorderSide(color: ColorManager.primary)),
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
            const Icon(FontAwesomeIcons.circleQuestion, color: ColorManager.primary),
          ],
        ),
        onPressed: () => MagicRouterName.navigateTo(RoutesNames.contactInfo),
        // splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
      ),
    );
  }
}
