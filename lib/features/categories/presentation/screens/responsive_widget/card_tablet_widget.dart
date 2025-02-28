import 'package:flutter/material.dart';

import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/routes/magic_router.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../widgets/view_image_widget.dart';
import '../../../domain/entities/categories_entity.dart';
import '../../widgets/view_info_data_category_widget.dart';

class CardCategoriesTabletWidget extends StatelessWidget {
  final CategoriesEntity category;
  final double? height;
  final double? width;

  const CardCategoriesTabletWidget({super.key, required this.category, this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppPadding.p12),
      elevation: AppSize.s8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s11)),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: ImageWidget(width: width, imagePath: category.imagePath),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p12),
                  child: ViewInfoDataCardCategoriesWidget(
                      category: category,
                      onPressed: () {
                        MagicRouterName.navigateTo(
                          RoutesNames.coursesByCategoryScreen,
                          arguments: {
                            "id": '${category.id}',
                            'title': category.name,
                          },
                        );
                      }),
                )),
          ],
        ),
      ),
    );
  }
}
