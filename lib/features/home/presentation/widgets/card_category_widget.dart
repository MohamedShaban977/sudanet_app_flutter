import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/contents_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../widgets/view_image_widget.dart';
import '../../../categories/domain/entities/categories_entity.dart';

class CardCategoryWidget extends StatelessWidget {
  final CategoriesEntity category;

  const CardCategoryWidget({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Constants.desiredItemWidth,
      height: context.height * 0.35,
      child: Card(
        margin: const EdgeInsets.all(AppPadding.p12),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s11)),
        clipBehavior: Clip.antiAlias,
        child: IntrinsicHeight(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: ImageWidget(
                  imagePath: category.imagePath,
                  width: context.width,
                ),
              ),
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const SizedBox(height: AppSize.s5),
                        Text(
                          category.name,
                          style: context.bodyMedium
                              .copyWith(color: ColorManager.primary),
                        ),
                        const SizedBox(height: AppSize.s5),
                        ElevatedButton(
                            onPressed: () {
                              MagicRouterName.navigateTo(
                                RoutesNames.coursesByCategoryScreen,
                                arguments: {"id": '${category.id}'},
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(12.0),
                              minimumSize: const Size.fromHeight(40.0),
                              backgroundColor: ColorManager.secondary,
                            ),
                            child: Text(
                              AppStrings.course.tr(),
                              textAlign: TextAlign.center,
                              style: context.displayMedium.copyWith(
                                  color: ColorManager.primary,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15.0),
                            )),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
