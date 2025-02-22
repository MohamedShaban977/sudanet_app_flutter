import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/color_manager.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../../../core/app_manage/assets_manager.dart';
import '../../../../core/app_manage/contents_manager.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../auth/login/presentation/manger/user_secure_storage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _startDelay() async {
    // await  Future.sync(() => sl<ContactInfoCubit>().getContactInfo());
    _timer =
        Timer(const Duration(seconds: Constants.splashDelay), () => _goNext());
  }

  _goNext() => MagicRouterName.navigateReplacementTo(_handelRoute());

  _handelRoute() => UserSecureStorage.getToken() != null
      ? RoutesNames.homeCategoriesRoute
      : RoutesNames.loginRoute;

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _buildImage(),
      ),
    );
  }

  _buildImage() => Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            ImageAssets.backgroundSplashImage,
            fit: BoxFit.cover,
            width: context.width,
            height: context.height,
          ),
          Image.asset(
            ImageAssets.appLogo,
            fit: BoxFit.cover,
            width: 350,
            height: 350,
          ),
          Positioned(
            top: context.height * 0.2,
            child: Container(
              width: context.width * 0.9,
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: ColorManager.primary,
                  width: 2,
                ),
                color: ColorManager.white,
              ),
              child: Text('تطبيق مدارس الميرغنية وسودانت للتعليم عن بعد',
                  style: TextStyle(
                    color: Color(0xfff10605),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  )),
            ),
          ),
        ],
      );

// _buildLottieAsset() => Lottie.asset(
//       JsonAssets.splash,
//       animate: true,
//     );
}
