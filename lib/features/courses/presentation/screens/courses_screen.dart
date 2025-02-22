import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/responsive_grid.dart';
import '../../../../widgets/custom_app_bar_widget.dart';
import '../../../../widgets/custom_loading_widget.dart';
import '../cubit/courses_cubit.dart';
import 'responsive_widget/card_tablet_widget.dart';

const double _heightItem = 140;
const double _desiredItemWidth = 260;

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: title),
      body: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) {
          final cubit = sl<CoursesCubit>().get(context);
          if (state is GetCoursesLoadingState) {
            return const CustomLoadingScreen();
          }
          return RefreshIndicator(
            onRefresh: () async {
              await sl<CoursesCubit>().getAllCourses();
            },
            child: SizedBox(
              height: context.height - kToolbarHeight,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                    parent: ClampingScrollPhysics()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppSize.s20),
                    Align(
                      alignment: AlignmentDirectional.centerStart,
                      child: Padding(
                        padding: const EdgeInsets.all(AppPadding.p12),
                        child: Text(
                          AppStrings.subjects.tr(),
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    color: ColorManager.primary,
                                  ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: ResponsiveGridList(
                        desiredItemWidth: Responsive.isMobileS(context) ||
                                Responsive.isMobile(context)
                            ? context.width * 0.4
                            : _desiredItemWidth,
                        minSpacing: 2.0,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        children: List.generate(
                          cubit.coursesAllItems.length,
                          (index) => CardCoursesTabletWidget(
                              height: _heightItem,
                              course: cubit.coursesAllItems[index]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
