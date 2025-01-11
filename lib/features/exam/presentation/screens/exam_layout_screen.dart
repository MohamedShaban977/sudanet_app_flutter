import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../core/app_manage/assets_manager.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../widgets/custom_button_with_loading.dart';
import '../../../../widgets/toast_and_snackbar.dart';
import '../../domain/entities/exam_ready_entity.dart';
import '../cubit/exam_cubit.dart';
import 'exam_screen.dart';

class ExamLayoutScreen extends StatefulWidget {
  final String id;
  final ExamType type;

  const ExamLayoutScreen({super.key, required this.id, required this.type});

  @override
  State<ExamLayoutScreen> createState() => _ExamLayoutScreenState();
}

class _ExamLayoutScreenState extends State<ExamLayoutScreen> {
  late ExamReadyEntity examReadyEntity = const ExamReadyEntity(
    id: 0,
    examName: '',
    questionsCount: 0,
    examTime: '',
    remainingExamTime: '',
  );

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamCubit, ExamState>(
      listener: (context, state) {
        if (state is GetExamReadySuccessState) {
          examReadyEntity = state.response.data!;
        }
        if (state is GetExamReadyErrorState) {
          MagicRouter.pop();
          ToastAndSnackBar.toastError(message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: ModalProgressHUD(
            inAsyncCall: state is GetExamReadyLoadingState,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Spacer(),
                  SvgPicture.asset(SvgAssets.exam, height: context.heightBody * 0.35),
                  const SizedBox(height: 20.0),
                  Text(examReadyEntity.examName,
                      style: context.bodyLarge.copyWith(
                        color: ColorManager.primary,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 20.0),
                  if (widget.type == ExamType.exam) ...[
                    Text(
                      '${AppStrings.examDuration.tr()} \t ${examReadyEntity.examTime}',
                      style: context.displayMedium.copyWith(
                        color: ColorManager.textGray,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20.0),
                    Text('${AppStrings.remainingTime.tr()} \t ${examReadyEntity.remainingExamTime}',
                        style: context.displayMedium.copyWith(
                          color: ColorManager.textGray,
                        ),
                        textAlign: TextAlign.center),
                    const SizedBox(height: 20.0),
                  ],
                  Text('${AppStrings.questionsCount.tr()} \t ${examReadyEntity.questionsCount}',
                      style: context.displayMedium.copyWith(
                        color: ColorManager.textGray,
                      ),
                      textAlign: TextAlign.center),
                  const SizedBox(height: 40.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: CustomButtonWithLoading(
                          text: AppStrings.homeworkStart.tr(),
                          borderRadius: 5.0,
                          height: 50.0,
                          width: context.width,
                          color: ColorManager.secondary,
                          textColors: ColorManager.primary,
                          onTap: () async {
                            MagicRouterName.navigateTo(
                              RoutesNames.examRoute,
                              arguments: {
                                'id': '${examReadyEntity.id}',
                                'type': widget.type,
                              },
                            );
                          }),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
