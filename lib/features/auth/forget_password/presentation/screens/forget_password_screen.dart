import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app/injection_container.dart';
import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/responsive/responsive.dart';
import '../../../../../core/routes/magic_router.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../widgets/toast_and_snackbar.dart';
import '../../../../../widgets/unfocused_keyboard.dart';
import '../../data/models/forget_password_request.dart';
import '../cubit/forget_password_cubit.dart';
import 'responsive/mobile_forget_password_screen.dart';
import 'responsive/tablet_forget_password_screen.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController email = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordCubit, ForgetPasswordState>(
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
                  mobile: MobileForgetPasswordScreen(
                    email: email,
                    onTap: _submitLoginButton,
                  ),
                  tablet: TabletForgetPasswordScreen(
                    email: email,
                    onTap: _submitLoginButton,
                  ),
                  desktop: TabletForgetPasswordScreen(
                    email: email,
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

  void _listener(context, state) {
    if (state is ForgetPasswordSuccessState) {
      ToastAndSnackBar.toastSuccess(message: state.response.message);
      MagicRouterName.navigateAndPopUntilFirstPage(RoutesNames.loginRoute);
    }
    if (state is ForgetPasswordErrorState) {
      ToastAndSnackBar.toastError(message: state.error);
    }
  }

  Future<dynamic> _submitLoginButton() async {
    if (_formKey.currentState!.validate()) {
      // await Future.delayed(const Duration(seconds: 5), () => null);
      await Future.sync(() => sl<ForgetPasswordCubit>()
          .get(context)
          .forgetPassword(ForgetPasswordRequest(
            email: email.text,
          )));
    }
  }
}
