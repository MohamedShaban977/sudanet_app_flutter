import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../widgets/view_image_widget.dart';
import '../../../course_details/presentation/screens/purchase_course_widget.dart';
import '../../../courses/domain/entities/courses_entity.dart';

class CardCourseWidget extends StatelessWidget {
  final CoursesEntity course;

  const CardCourseWidget({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.0,
      height: 280.0,
      child: GestureDetector(
        onTap: () => MagicRouterName.navigateTo(
          RoutesNames.courseDetails,
          arguments: {'id': '${course.id}'},
        ),
        child: Card(
          margin: const EdgeInsets.all(AppPadding.p12),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppSize.s11)),
          clipBehavior: Clip.antiAlias,
          child: IntrinsicHeight(
            child: Column(
              children: [
                Expanded(
                  flex: 3,
                  child: ImageWidget(imagePath: course.imagePath),
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
                            course.name,
                            style: context.displayMedium
                                .copyWith(color: ColorManager.primary),
                          ),
                          const SizedBox(height: AppSize.s5),
                          Text(
                            course.teacherName,
                            style: context.bodySmall
                                .copyWith(color: ColorManager.textGray),
                          ),
                          const SizedBox(height: AppSize.s5),
                          ElevatedButton(
                              onPressed: () => _buildPurchaseCourses(context),
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.all(12.0),
                                minimumSize: const Size.fromHeight(40.0),
                                backgroundColor: ColorManager.secondary,
                              ),
                              child: Text(
                                '${course.price} ${course.currencyName}',
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
      ),
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
