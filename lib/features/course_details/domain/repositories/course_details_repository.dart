import 'package:dartz/dartz.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/buy_course_request.dart';
import '../entities/course_details_entity.dart';
import '../entities/course_lecture_details_entity.dart';

abstract class CourseDetailsRepository {
  Future<Either<Failure, BaseResponseEntity<CourseDetailsEntity>>>
      getCourseDetails(String id);

  Future<Either<Failure, BaseResponseEntity<CourseLectureDetailsEntity>>>
      getCourseLecture(String lectureId);

  Future<Either<Failure, BaseResponseEntity>> buyCourse(
      BuyCourseRequest request);
}
