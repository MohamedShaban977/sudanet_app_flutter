import '../../../../../app_manage/contents_manager.dart';
import '../../../../../cache/cache_data_shpref.dart';

abstract class LocalDataSource {
  Future<bool> changeLang({required String langCode});

  Future<String> getSavedLang();
}

class LocalDataSourceImpl implements LocalDataSource {
  final CacheHelper cacheHelper;

  LocalDataSourceImpl({required this.cacheHelper});

  @override
  Future<bool> changeLang({required String langCode}) async =>
      await cacheHelper.saveData(key: Constants.locale, value: langCode);

  @override
  Future<String> getSavedLang() async =>
      await cacheHelper.containsKey(key: Constants.locale)
          ? cacheHelper.getData(key: Constants.locale)
          : Constants.arabicCode;
}
