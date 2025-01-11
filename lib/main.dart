import 'package:bloc/bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

import 'app/bloc_observer.dart';
import 'app/injection_container.dart';
import 'app/my_app.dart';
import 'core/app_manage/theme_manager.dart';
import 'core/cache/hive_helper.dart';

Future<void> main() async {
  await _initMain();
  runApp(
    DevicePreview(
      enabled: false,
      // enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
  // runApp(MyApp());
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
