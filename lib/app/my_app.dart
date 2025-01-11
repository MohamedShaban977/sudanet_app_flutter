import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/app_manage/theme_manager.dart';
import '../core/locale/app_localizations_setup.dart';
import '../core/routes/magic_router.dart';
import '../core/routes/routes_manager.dart';
import '../core/routes/routes_name.dart';
import '../core/service/locale_service/manager/locale_cubit.dart';
import 'injection_container.dart';

class MyApp extends StatefulWidget {
  const MyApp._internal();

// singleton or single instance
  static const MyApp _instance = MyApp._internal();

  factory MyApp() => _instance; // factory

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<LocaleCubit>()..getSavedLang(),
        ),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen: (previousState, currentState) {
          return previousState != currentState;
        },
        builder: (context, state) => MaterialApp(
          title: 'Al-Mirghaniyah Online',
          debugShowCheckedModeBanner: false,

          useInheritedMediaQuery: true,
          // locale: DevicePreview.locale(context),
          builder: DevicePreview.appBuilder,
          // theme: ThemeData.light(),
          // darkTheme: ThemeData.dark(),
          //Themes
          theme: getApplicationTheme(),
          // darkTheme: appThemeDark(), // darkTheme

          ///Routes
          onGenerateRoute: Routes.onGenerateRoute,
          initialRoute: RoutesNames.initialRoute,
          navigatorKey: navigatorKey,

          ///Locales
          supportedLocales: AppLocalizationsSetup.supportedLocales,
          localeResolutionCallback:
              AppLocalizationsSetup.localeResolutionCallback,
          localizationsDelegates: AppLocalizationsSetup.localizationsDelegates,
          locale: state.locale,
        ),
      ),
    );
  }
}
