import 'package:flutter/material.dart';
import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../core/routes/magic_router.dart';
import '../../../../../core/routes/routes_name.dart';
import '../../../../../widgets/view_image_widget.dart';
import '../../../domain/entities/courses_entity.dart';
import '../../widgets/view_info_data_courses_widget.dart';

class CardCoursesTabletWidget extends StatelessWidget {
  final CoursesEntity course;
  final double? height;
  final double? width;

  const CardCoursesTabletWidget({
    super.key,
    required this.course,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        MagicRouterName.navigateTo(
          RoutesNames.subjectInfoRoute,
          arguments: {
            'subject_id': '${course.id}',
            'subject_name': course.name,
          },
        );
      },
      child: Card(
        elevation: AppSize.s8,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSize.s11)),
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ImageWidget(
              imagePath: course.imagePath,
              height: 180,
            ),
            Divider(
              thickness: 1.1,
            ),
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: ViewInfoDataCoursesWidget(course: course),
            ),
          ],
        ),
      ),
    );
  }
}
