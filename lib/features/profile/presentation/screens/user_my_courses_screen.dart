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
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../widgets/custom_app_bar_widget.dart';
import '../../../../widgets/custom_empty_widget.dart';
import '../../../../widgets/custom_loading_widget.dart';
import '../../../../widgets/view_image_widget.dart';
import '../cubit/profile_cubit.dart';

const double _heightItem = 150;
const double _desiredItemWidth = 260;

class UserMyCoursesScreen extends StatelessWidget {
  const UserMyCoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: AppStrings.myCourses.tr()),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          final cubit = sl<ProfileCubit>().get(context);
          if (state is GetUserMyCoursesLoadingState) {
            return const CustomLoadingScreen();
          }
          return RefreshIndicator(
            onRefresh: () async {
              await sl<ProfileCubit>().getUserMyCourses();
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
                      alignment: AlignmentDirectional.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "كورساتك الحالية",
                            style: context.displayLarge
                                .copyWith(color: ColorManager.textGray),
                          ),
                          Text(
                            "بامكانك عرض جميع الكورسات التى تم شراؤها",
                            style: context.displayMedium
                                .copyWith(color: ColorManager.textGray),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSize.s20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: cubit.myCourses.isEmpty
                          ? const CustomEmptyWidget()
                          : ResponsiveGridList(
                              desiredItemWidth: Responsive.isMobileS(context) ||
                                      Responsive.isMobile(context)
                                  ? context.width * 0.4
                                  : _desiredItemWidth,
                              minSpacing: 2.0,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              children: List.generate(
                                cubit.myCourses.length,
                                (index) => GestureDetector(
                                  onTap: () => MagicRouterName.navigateTo(
                                    RoutesNames.courseDetails,
                                    arguments: {
                                      'id': '${cubit.myCourses[index].courseId}'
                                    },
                                  ),
                                  child: Card(
                                    // margin: const EdgeInsets.all(AppPadding.p8),
                                    elevation: AppSize.s8,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(AppSize.s11)),
                                    clipBehavior: Clip.antiAlias,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ImageWidget(
                                            width: context.width,
                                            height: _heightItem,
                                            imagePath: cubit
                                                .myCourses[index].courseImage),
                                        Padding(
                                          padding: const EdgeInsets.all(
                                              AppPadding.p8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                  height: AppSize.s5),
                                              Text(
                                                cubit.myCourses[index]
                                                    .courseName,
                                                style: context.displayLarge
                                                    .copyWith(
                                                        color: ColorManager
                                                            .primary),
                                              ),
                                              const SizedBox(
                                                  height: AppSize.s5),
                                              Text(
                                                cubit.myCourses[index]
                                                    .teacherName,
                                                style: context.bodyMedium
                                                    .copyWith(
                                                        color: ColorManager
                                                            .textGray),
                                              ),
                                              const SizedBox(
                                                  height: AppSize.s5),
                                              Text(
                                                cubit.myCourses[index]
                                                    .buyingDate,
                                                style: context.bodyMedium
                                                    .copyWith(
                                                        color: ColorManager
                                                            .textGray),
                                              ),
                                              const SizedBox(
                                                  height: AppSize.s5),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
