import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'app/bloc_observer.dart';
import 'app/injection_container.dart';
import 'app/my_app.dart';
import 'core/app_manage/theme_manager.dart';
import 'core/cache/hive_helper.dart';

Future<void> main() async {
  await _initMain();

// Exit the app

  runApp(MyApp());
}

Future<void> _initMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  statusBarColor();
  await ServiceLocator.initApp();
  HiveHelper.init();
  Bloc.observer = MyBlocObserver();
}
