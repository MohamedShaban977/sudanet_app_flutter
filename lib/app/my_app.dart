import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app_flutter/widgets/screenshot_prevention_widget.dart';

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
        builder: (context, state) => ScreenshotPreventionWidget(
          child: MaterialApp(
            title: 'Al-Mirghaniyah Online',
            debugShowCheckedModeBanner: false,
            // locale: DevicePreview.locale(context),
            builder: (context, child) => kDebugMode?  child ?? SizedBox.square():EmulatorCheck(
              child: child ?? SizedBox.square(),
            ),
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

class EmulatorCheck extends StatefulWidget {
  const EmulatorCheck({super.key, required this.child});

  final Widget child;

  @override
  State createState() => _EmulatorCheckState();
}

class _EmulatorCheckState extends State<EmulatorCheck> {
  bool _isLoading = true;
  bool _isEmulator = false;

  @override
  void initState() {
    super.initState();
    _checkEmulator();
  }

  Future<void> _checkEmulator() async {
    bool result = await EmulatorDetector.isEmulator();
    setState(() {
      _isEmulator = result;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.white,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_isEmulator) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "This app cannot run on emulators",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text("Exit App"),
              ),
            ],
          ),
        ),
      );
    }

    // Your actual app content
    return widget.child;
  }
}

class EmulatorDetector {
  static Future<bool> isEmulator() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (defaultTargetPlatform == TargetPlatform.android) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

        return androidInfo.isPhysicalDevice == false ||
            androidInfo.brand.startsWith('generic') ||
            androidInfo.device.startsWith('generic') ||
            androidInfo.fingerprint.startsWith('generic') ||
            androidInfo.fingerprint.startsWith('unknown') ||
            androidInfo.hardware.contains("goldfish") ||
            androidInfo.hardware.contains("ranchu") ||
            androidInfo.model.contains('google_sdk') ||
            androidInfo.model.contains('Emulator') ||
            androidInfo.model.contains('sdk') ||
            androidInfo.model.contains('Android SDK built for x86') ||
            androidInfo.manufacturer.contains('Genymotion') ||
            androidInfo.product.contains('sdk_google') ||
            androidInfo.product.contains('google_sdk') ||
            androidInfo.product.contains('sdk') ||
            androidInfo.product.contains('sdk_x86') ||
            androidInfo.product.contains('sdk_gphone64_arm64') ||
            androidInfo.product.contains('vbox86p') ||
            androidInfo.product.contains('emulator') ||
            androidInfo.product.contains('simulator') ||
            androidInfo.brand.contains("BlueStacks") ||
            androidInfo.manufacturer.contains('BlueStack') ||
            androidInfo.manufacturer.contains('Bluestacks') ||
            androidInfo.manufacturer.toLowerCase() == 'bst' ||
            androidInfo.model.contains('BlueStacks') ||
            androidInfo.product.contains('BlueStacks') ||
            await File("/system/priv-app/BlueStacksHome").exists() ||
            await File("/system/priv-app/BlueStacks").exists() ||
            await File("/system/app/BlueStacks").exists() ||
            androidInfo.hardware.contains("vbox86") ||
            await _checkBlueStacksProps();
      } else if (defaultTargetPlatform == TargetPlatform.iOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        return !iosInfo.isPhysicalDevice;
      }
    } on PlatformException {
      // If we can't detect, assume it might be an emulator
      return true;
    }

    return false;
  }

  static Future<bool> _checkBlueStacksProps() async {
    try {
      // Check for BlueStacks-specific system properties
      final process = await Process.run('getprop', []);
      final output = process.stdout as String;

      return output.contains('bluestacks') ||
          output.contains('bst') ||
          output.contains('Bst') ||
          output.contains('bs_') ||
          output.contains('ro.bluestacks');
    } catch (e) {
      return false;
    }
  }
}
