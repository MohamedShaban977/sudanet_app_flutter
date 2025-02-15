import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../domain/entities/courses_entity.dart';

class ViewInfoDataCoursesWidget extends StatelessWidget {
  const ViewInfoDataCoursesWidget({
    super.key,
    required this.course,
  });

  final CoursesEntity course;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: AppSize.s5),
        Text(
          course.name,
          style: context.titleMedium.copyWith(color: ColorManager.primary),
        ),
        const SizedBox(height: AppSize.s5),
        Text(
          course.categoryName,
          style: context.titleLarge.copyWith(
            color: ColorManager.textGray2,
          ),
          maxLines: 1,
        ),
        const SizedBox(height: AppSize.s5),
        Text(
          course.teacherName,
          style: context.titleLarge.copyWith(color: ColorManager.textGray2),
        ),
        const SizedBox(height: AppSize.s5),
      ],
    );
  }
}
