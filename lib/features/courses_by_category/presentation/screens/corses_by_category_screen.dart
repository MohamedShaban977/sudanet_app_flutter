import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/responsive_grid.dart';
import '../../../../widgets/custom_app_bar_widget.dart';
import '../../../../widgets/custom_loading_widget.dart';
import '../../../courses/presentation/screens/responsive_widget/card_tablet_widget.dart';
import '../cubit/courses_by_category_cubit.dart';

const double _desiredItemWidth = 240;

class CoursesByCategoryScreen extends StatelessWidget {
  const CoursesByCategoryScreen(
      {super.key, required this.categoryId, required this.title});

  final String categoryId;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: title),
      body: BlocBuilder<CoursesByCategoryCubit, CoursesByCategoryState>(
        builder: (context, state) {
          final cubit = sl<CoursesByCategoryCubit>().get(context);
          if (state is CoursesByCategoryLoadingState) {
            return const CustomLoadingScreen();
          }

          return RefreshIndicator(
            onRefresh: () async {
              await sl<CoursesByCategoryCubit>()
                  .getCoursesByCategoryId(categoryId);
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
                    Padding(
                      padding: const EdgeInsets.all(AppPadding.p12),
                      child: Text(
                        'المواد الدراسيه',
                        style:
                            Theme.of(context).textTheme.headlineSmall!.copyWith(
                                  color: ColorManager.primary,
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
                        minSpacing: 8.0,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        rowMainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          if (cubit.coursesByCategoryIdItems.isNotEmpty)
                            ...List.generate(
                              cubit.coursesByCategoryIdItems.length,
                              (index) => CardCoursesTabletWidget(
                                course: cubit.coursesByCategoryIdItems[index],
                              ),
                            )
                          else
                            Text(
                              'لا يوجد بيانات لعرضها',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                    color: ColorManager.primary,
                                    fontSize: 20,
                                  ),
                            )
                        ],
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
