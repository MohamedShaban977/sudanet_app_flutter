import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../../app/injection_container.dart';
import '../../../../../core/cache/cache_data_shpref.dart';
import '../../data/models/login_response.dart';
import '../../domain/entities/login_entity.dart';

class UserSecureStorage {
  static const _storage = FlutterSecureStorage();

  // static const _userKeyToken = 'USER_KEY_TOKEN';
  static const _userMacId = 'USER_SECRET_MAC_ID';

  static const _userData = 'USER_DATA';

/*
  static Future setUser({required UserEntity data}) async {
    await _storage.write(key: _userKeyToken, value: jsonEncode(data.toJson()));
  }
  static Future<UserData?> getUser() async {
    try {
      var res = await _storage.read(key: _userKeyToken);
      print('SecureStorage: ==>$res');
      // print('SecureStorage: ==>${jsonDecode(res!)['name']}');
      var user = UserData.fromJson(jsonDecode(res!));

      setMacId(macID: user.guid!);
      return user;
    } catch (ex) {
      print(ex);
      return null;
    }
  }
  static removeUser() async => await _storage.delete(key: _userKeyToken);
*/

  static Future setUser({required UserEntity data}) async {
    await sl<CacheHelper>().saveData(
      key: _userData,
      value: jsonEncode(data.toJson()),
    );
    await setMacId();
  }

  static UserData? getUser() {
    var res = sl<CacheHelper>().getData(key: _userData);
    if (res != null) {
      var user = UserData.fromJson(jsonDecode(res));
      return user;
    }
    return null;
  }

  static removeUser() async =>
      await sl<CacheHelper>().removeData(key: _userData);

  static String? getToken() {
    var res = sl<CacheHelper>().getData(key: _userData);
    return res != null ? UserData.fromJson(jsonDecode(res)).token : null;
  }

  static Future setMacId() async {
    var res = sl<CacheHelper>().getData(key: _userData);
    if (res != null) {
      var user = UserData.fromJson(jsonDecode(res));
      await _storage.write(key: _userMacId, value: user.guid);
    }
  }

  static Future<String?> getMacId() {
    return _storage.read(key: _userMacId);
  }

  static bool isAuth = getToken() != null;
}
