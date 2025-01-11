import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../core/app_manage/assets_manager.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget(
      {Key? key,
      required this.inAsyncCall,
      required this.child,
      this.isCondition = false})
      : super(key: key);
  final bool inAsyncCall;
  final Widget child;
  final bool isCondition;

  @override
  Widget build(BuildContext context) {
    if (isCondition) {
      if (inAsyncCall) {
        return Scaffold(
          backgroundColor: Colors.white54,
          body: Center(child: _buildLoader()),
        );
      } else {
        return child;
      }
    } else {
      return ModalProgressHUD(
        inAsyncCall: inAsyncCall,
        progressIndicator: _buildLoader(),
        child: child,
      );
    }
  }

  LottieBuilder _buildLoader() {
    return Lottie.asset(
      JsonAssets.loader,
      width: 150,
    );
  }
}

class CustomLoadingScreen extends StatelessWidget {
  const CustomLoadingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildLoader(),
      ),
    );
  }

  LottieBuilder _buildLoader() {
    return Lottie.asset(
      JsonAssets.loader,
      width: 150,
    );
  }
}
