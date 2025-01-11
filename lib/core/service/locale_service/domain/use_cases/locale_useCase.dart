import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/useCases/use_case.dart';
import '../repositories/locale_repository.dart';

class ChangeLangUseCase implements UseCase<bool, String> {
  final LocaleRepository repository;

  ChangeLangUseCase({required this.repository});

  @override
  Future<Either<Failure, bool>> call(String langCode) async =>
      await repository.changeLang(langCode: langCode);
}

class GetSavedLangUseCase implements UseCase<String, NoParams> {
  final LocaleRepository repository;

  GetSavedLangUseCase({required this.repository});

  @override
  Future<Either<Failure, String>> call(NoParams params) async =>
      await repository.getSavedLang();
}
