import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/assets_manager.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/validation/validation.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../../widgets/toast_and_snackbar.dart';
import '../../data/models/change_password_request.dart';
import '../cubit/profile_cubit.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController currentPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    currentPassword.dispose();
    newPassword.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: _listener,
      builder: (context, state) {
        final cubit = sl<ProfileCubit>().get(context);
        return Scaffold(
          appBar: _buildAppBar(),
          body: ModalProgressHUD(
            inAsyncCall: state is ChangePasswordLoadingState,
            progressIndicator: Lottie.asset(
              JsonAssets.loader,
              width: 150,
            ),
            child: SizedBox(
              height: context.heightBody,
              child: IntrinsicHeight(
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: context.heightBody * 0.15),
                          Text(
                            "كلمة المرور",
                            style: context.displayLarge
                                .copyWith(color: ColorManager.textGray),
                          ),
                          Text(
                            "بامكانك تعديل كلمة المرور الحالية",
                            style: context.displayMedium
                                .copyWith(color: ColorManager.textGray),
                          ),

                          SizedBox(height: context.height * 0.04),
                          Card(
                            elevation: 0.5,
                            child: Padding(
                              padding: const EdgeInsets.all(AppPadding.p16),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    const SizedBox(height: 20.0),
                                    CustomTextFormField(
                                      hint: AppStrings.password.tr(),
                                      controller: currentPassword,
                                      obscureText: cubit.isCurrantPassword,
                                      iconData: cubit.suffixCurrantPassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      onTapIcon: () => cubit
                                          .changeCurrantPasswordVisibility(),
                                      validator: (value) =>
                                          Validator.isValidPassword(value!),
                                    ),
                                    const SizedBox(height: 20.0),
                                    CustomTextFormField(
                                      hint: AppStrings.password.tr(),
                                      controller: newPassword,
                                      obscureText: cubit.isNewPassword,
                                      iconData: cubit.suffixNewPassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      onTapIcon: () =>
                                          cubit.changeNewPasswordVisibility(),
                                      validator: (value) =>
                                          Validator.isValidPassword(value!),
                                    ),
                                    const SizedBox(height: 20.0),
                                    CustomTextFormField(
                                      hint: AppStrings.password.tr(),
                                      controller: confirmPassword,
                                      obscureText: cubit.isConfirmPassword,
                                      iconData: cubit.suffixConfirmPassword,
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      textInputAction: TextInputAction.done,
                                      onTapIcon: () => cubit
                                          .changeConfirmPasswordVisibility(),
                                      validator: (value) =>
                                          Validator.isValidConfirmPassword(
                                              newPassword.text, value!),
                                    ),
                                    const SizedBox(height: 20.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () =>
                                              _initializeParameter(),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ColorManager.grey,
                                            fixedSize:
                                                const Size.fromHeight(50.0),
                                          ),
                                          child: Text(AppStrings.cancel.tr()),
                                        ),
                                        const SizedBox(width: 20.0),
                                        ElevatedButton(
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              await cubit.changePassword(
                                                  ChangePasswordRequest(
                                                currentPassword:
                                                    currentPassword.text,
                                                newPassword: newPassword.text,
                                                confirmPassword:
                                                    confirmPassword.text,
                                              ));
                                            }
                                          },
                                          style: ElevatedButton.styleFrom(
                                            // backgroundColor: ColorManager.grey,
                                            // minimumSize: const Size.fromHeight(56.0),
                                            fixedSize:
                                                const Size.fromHeight(50.0),
                                          ),
                                          child: Text('حفظ التغيرات'),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),

                          ///
                          // const Spacer(flex: 3),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _listener(context, state) {
    if (state is ChangePasswordSuccessState) {
      ToastAndSnackBar.toastSuccess(message: state.response.message);
    }

    if (state is ChangePasswordErrorState) {
      ToastAndSnackBar.toastError(message: state.error);
    }
  }

  void _initializeParameter() {
    currentPassword.clear();
    newPassword.clear();
    confirmPassword.clear();
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(AppStrings.profile.tr()),
    );
  }
}
