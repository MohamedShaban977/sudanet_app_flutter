import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';
import 'package:sudanet_app_flutter/widgets/screenshot_prevention_widget.dart';

import '../../../../../app/injection_container.dart';
import '../../../../../core/app_manage/color_manager.dart';
import '../../../../../core/app_manage/strings_manager.dart';
import '../../../../../core/app_manage/theme_manager.dart';
import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/packages/quickalert/models/quickalert_type.dart';
import '../../../../../core/packages/quickalert/widgets/quickalert_dialog.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/routes/magic_router.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../widgets/toast_and_snackbar.dart';
import '../../../../../widgets/unfocused_keyboard.dart';
import '../../data/models/login_request.dart';
import '../cubit/login_cubit.dart';
import '../manger/user_secure_storage.dart';
import 'responsive/mobile_login_screen.dart';
import 'responsive/tablet_login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? guidId;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    UserSecureStorage.removeUser();
    getMacID();
  }

  getMacID() async {
    String? res = await UserSecureStorage.getMacId();
    if (kDebugMode) {
      print(res);
    }
    if (res != null) {
      guidId = res;
    }
  }

  @override
  Widget build(BuildContext context) {
    statusBarColor(color: Colors.grey[100]);
    return ScreenshotPreventionWidget(
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: _listener,
        builder: (context, state) {
          return UnFocusedKeyboard(
            child: Scaffold(
              backgroundColor: Color(0xFFDDE8EA),
              resizeToAvoidBottomInset: false,
              // appBar: _buildAppBar(),
              body: Form(
                key: _formKey,
                child: Responsive(
                  mobile: MobileLoginScreen(
                    email: email,
                    password: password,
                    onTap: _submitLoginButton,
                    onPressedTestLogin: () {
                      email.text = 'EmanAyman-G8@suda-net.edu';
                      password.text = "123456789";
                      guidId = '';
                    },
                  ),
                  tablet: TabletLoginScreen(
                    email: email,
                    password: password,
                    onTap: _submitLoginButton,
                  ),
                  desktop: TabletLoginScreen(
                    email: email,
                    password: password,
                    onTap: _submitLoginButton,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _listener(context, state) async {
    if (state is LoginSuccessState) {
      guidId = state.response.data!.guid;
      ToastAndSnackBar.toastSuccess(message: state.response.message);
      MagicRouterName.navigateAndPopAll(RoutesNames.homeCategoriesRoute);
    }
    if (state is LoginErrorState) {
      _alertHelper(context, state);
    }
  }

  _alertHelper(context, LoginErrorState state) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: AppStrings.error.tr(),
      text: state.error,
      confirmBtnText: AppStrings.help.tr(),
      cancelBtnText: AppStrings.cancel.tr(),
      confirmBtnColor: ColorManager.primary,
      showCancelBtn: true,
      customWidget: Container(
        color: Colors.red,
        child: Container(
          height: 150.0,
          margin: const EdgeInsets.all(50.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2.0,
            ),
          ),
          child: const Icon(
            FontAwesomeIcons.xmark,
            color: Colors.white,
          ),
        ),
      ),
      onConfirmBtnTap: () {},
    );
  }

  Future<dynamic> _submitLoginButton() async {
    if (_formKey.currentState!.validate()) {
      await Future.sync(
          () async => sl<LoginCubit>().get(context).login(LoginRequest(
                email: email.text,
                password: password.text,
                macAddress: guidId,
              )));
    }
  }
}

/// responsive
