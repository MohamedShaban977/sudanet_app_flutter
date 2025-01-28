import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/service/locale_service/manager/locale_cubit.dart';
import '../../../../widgets/bottom_navy_bar.dart';
import '../cubit/nav_bar_cubit.dart';
import '../widgets/custom_nav_bar_widget.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  final menuItemList = <MenuItem>[
    MenuItem(
      0,
      icon: FontAwesomeIcons.houseChimney,
      text: AppStrings.home.tr(),
    ),
    MenuItem(
      1,
      icon: Icons.grid_view_sharp,
      text: AppStrings.educationalLevels.tr(),
    ),
    MenuItem(
      2,
      icon: FontAwesomeIcons.book,
      text: AppStrings.subjects.tr(),
    ),
    MenuItem(
      3,
      icon: Icons.person_2,
      text: AppStrings.profile.tr(),
    ),
  ];

  late List<BottomNavyBarItem> items = menuItemList.map((e) {
    return BottomNavyBarItem(
      icon: Icon(e.icon),
      title: Text(e.text),
      activeColor: ColorManager.primary,
      inactiveColor: Colors.grey,
      backgroundColorItem: ColorManager.secondary,
    );
  }).toList();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavBarCubit(),
      child: BlocBuilder<NavBarCubit, NavBarState>(
        builder: (context, state) {
          final cubit = NavBarCubit.get(context);
          return Scaffold(
            bottomNavigationBar: BlocBuilder<LocaleCubit, LocaleState>(
              builder: (context, state) {
                return Localizations.override(
                  context: context,
                  locale: state.locale,
                  child: PopScope(
                    canPop: cubit.currentIndex == 0,
                    onPopInvokedWithResult: (canPop,result) async =>cubit.changeIndex(0),
                    child: CustomNavBarWidget(
                      currentIndex: cubit.currentIndex,
                      onItemSelected: (int index) => cubit.changeIndex(index),
                      items: <BottomNavyBarItem>[
                        BottomNavyBarItem(
                          icon: const Icon(FontAwesomeIcons.houseChimney),
                          title: Text(AppStrings.home.tr()),
                          activeColor: ColorManager.primary,
                          inactiveColor: Colors.grey,
                          backgroundColorItem: ColorManager.secondary,
                        ),
                        BottomNavyBarItem(
                          icon: const Icon(Icons.menu_book_outlined),
                          title: Text(AppStrings.homeworks.tr()),
                          activeColor: ColorManager.primary,
                          inactiveColor: Colors.grey,
                          backgroundColorItem: ColorManager.secondary,
                        ),
                        BottomNavyBarItem(
                          icon: const Icon(FontAwesomeIcons.book),
                          title: Text(AppStrings.exams.tr()),
                          activeColor: ColorManager.primary,
                          inactiveColor: Colors.grey,
                          backgroundColorItem: ColorManager.secondary,
                        ),
                        // BottomNavyBarItem(
                        //   icon: const Icon(FontAwesomeIcons.circleQuestion),
                        //   title: Text(AppStrings.help.tr()),
                        //   activeColor: ColorManager.primary,
                        //   inactiveColor: Colors.grey,
                        //   backgroundColorItem: ColorManager.secondary,
                        // ),
                        BottomNavyBarItem(
                          icon: const Icon(Icons.person_2),
                          title: Text(AppStrings.profile.tr()),
                          activeColor: ColorManager.primary,
                          inactiveColor: Colors.grey,
                          backgroundColorItem: ColorManager.secondary,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            body: cubit.screens()[cubit.currentIndex],
          );
        },
      ),
    );
  }
}

class MenuItem {
  const MenuItem(this.index, {required this.icon, required this.text});

  final int index;
  final IconData icon;
  final String text;
}

