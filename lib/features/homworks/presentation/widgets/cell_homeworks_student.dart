import 'package:flutter/material.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/font_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../exam/presentation/screens/exam_screen.dart';
import '../../data/models/homework_item_model.dart';

class CellHomeworksStudent extends StatelessWidget {
  final HomeworkItemModel homework;

  const CellHomeworksStudent({super.key, required this.homework});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppMargin.m12),
      ),
      child: InkWell(
        onTap: () {
          MagicRouterName.navigateTo(
            RoutesNames.examLayoutRoute,
            arguments: {
              'id': '${homework.id}',
              'type': ExamType.homework,
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                homework.name ?? '',
                style: context.titleLarge.copyWith(
                  color: ColorManager.primary,
                  fontSize: FontSize.s18,
                ),
              ),
              const SizedBox(height: AppSize.s8),
              Text(
                'عدد الأسئلة : ${homework.questionCount ?? ' '}',
                style: context.titleLarge.copyWith(
                  color: ColorManager.textGray,
                  fontSize: FontSize.s14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
