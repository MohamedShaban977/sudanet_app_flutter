import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/course_details_entity.dart';
import '../../domain/entities/course_lecture_details_entity.dart';
import '../../domain/repositories/course_details_repository.dart';
import '../data_sources/course_details_data_source.dart';
import '../models/buy_course_request.dart';

class CourseDetailsRepositoryImpl implements CourseDetailsRepository {
  final CourseDetailsDataSource dataSource;

  CourseDetailsRepositoryImpl({required this.dataSource});

  @override
  Future<Either<Failure, BaseResponseEntity<CourseDetailsEntity>>>
      getCourseDetails(String id) async {
    try {
      final res = await dataSource.getCourseDetails(id);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity>> buyCourse(
      BuyCourseRequest request) async {
    try {
      final res = await dataSource.buyCourse(request);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }

  @override
  Future<Either<Failure, BaseResponseEntity<CourseLectureDetailsEntity>>>
      getCourseLecture(String lectureId) async {
    try {
      final res = await dataSource.getCourseLecture(lectureId);
      return res.success ? Right(res) : left(ServerFailure(res.message));
    } on ServerException catch (error) {
      return left(ServerFailure(error.message));
    }
  }
}
