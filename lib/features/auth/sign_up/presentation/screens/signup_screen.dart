import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app_flutter/features/auth/sign_up/presentation/screens/responsive/tablet_signup_screen.dart';

import '../../../../../app/injection_container.dart';
import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/routes/magic_router.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../widgets/toast_and_snackbar.dart';
import '../../../../../widgets/unfocused_keyboard.dart';
import '../../../login/presentation/manger/user_secure_storage.dart';
import '../../data/models/signup_request.dart';
import '../cubit/signup_cubit.dart';
import 'responsive/mobile_signup_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();
  final TextEditingController phoneNumberParent = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    fullName.dispose();
    password.dispose();
    email.dispose();
    phoneNumber.dispose();
    phoneNumberParent.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: _listener,
      builder: (context, state) {
        return UnFocusedKeyboard(
          child: Scaffold(
            // resizeToAvoidBottomInset: false,
            // appBar: _buildAppBar(),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppPadding.p26),
              child: Form(
                key: _formKey,
                child: Responsive(
                  mobile: MobileSignUpScreen(
                    fullName: fullName,
                    password: password,
                    email: email,
                    phoneNumber: phoneNumber,
                    phoneNumberParent: phoneNumberParent,
                    onTap: _submitLoginButton,
                  ),
                  tablet: TabletSignupScreen(
                    fullName: fullName,
                    password: password,
                    email: email,
                    phoneNumber: phoneNumber,
                    phoneNumberParent: phoneNumberParent,
                    onTap: _submitLoginButton,
                  ),
                  desktop: TabletSignupScreen(
                    fullName: fullName,
                    password: password,
                    email: email,
                    phoneNumber: phoneNumber,
                    phoneNumberParent: phoneNumberParent,
                    onTap: _submitLoginButton,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _listener(context, state) async {
    if (state is SignUpSuccessState) {
      await UserSecureStorage.setUser(data: state.response.data!);
      ToastAndSnackBar.toastSuccess(message: state.response.message);
      MagicRouterName.navigateAndPopUntilFirstPage(RoutesNames.homeCategoriesRoute);
    }
    if (state is SignUpErrorState) {
      ToastAndSnackBar.toastError(message: state.error);
    }
  }

/*  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      foregroundColor: ColorManager.textGray,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.background,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
    );
  }*/

  Future<dynamic> _submitLoginButton() async {
    if (_formKey.currentState!.validate()) {
      await Future.sync(
          () => sl<SignUpCubit>().get(context).signUp(SignUpRequest(
                username: fullName.text,
                password: password.text,
                email: email.text,
                phoneNumber: phoneNumber.text,
                parentPhone: phoneNumberParent.text,
              )));
    }
  }
}
