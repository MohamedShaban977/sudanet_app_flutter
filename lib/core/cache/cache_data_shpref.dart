import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {
  final SharedPreferences sharedPreferences;

  CacheHelper({required this.sharedPreferences});

  Future<bool> saveData({
    required String key,
    required dynamic value,
  }) async {
    if (value is String) return await sharedPreferences.setString(key, value);
    if (value is int) return await sharedPreferences.setInt(key, value);
    if (value is bool) return await sharedPreferences.setBool(key, value);
    return await sharedPreferences.setDouble(key, value);
  }

  dynamic getData({required String key}) => sharedPreferences.get(key);

  Future<bool> containsKey({required String key}) async =>
      sharedPreferences.containsKey(key);

  Future<bool> removeData({required String key}) async =>
      await sharedPreferences.remove(key);
}
