import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../main_layout_home/presentation/cubit/nav_bar_cubit.dart';
import '../cubit/home_cubit.dart';
import 'card_category_widget.dart';

class CategoriesWidget extends StatelessWidget {
  final HomeCubit cubit;

  const CategoriesWidget({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 20.0, end: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'المراحل التعليميه الاكثر مشاهده',
                style: context.displayMedium
                    .copyWith(color: ColorManager.textGray),
              ),
              TextButton(
                onPressed: () => NavBarCubit.get(context).changeIndex(1),
                style: TextButton.styleFrom(
                    foregroundColor: ColorManager.secondary,
                    side: const BorderSide(
                        color: ColorManager.secondary, width: 2)),
                child: Text(
                  AppStrings.more.tr(),
                  style:
                      context.bodySmall.copyWith(color: ColorManager.primary),
                ),
              )
            ],
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const ClampingScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(
                cubit.categoriesItems.length,
                (index) => CardCategoryWidget(
                      category: cubit.categoriesItems[index],
                    )),
          ),
        ),
      ],
    );
  }
}
