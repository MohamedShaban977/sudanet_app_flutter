import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../../app/injection_container.dart';
import '../../../../../core/app_manage/color_manager.dart';
import '../../../../../core/app_manage/strings_manager.dart';
import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/routes/magic_router.dart';
import '../../../../../core/service/locale_service/manager/locale_cubit.dart';

class CustomButtonChangeLanguageWidget extends StatelessWidget {
  const CustomButtonChangeLanguageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      width: 50.0,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: ColorManager.primary)),
        fillColor: ColorManager.white,
        elevation: 5.0,
        highlightElevation: 5.0,
        highlightColor: ColorManager.secondary.withValues(alpha: 0.3),
        splashColor: ColorManager.secondary.withValues(alpha: 0.3),
        child: Text(
          AppStrings.lang.tr(),
          textAlign: TextAlign.center,
          style: context.displayLarge.copyWith(
            color: ColorManager.primary,
          ),
        ),
        onPressed: () => sl<LocaleCubit>().get(context).changeLang(context),

        // splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
      ),
    );
    // return Card(
    //   elevation: AppSize.s0,
    //   shape: RoundedRectangleBorder(
    //       borderRadius: BorderRadius.circular(AppSize.s11),
    //       side: const BorderSide(
    //         color: ColorManager.primary,
    //         width: AppSize.s1_5,
    //       )),
    //   color: ColorManager.secondary.withOpacity(0.5),
    //   child: InkWell(
    //     borderRadius: BorderRadius.circular(AppSize.s11),
    //     onTap: () => sl<LocaleCubit>().get(context).changeLang(context),
    //     splashColor: ColorManager.secondary,
    //     child: Padding(
    //       padding: const EdgeInsets.all(AppPadding.p8),
    //       child: SizedBox(
    //         width: AppSize.s25,
    //         height: AppSize.s25,
    //         child: Center(
    //           child: Text(
    //             AppStrings.lang.tr(),
    //             textAlign: TextAlign.center,
    //             style: context.displayLarge.copyWith(
    //               color: ColorManager.primary,
    //             ),
    //           ),
    //         ),
    //       ),
    //     ),
    //   ),
    // );
  }

  Widget rawButton(context) {
    return SizedBox(
      height: 25.0,
      width: 25.0,
      child: RawMaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(color: ColorManager.primary)),
        fillColor: ColorManager.white,
        elevation: 5.0,
        highlightElevation: 5.0,
        highlightColor: ColorManager.secondary.withValues(alpha: 0.3),
        splashColor: ColorManager.secondary.withValues(alpha: 0.3),
        // padding: EdgeInsetsDirectional.symmetric(horizontal: 15.0),
        child: Text(
          AppStrings.lang.tr(),
          textAlign: TextAlign.center,
          style: context.displayLarge.copyWith(
            color: ColorManager.primary,
          ),
        ),
        onPressed: () => sl<LocaleCubit>().get(context).changeLang(context),

        // splashColor: Colors.transparent,
        // highlightColor: Colors.transparent,
      ),
    );
  }
}

class CustomButtonBackWidget extends StatelessWidget {
  const CustomButtonBackWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppSize.s0,
      shape: const CircleBorder(
          // borderRadius: BorderRadius.circular(AppSize.s11),
          side: BorderSide(
        color: ColorManager.primary,
        width: AppSize.s1_5,
      )),
      color: ColorManager.secondary.withValues(alpha: 0.5),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppSize.s11),
        onTap: () => MagicRouter.pop(),
        splashColor: ColorManager.secondary,
        child: const Padding(
          padding: EdgeInsets.all(AppPadding.p8),
          child: SizedBox(
            width: AppSize.s25,
            height: AppSize.s25,
            child: Center(
              child: Icon(
                Icons.arrow_forward_ios_rounded,
                color: ColorManager.primary,
                size: AppSize.s20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
