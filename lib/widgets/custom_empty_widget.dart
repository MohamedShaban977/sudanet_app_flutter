import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';


import '../core/app_manage/assets_manager.dart';
import '../core/app_manage/color_manager.dart';
import '../core/app_manage/strings_manager.dart';

class CustomEmptyWidget extends StatelessWidget {
  final bool isSearch;

  const CustomEmptyWidget({super.key, this.isSearch = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: context.heightBodyWithNav,
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            isSearch ? SvgAssets.startSearch : SvgAssets.noData,
            height: context.height * 0.18,
          ),
          const SizedBox(height: 10.0),
          Text(
            isSearch
                ? AppStrings.waitingToSearch.tr()
                : AppStrings.noResultsFound.tr(),
            style: context.displayLarge.copyWith(
              color: ColorManager.textGray,
            ),
          ),
        ],
      )),
    );
  }
}
