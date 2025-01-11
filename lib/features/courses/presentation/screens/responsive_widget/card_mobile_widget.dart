import 'package:flutter/material.dart';

import '../../../../../core/app_manage/values_manager.dart';
import '../../../../../widgets/view_image_widget.dart';
import '../../../domain/entities/courses_entity.dart';
import '../../widgets/view_info_data_courses_widget.dart';

class CardSubjectsMobileWidget extends StatelessWidget {
  final CoursesEntity course;
  final double height;
  final double? width;

  const CardSubjectsMobileWidget({
    super.key,
    required this.course,
    required this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(AppPadding.p12),
      elevation: AppSize.s8,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s11)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          SizedBox(
            height: 120,
            child: ImageWidget(
              width: width,
              height: height,
              imagePath:course.imagePath),
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p12),
            child: ViewInfoDataCoursesWidget(course:  course),
          ),
        ],
      ),
    );
  }
}
