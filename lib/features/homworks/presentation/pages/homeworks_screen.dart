import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../cubit/homework_student_cubit.dart';
import '../widgets/cell_homeworks_student.dart';

class HomeworksScreen extends StatelessWidget {
  final String subjectId;

  const HomeworksScreen({super.key, required this.subjectId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: BlocBuilder<HomeworkStudentCubit, HomeworkStudentState>(
          builder: (context, state) {
            final homeworksCubit = sl<HomeworkStudentCubit>().get(context);
            if (state is HomeworkStudentLoadingState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeworkStudentErrorState) {
              return Center(child: Text(state.error));
            }
            return ListView.builder(
              itemCount: homeworksCubit.homeworks.length,
              itemBuilder: (context, index) {
                return CellHomeworksStudent(
                  homework: homeworksCubit.homeworks[index],
                );
              },
            );
          },
        ),
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
        AppStrings.homeworks.tr(),
        style: context.displayLarge.copyWith(
          color: ColorManager.textGray,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}
