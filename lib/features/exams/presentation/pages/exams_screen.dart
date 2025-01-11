import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/font_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../exam/presentation/screens/exam_screen.dart';
import '../../data/models/exams_by_subject_item_model.dart';
import '../cubit/exams_by_subject_cubit.dart';

class ExamsBySubjectScreen extends StatefulWidget {
  final String subjectId;

  const ExamsBySubjectScreen({super.key, required this.subjectId});

  @override
  State<ExamsBySubjectScreen> createState() => _ExamsBySubjectScreenState();
}

class _ExamsBySubjectScreenState extends State<ExamsBySubjectScreen> {
  List<ExamsBySubjectItemModel> examsBySubject = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocConsumer<ExamsBySubjectCubit, ExamsBySubjectState>(
        listener: (context, state) {
          if (state is ExamsBySubjectSuccessState) {
            examsBySubject = state.response.data ?? [];
          }
        },
        builder: (context, state) {
          if (state is ExamsBySubjectLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ExamsBySubjectErrorState) {
            return Center(child: Text(state.error));
          }
          return ListView.builder(
            itemCount: examsBySubject.length,
            itemBuilder: (context, index) {
              return CellExamBySubject(
                exam: examsBySubject[index],
              );
            },
          );
        },
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: AppSize.s5,
      centerTitle: false,
      backgroundColor: ColorManager.background,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.background,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      title: Text(
        AppStrings.exams.tr(),
        style: context.displayLarge.copyWith(
          color: ColorManager.textGray,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class CellExamBySubject extends StatelessWidget {
  final ExamsBySubjectItemModel exam;

  const CellExamBySubject({Key? key, required this.exam}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: InkWell(
        onTap: () {
          MagicRouterName.navigateTo(
            RoutesNames.examLayoutRoute,
            arguments: {
              'id': '${exam.id}',
              'type': ExamType.exam,
            },
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exam.name ?? '',
                style: context.titleLarge.copyWith(
                  color: ColorManager.primary,
                  fontSize: FontSize.s18,
                ),
              ),
              const SizedBox(height: AppSize.s8),
              Text(
                'عدد الأسئلة : ${exam.questionCount ?? ' '}',
                style: context.titleLarge.copyWith(
                  color: ColorManager.textGray,
                  fontSize: FontSize.s14,
                ),
              ),
              const SizedBox(height: AppSize.s8),
              Text(
                'من ${exam.dateFrom ?? ''} الى ${exam.dateTo ?? ''}',
                style: context.titleLarge.copyWith(
                  color: ColorManager.textGray,
                  fontSize: FontSize.s14,
                ),
              ),
              const SizedBox(height: AppSize.s8),
              Text(
                'مدت الامتحان    ( ${exam.time ?? ''} )    دقائق   ',
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
