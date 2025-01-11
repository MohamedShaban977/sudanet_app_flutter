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
import '../../../auth/login/presentation/manger/user_secure_storage.dart';
import '../../data/models/personal_info_response.dart';
import '../../domain/entities/personal_info_entity.dart';
import '../cubit/profile_cubit.dart';

class ProfileInfoEditScreen extends StatefulWidget {
  const ProfileInfoEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileInfoEditScreen> createState() => _ProfileInfoEditScreenState();
}

class _ProfileInfoEditScreenState extends State<ProfileInfoEditScreen> {
  late PersonInfoEntity personInfo;

  TextEditingController fullName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phoneNumber = TextEditingController();
  TextEditingController parentPhone = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullName.dispose();
    email.dispose();
    phoneNumber.dispose();
    parentPhone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is GetPersonalInfoSuccessState) {
          personInfo = state.response.data!;
          _initializeParameter();
        }
        if (state is GetPersonalInfoErrorState) {
          ToastAndSnackBar.toastError(message: state.error);
        }
        if (state is SavePersonalInfoSuccessState) {
          ToastAndSnackBar.toastSuccess(message: state.response.message);
        }

        if (state is SavePersonalInfoErrorState) {
          ToastAndSnackBar.toastError(message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: _buildAppBar(),
          body: ModalProgressHUD(
            inAsyncCall: state is SavePersonalInfoLoadingState,
            progressIndicator: Lottie.asset(
              JsonAssets.loader,
              width: 150,
            ),
            child: SizedBox(
              height: context.heightBodyWithNav,
              child: IntrinsicHeight(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: ClampingScrollPhysics()),
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p16),
                    child: Column(
                      children: [
                        const SizedBox(height: 20.0),
                        _buildCardViewInfo(context),
                        const SizedBox(height: 20.0),
                        Text(
                          "${AppStrings.welcome.tr()} \t ${UserSecureStorage.getUser()?.name.orEmpty()}",
                          style: context.displayLarge
                              .copyWith(color: ColorManager.primary),
                        ),
                        const SizedBox(height: 20.0),

                        Text(
                          "بامكانك عرض و تعديل بياناتك الشخصية",
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
                                    hint: AppStrings.fullName.tr(),
                                    controller: fullName,
                                    keyboardType: TextInputType.multiline,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) =>
                                        Validator.isValidUserName(value!),
                                  ),
                                  const SizedBox(height: 20.0),
                                  CustomTextFormField(
                                    hint: AppStrings.email.tr(),
                                    controller: email,
                                    keyboardType: TextInputType.emailAddress,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) =>
                                        Validator.isValidEmail(value!),
                                  ),
                                  const SizedBox(height: 20.0),
                                  CustomTextFormField(
                                    hint: AppStrings.phoneNumber.tr(),
                                    controller: phoneNumber,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.next,
                                    validator: (value) =>
                                        Validator.isValidPhone(value!),
                                  ),
                                  const SizedBox(height: 20.0),
                                  CustomTextFormField(
                                    hint: AppStrings.phoneNumberParent.tr(),
                                    controller: parentPhone,
                                    keyboardType: TextInputType.phone,
                                    textInputAction: TextInputAction.done,
                                    validator: (value) =>
                                        Validator.isValidPhone(value!),
                                  ),
                                  const SizedBox(height: 20.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () => _initializeParameter(),
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
                                            await sl<ProfileCubit>()
                                                .get(context)
                                                .savePersonalInfo(
                                                    PersonInfoResponse(
                                                  name: fullName.text,
                                                  email: email.text,
                                                  phoneNumber: phoneNumber.text,
                                                  parentPhone: parentPhone.text,
                                                ));
                                          }
                                        },
                                        child: Text('حفظ التغيرات'),
                                        style: ElevatedButton.styleFrom(
                                          // backgroundColor: ColorManager.grey,
                                          // minimumSize: const Size.fromHeight(56.0),
                                          fixedSize:
                                              const Size.fromHeight(50.0),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),

                        ///
                        const SizedBox(height: 20.0),
                      ],
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

  void _initializeParameter() {
    fullName.text = personInfo.name;
    email.text = personInfo.email;
    phoneNumber.text = personInfo.phoneNumber;
    parentPhone.text = personInfo.parentPhone;
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(AppStrings.profile.tr()),
    );
  }

  Widget _buildCardViewInfo(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Card(
          margin: const EdgeInsets.all(AppPadding.p8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: ColorManager.background,
          elevation: 10,
          shape: const OvalBorder(),
          // child: CustomViewImageNetwork(
          //   image: url,
          //   height: 130.0,
          //   width: 130.0,
          // ),
          child: Image.asset(
            ImageAssets.avatarStudent,
            gaplessPlayback: true,
            filterQuality: FilterQuality.high,
            fit: BoxFit.cover,
            height: 120.0,
            width: 120.0,
          ),

          ///
          // child: SizedBox(
          //   width: 120.0,
          //   height: 120.0,
          //   child: Icon(
          //     FontAwesomeIcons.userGraduate,
          //     size: 60.0,
          //     color: Colors.blueGrey,
          //   ),
          // ),
        ),
      ],
    );
  }
}
