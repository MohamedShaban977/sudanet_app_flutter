import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'app/bloc_observer.dart';
import 'app/injection_container.dart';
import 'app/my_app.dart';
import 'core/app_manage/theme_manager.dart';
import 'core/cache/hive_helper.dart';

Future<void> main() async {
  await _initMain();
  final emulator = await isRunningOnEmulator(
    isReleaseMode: kReleaseMode
  );

  if (emulator) {
    // Exit the app or display a message
    print("This app cannot run on an emulator.");
    exit(0); // Exit the app
  } else {
    runApp(MyApp());
  }
}

Future<void> _initMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  // final directory = await getLibraryDirectory();
  // print('getLibraryDirectory =>${directory.path}');

  await FlutterDownloader.initialize(
    debug:
    true, // optional: set to false to disable printing logs to console (default: true)

    // ignoreSsl: true // option: set to false to disable working with http links (default: false)
  );
  statusBarColor();
  await ServiceLocator.initApp();
  HiveHelper.init();
  Bloc.observer = MyBlocObserver();
}



Future<bool> isRunningOnEmulator({required bool isReleaseMode}) async {
if (!isReleaseMode) return false;
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final androidInfo = await deviceInfo.androidInfo;
    return androidInfo.isPhysicalDevice == false;
  } else if (Platform.isIOS) {
    final iosInfo = await deviceInfo.iosInfo;
    return iosInfo.isPhysicalDevice == false;
  }

  return false;
}