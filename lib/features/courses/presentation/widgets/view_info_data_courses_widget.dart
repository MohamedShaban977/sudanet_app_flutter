import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../course_details/presentation/screens/purchase_course_widget.dart';
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
            color: ColorManager.textGray,
          ),
          maxLines: 1,
        ),
        const SizedBox(height: AppSize.s5),
        Text(
          course.teacherName,
          style: context.bodyMedium.copyWith(color: ColorManager.textGray),
        ),
        const SizedBox(height: AppSize.s5),
        // Text(
        //   '${course.price} ${course.currencyName}',
        //   style: context.displayLarge.copyWith(color: ColorManager.primary),
        //   overflow: TextOverflow.fade,
        // ),
        const SizedBox(height: AppSize.s5),
        // ElevatedButton(
        //     onPressed: () => _buildPurchaseCourses(context),
        //     style: ElevatedButton.styleFrom(
        //       backgroundColor: ColorManager.secondary,
        //       padding: const EdgeInsets.all(12.0),
        //       minimumSize: const Size.fromHeight(40.0),
        //     ),
        //     child: Text(
        //       AppStrings.purchase.tr(),
        //       style: context.titleLarge.copyWith(
        //           color: ColorManager.primary, fontWeight: FontWeight.w600),
        //       textAlign: TextAlign.center,
        //       // overflow: TextOverflow.fade,
        //     )),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: [
        //     Expanded(
        //       flex: 2,
        //       child: Text(
        //         '${course.price} ${course.currencyName}',
        //         style:
        //             context.displayLarge.copyWith(color: ColorManager.primary),
        //         overflow: TextOverflow.fade,
        //       ),
        //     ),
        //     Flexible(
        //       flex: 4,
        //       child:
        //     ),
        //   ],
        // ),
      ],
    );
  }

  PurchaseCourses _buildPurchaseCourses(BuildContext context) {
    return PurchaseCourses.show(
      context,
      courseId: course.id,
      isAlert: true,
    );
  }
}
