import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';
import 'package:sudanet_app_flutter/core/routes/magic_router.dart';
import 'package:sudanet_app_flutter/core/routes/routes_name.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/responsive/responsive.dart';
import '../../../../core/responsive/responsive_grid.dart';
import '../../../../widgets/custom_loading_widget.dart';
import '../../../exams/presentation/cubit/exams_by_subject_cubit.dart';
import '../../../exams/presentation/pages/exams_screen.dart';
import '../cubit/categories_cubit.dart';
import 'responsive_widget/card_mobile_widget.dart';
import 'responsive_widget/card_tablet_widget.dart';

const double _heightItem = 140;
const double _desiredItemWidth = 250;

enum CategoriesByType {
  normal,
  homeworks,
  exams,
}

class CategoriesScreen extends StatelessWidget {
  final CategoriesByType type;

  const CategoriesScreen({super.key}) : type = CategoriesByType.normal;

  const CategoriesScreen.homework({super.key}) : type = CategoriesByType.homeworks;

  const CategoriesScreen.exams({super.key}) : type = CategoriesByType.exams;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: BlocBuilder<CategoriesCubit, CategoriesState>(
        builder: (context, state) {
          final cubit = sl<CategoriesCubit>().get(context);
          if (state is GetAllCategoriesLoadingState) {
            return const CustomLoadingScreen();
          }
          return RefreshIndicator(
            onRefresh: () async {
              await sl<CategoriesCubit>().getCategories();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(parent: ClampingScrollPhysics()),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (type == CategoriesByType.exams || type == CategoriesByType.normal)
                    BlocConsumer<ExamsBySubjectCubit, ExamsBySubjectState>(
                      builder: (context, state) {
                        final examsBySubjectCubit = sl<ExamsBySubjectCubit>().get(context);

                        if (examsBySubjectCubit.examsNotification.isNotEmpty) {
                          return SizedBox(
                            height: 200,
                            width: context.width,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: examsBySubjectCubit.examsNotification.length,
                              physics: const ClampingScrollPhysics(),
                              itemBuilder: (context, index) {
                                return CellExamBySubject(
                                  exam: examsBySubjectCubit.examsNotification[index],
                                );
                              },
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                      listener: (context, state) {},
                    ),
                  const SizedBox(height: AppSize.s20),
                  Padding(
                    padding: const EdgeInsets.all(AppPadding.p12),
                    child: Text(
                      AppStrings.viewAllEducationalLevels.tr(),
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: ColorManager.primary,
                          ),
                    ),
                  ),

                  ///
                  ResponsiveGridList(
                    rowMainAxisAlignment: MainAxisAlignment.start,
                    desiredItemWidth: Responsive.isMobileS(context) || Responsive.isMobile(context)
                        ? context.width
                        : _desiredItemWidth,
                    minSpacing: AppSize.s1,
                    shrinkWrap: true,
                    physics: const ClampingScrollPhysics(),
                    children: List.generate(
                      cubit.categoriesItems.length,
                      (index) => Responsive(
                        mobile: CardCategoriesMobileWidget(
                          category: cubit.categoriesItems[index],
                          height: _heightItem,
                          type: type,
                        ),
                        tablet: CardCategoriesTabletWidget(
                          category: cubit.categoriesItems[index],
                          width: context.width,
                          type: type,
                        ),
                        desktop: CardCategoriesTabletWidget(
                          category: cubit.categoriesItems[index],
                          width: context.width,
                          type: type,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
          CategoriesByType.exams == type
              ? AppStrings.exams.tr()
              : CategoriesByType.homeworks == type
                  ? AppStrings.homeworks.tr()
                  : AppStrings.educationalLevels.tr(),
          style: context.displayLarge.copyWith(color: ColorManager.textGray, fontWeight: FontWeight.w700)),
      actions: [
        Padding(
          padding: const EdgeInsetsDirectional.symmetric(horizontal: 8, vertical: 8),
          child: RawMaterialButton(
            onPressed: () => MagicRouterName.navigateTo(RoutesNames.profileRoute),
            fillColor: ColorManager.white,
            elevation: 50,
            constraints: BoxConstraints(minHeight: 35, maxWidth: 40, minWidth: 40, maxHeight: 35),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppMargin.m12),
            ),
            padding: EdgeInsets.zero,
            child: Icon(
              FontAwesomeIcons.user,
              color: ColorManager.primary,
              size: 16,
            ),
          ),
        )
      ],
    );
  }
}
