import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/assets_manager.dart';
import 'package:sudanet_app_flutter/core/app_manage/color_manager.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/app_manage/strings_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';
import 'package:sudanet_app_flutter/core/routes/magic_router.dart';
import 'package:sudanet_app_flutter/core/routes/routes_name.dart';
import 'package:sudanet_app_flutter/widgets/custom_app_bar_widget.dart';

class SubjectInfoScreen extends StatelessWidget {
  final String subjectId;
  final String subjectName;

  const SubjectInfoScreen(
      {super.key, required this.subjectId, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: subjectName,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                CardButtonWidget(
                  pathIcon: ImageAssets.onlineLearning,
                  title: AppStrings.classesVideos.tr(),
                  description: '',
                  onTap: () {
                    MagicRouterName.navigateTo(
                      RoutesNames.courseDetails,
                      arguments: {
                        'subject_id': subjectId,
                      },
                    );
                  },
                ),
                CardButtonWidget(
                  pathIcon: ImageAssets.writtenHomework,
                  title: 'الملفات',
                  description: '',
                  onTap: () {
                    MagicRouterName.navigateTo(
                      RoutesNames.writtenHomeworkRoute,
                      arguments: {
                        'subject_id': subjectId,
                      },
                    );
                  },
                ),
                CardButtonWidget(
                  pathIcon: ImageAssets.digitalHomework,
                  title: AppStrings.digitalHomework.tr(),
                  description: '',
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
                  pathIcon: ImageAssets.examsIcon,
                  title: AppStrings.exams.tr(),
                  description: '',
                  onTap: () {
                    MagicRouterName.navigateTo(
                      RoutesNames.examsRoute,
                      arguments: {
                        'subject_id': subjectId,
                      },
                    );
                  },
                ),
              ],
            ),
          )),
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
    return SizedBox(
      height: 120,
      width: context.width,
      child: Card(
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
              horizontal: 24,
              vertical: 24,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  pathIcon,
                  height: 48,
                  width: 48,
                ),
                const SizedBox(width: 12),
                VerticalDivider(
                  width: 10,
                  thickness: 1,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Spacer(),
                      Text(
                        title,
                        style: TextStyle(
                            color: ColorManager.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      // const SizedBox(height: 8),
                      // Expanded(
                      //   child: Text(
                      //     description,
                      //     overflow: TextOverflow.visible,
                      //     style: TextStyle(
                      //         color: ColorManager.textGray2,
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w400),
                      //   ),
                      // ),
                      Spacer(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
