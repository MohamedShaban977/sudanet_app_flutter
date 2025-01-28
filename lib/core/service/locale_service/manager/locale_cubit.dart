import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/useCases/use_case.dart';
import '../../../app_manage/contents_manager.dart';
import '../../../cache/cache_data_shpref.dart';
import '../domain/use_cases/locale_use_case.dart';

part 'locale_state.dart';

class LocaleCubit extends Cubit<LocaleState> {
  LocaleCubit({required this.savedLangUseCase, required this.changeLangUseCase})
      : super(const ChangeLocalState(Locale(Constants.arabicCode)));

  final GetSavedLangUseCase savedLangUseCase;
  final ChangeLangUseCase changeLangUseCase;

  String currentLangCode = Constants.arabicCode;

  LocaleCubit get(context) => BlocProvider.of<LocaleCubit>(context);

  Future<void> getSavedLang() async {
    final res = await savedLangUseCase.call(NoParams());
    res.fold((failure) => debugPrint('cache failure'), (value) {
      currentLangCode = value;
      _currentLangWithApi(value);
      emit(ChangeLocalState(Locale(currentLangCode)));
    });
  }

  Future<void> _changeLang(String langCode) async {
    final res = await changeLangUseCase.call(langCode);
    res.fold((failure) => debugPrint('cache failure'), (value) {
      currentLangCode = langCode;
      emit(ChangeLocalState(Locale(currentLangCode)));
    });
  }

  Future<void> _currentLangWithApi(String currentCode) async {
    if (currentCode == Constants.englishCode) {
      sl<CacheHelper>().saveData(
          key: Constants.currentLangAPi, value: Constants.englishCodeAPi);
    } else if (currentCode == Constants.arabicCode) {
      sl<CacheHelper>().saveData(
          key: Constants.currentLangAPi, value: Constants.arabicCodeAPi);
    }
  }

  void toEnglish() => _changeLang(Constants.englishCode);

  void toArabic() => _changeLang(Constants.arabicCode);

  void changeLang(BuildContext context) {
    if (context.isEnLocale) {
      toArabic();
    } else {
      toEnglish();
    }
  }
}
