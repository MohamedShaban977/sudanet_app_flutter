import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/assets_manager.dart';
import 'package:sudanet_app_flutter/core/app_manage/color_manager.dart';
import 'package:sudanet_app_flutter/core/app_manage/strings_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';
import 'package:sudanet_app_flutter/core/responsive/responsive.dart';
import 'package:sudanet_app_flutter/core/routes/magic_router.dart';
import 'package:sudanet_app_flutter/core/routes/routes_name.dart';
import 'package:sudanet_app_flutter/widgets/custom_app_bar_widget.dart';

class SubjectInfoScreen extends StatelessWidget {
  final String subjectId;
  final String subjectName;

  const SubjectInfoScreen({super.key, required this.subjectId, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: subjectName,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView(
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: Responsive.isMobileS(context) ? 4 : 16,
            mainAxisSpacing: Responsive.isMobileS(context) ? 4 : 8,
            childAspectRatio: Responsive.isMobileS(context) ? 1.0 : 1.2,
          ),
          children: [
            CardButtonWidget(
              pathIcon: ImageAssets.exams,
              title: AppStrings.exam.tr(),
              description: 'ختبر معلوماتك وأجب على الأسئلة',
              onTap: () {
                MagicRouterName.navigateTo(
                  RoutesNames.examsRoute,
                  arguments: {
                    'subject_id': subjectId,
                  },
                );
              },
            ),
            CardButtonWidget(
              pathIcon: ImageAssets.homeworks,
              title: AppStrings.homeworks.tr(),
              description: 'حل الواجب لتحسين فهمك.',
              onTap: () {
                MagicRouterName.navigateTo(
                  RoutesNames.homeworksRoute,
                  arguments: {
                    'subject_id': subjectId,
                  },
                );
              },
            ),
            CardButtonWidget(
              pathIcon: ImageAssets.onlineLearning,
              title: 'متابعه الكورس',
              description: 'تعلم واكتسب مهارات جديدة خطوة بخطوة.',
              onTap: () {
                MagicRouterName.navigateTo(
                  RoutesNames.courseDetails,
                  arguments: {
                    'subject_id': subjectId,
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CardButtonWidget extends StatelessWidget {
  final String pathIcon;
  final String title;

  final String description;
  final void Function()? onTap;

  const CardButtonWidget({
    super.key,
    required this.pathIcon,
    required this.title,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorManager.white,
      elevation: 15,
      shadowColor: ColorManager.lightGrey.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16.0),
        onTap: onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.isMobileS(context) ? 12 : 16,
            vertical: Responsive.isMobileS(context) ? 12 : 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                pathIcon,
                height: 50,
                width: 50,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(color: ColorManager.textGray, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  description,
                  maxLines: 3,
                  overflow: TextOverflow.visible,
                  style: TextStyle(color: ColorManager.darkGrey, fontSize: 12, fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
