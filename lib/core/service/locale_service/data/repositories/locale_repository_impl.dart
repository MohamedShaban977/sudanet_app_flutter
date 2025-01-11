import 'package:dartz/dartz.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../../../core/error/failures.dart';
import '../../domain/repositories/locale_repository.dart';
import '../local/data_sources/locale_data_sources.dart';

class LocaleRepositoryImpl implements LocaleRepository {
  final LocalDataSource dataSource;

  LocaleRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, bool>> changeLang({required String langCode}) async {
    try {
      final lang = await dataSource.changeLang(langCode: langCode);
      return Right(lang);
    } on CacheException {
      return left(const CacheFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getSavedLang() async {
    try {
      return Right(await dataSource.getSavedLang());
    } on CacheException {
      return left(const CacheFailure());
    }
  }
}
