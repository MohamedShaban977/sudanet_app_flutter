import 'package:hive/hive.dart';

class HiveHelper {
  static late Box<dynamic> cartProductDB;

  static const _cartProductBoxDB = 'cartProductBox';

  static Future<void> init() async {
    // var appDirectory = await getApplicationDocumentsDirectory();
    //
    // // Hive..init(appDirectory.path)
    // //   ..registerAdapter(ProductCartTableAdapter());
    //
    // cartProductDB = await Hive.openBox(_cartProductBoxDB);
  }
}
