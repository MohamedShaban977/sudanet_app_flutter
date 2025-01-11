import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/routes/magic_router.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../widgets/view_image_widget.dart';
import '../../../../categories/presentation/screens/categories_screen.dart';
import '../../../domain/entities/courses_entity.dart';
import '../../widgets/view_info_data_courses_widget.dart';

class CardCoursesTabletWidget extends StatelessWidget {
  final CoursesEntity course;
  final double? height;
  final double? width;
  final CategoriesByType type;

  const CardCoursesTabletWidget({
    super.key,
    required this.course,
    this.height,
    this.width,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (type == CategoriesByType.normal) {
          MagicRouterName.navigateTo(
            RoutesNames.courseDetails,
            arguments: {
              'subject_id': '${course.id}',
            },
          );
        } else if (type == CategoriesByType.homeworks) {
          MagicRouterName.navigateTo(
            RoutesNames.homeworksRoute,
            arguments: {
              'subject_id': '${course.id}',
            },
          );
        } else if (type == CategoriesByType.exams) {
          MagicRouterName.navigateTo(
            RoutesNames.examsRoute,
            arguments: {
              'subject_id': '${course.id}',
            },
          );
        }
      },
      child: Card(
        // margin: const EdgeInsets.all(AppPadding.p8),
        elevation: AppSize.s8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSize.s11)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ImageWidget(
              width: context.width,
              height: 120,
              imagePath: course.imagePath,
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: ViewInfoDataCoursesWidget(course: course),
            ),
          ],
        ),
      ),
    );
/*
    return Card(
      // margin: const EdgeInsets.all(AppPadding.p8),
      elevation: AppSize.s8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s11)),
      clipBehavior: Clip.antiAlias,
      child: IntrinsicHeight(
        child: Column(
          children: [
            Expanded(
              flex: 8,
              child: ImageWidget(
                width: width,
                imagePath:
                    'https://images.pexels.com/photos/13650913/pexels-photo-13650913.jpeg?auto=compress&cs=tinysrgb&w=600',
              ),
            ),
            Expanded(
                flex: 9,
                child: Padding(
                  padding: const EdgeInsets.all(0.0), //AppPadding.p12),
                  child: ViewInfoDataSubjectsWidget(index: index),
                )),
          ],
        ),
      ),
    );
*/
  }
}
