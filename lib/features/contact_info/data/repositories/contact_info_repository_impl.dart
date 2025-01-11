import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/contact_info_entity.dart';
import '../../domain/repositories/contact_info_repository.dart';
import '../data_sources/contact_info_data_source.dart';

class ContactInfoRepositoryImpl implements ContactInfoRepository {
  final ContactInfoDataSource dataSource;

  ContactInfoRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, BaseResponseEntity<ContactInfoEntity>>>
      getContactInfo() async {
    try {
      final res = await dataSource.getHelpContactInfo();
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
