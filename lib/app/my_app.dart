import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app_flutter/widgets/screenshot_prevention_widget.dart';
import 'package:vibration/vibration.dart';

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
  void initState() {
    super.initState();
    testVibration();
  }

  Future<void> testVibration() async {
    if (await Vibration.hasVibrator()) {
      print('الجهاز يدعم الاهتزاز');
      Vibration.vibrate();
      print('تم اختبار الاهتزاز بنجاح');
    } else {
      print('الجهاز لا يدعم الاهتزاز');
      if (kDebugMode) return;
      SystemNavigator.pop(); // Exit the app
    }
  }

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
        builder: (context, state) => ScreenshotPreventionWidget(
          child: MaterialApp(
            title: 'Al-Mirghaniyah Online',
            debugShowCheckedModeBanner: false,
            // locale: DevicePreview.locale(context),
            builder: (context, child) => child ?? SizedBox.square(),
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
            localizationsDelegates:
                AppLocalizationsSetup.localizationsDelegates,
            locale: state.locale,
          ),
        ),
      ),
    );
  }
}
