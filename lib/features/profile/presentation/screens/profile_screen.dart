import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../core/app_manage/assets_manager.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../auth/login/presentation/manger/user_secure_storage.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SizedBox(
        height: context.heightBodyWithNav,
        child: IntrinsicHeight(
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: ClampingScrollPhysics()),
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p16),
              child: Column(
                children: [
                  SizedBox(height: context.height * 0.02),
                  _buildCardViewInfo(context),
                  SizedBox(height: context.height * 0.02),
                  Text(
                    "${AppStrings.welcome.tr()}   ${UserSecureStorage.getUser()?.name.orEmpty()}",
                    style: context.displayLarge
                        .copyWith(color: ColorManager.textGray),
                  ),

                  SizedBox(height: context.height * 0.04),
                  // CustomButtonProfile(
                  //   iconData: Icons.language,
                  //   text: AppStrings.language.tr(),
                  //   onTap: () => sl<LocaleCubit>().changeLang(context),
                  // ),
                  CustomButtonProfile(
                    iconData: FontAwesomeIcons.solidUser,
                    text: AppStrings.accountInfo.tr(),
                    onTap: () => MagicRouterName.navigateTo(
                        RoutesNames.profileInfoEditRoute),
                  ),
                  SizedBox(height: context.height * 0.02),
                  CustomButtonProfile(
                    iconData: FontAwesomeIcons.unlock,
                    text: AppStrings.changePassword.tr(),
                    onTap: () => MagicRouterName.navigateTo(
                        RoutesNames.changePasswordRoute),
                  ),
                  // SizedBox(height: context.height * 0.02),
                  // CustomButtonProfile(
                  //   iconData: FontAwesomeIcons.book,
                  //   text: AppStrings.myCourses.tr(),
                  //   onTap: () => MagicRouterName.navigateTo(
                  //       RoutesNames.userMyCoursesRoute),
                  // ),
                  // SizedBox(height: context.height * 0.02),
                  // CustomButtonProfile(
                  //   iconData: FontAwesomeIcons.circleInfo,
                  //   text: AppStrings.help.tr(),
                  //   onTap: () =>
                  //       MagicRouterName.navigateTo(RoutesNames.contactInfo),
                  // ),
                  SizedBox(height: context.height * 0.02),
                  CustomButtonProfile(
                    iconData: FontAwesomeIcons.rightFromBracket,
                    text: AppStrings.logout.tr(),
                    onTap: () async {
                      await UserSecureStorage.removeUser().then((value) {
                        MagicRouterName.navigateAndPopAll(
                            RoutesNames.loginRoute);
                      });
                    },
                  ),
                  SizedBox(height: context.height * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      elevation: AppSize.s5,
      centerTitle: false,
      backgroundColor: ColorManager.background,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.background,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      title: Text(AppStrings.profile.tr(),
          style: context.displayLarge.copyWith(
              color: ColorManager.textGray, fontWeight: FontWeight.w700)),
    );
  }

  Widget _buildCardViewInfo(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      clipBehavior: Clip.none,
      children: [
        Card(
          margin: EdgeInsets.all(AppPadding.p8),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: ColorManager.background,
          elevation: 10,
          shape: OvalBorder(),
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

class CustomButtonProfile extends StatelessWidget {
  final IconData iconData;
  final String text;
  final void Function()? onTap;

  const CustomButtonProfile({
    Key? key,
    required this.iconData,
    required this.text,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80.0,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          elevation: 5,
          color: ColorManager.background,
          child: InkWell(
            hoverColor: ColorManager.primary.withOpacity(0.5),
            splashColor: ColorManager.primary,
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  SizedBox(width: context.width * 0.02),
                  Icon(iconData, // Icons.lock_outline,
                      color: ColorManager.textGray,
                      size: 25.0,
                      opticalSize: 25.0),
                  SizedBox(width: context.width * 0.05),
                  Text(text, //'Change Password',
                      style: context.displayMedium),
                  const Spacer(),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 18,
                    color: ColorManager.secondary,
                  ),
                  SizedBox(width: context.width * 0.02),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
