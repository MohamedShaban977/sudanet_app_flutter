import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../domain/entities/categories_entity.dart';

class ViewInfoDataCardCategoriesWidget extends StatelessWidget {
  const ViewInfoDataCardCategoriesWidget({
    super.key,
    required this.category,required this.onPressed,
  });

  final void Function()? onPressed;
  final CategoriesEntity category;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(height: AppSize.s8),
        Text(
          category.name,
          style: context.displayMedium.copyWith(color: ColorManager.primary),
        ),
        const Spacer(),
        ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(12.0),
              minimumSize: const Size.fromHeight(40.0),
            ),
            child: Text(
              AppStrings.findAvailableSubjects.tr(),
              textAlign: TextAlign.center,
              style: context.displayMedium.copyWith(
                  color: ColorManager.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 15.0),
            )),
      ],
    );
  }
}
