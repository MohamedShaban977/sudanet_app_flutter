import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/buy_course_request.dart';
import '../../domain/entities/course_details_entity.dart';
import '../../domain/entities/course_lecture_details_entity.dart';
import '../../domain/use_cases/course_details_use_case.dart';

part 'course_details_state.dart';

class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  CourseDetailsCubit({
    required this.courseDetailsUseCases,
    required this.buyCourseUseCases,
    required this.courseLectureDetailsUseCases,
  }) : super(CourseDetailsInitial());
  final GetCourseDetailsUseCases courseDetailsUseCases;
  final BuyCourseUseCases buyCourseUseCases;
  final GetCourseLectureDetailsUseCases courseLectureDetailsUseCases;

  CourseDetailsCubit get(context) => BlocProvider.of(context);

  Future<void> getCourseDetails(String id) async {
    emit(GetCourseDetailsLoadingState());
    Either<Failure, BaseResponseEntity<CourseDetailsEntity>> response =
        await courseDetailsUseCases.call(id);
    response.fold(
      (failure) => emit(GetCourseDetailsErrorState(
          error: HandleFailure.mapFailureToMsg(failure))),
      (response) => emit(GetCourseDetailsSuccessState(response: response)),
    );
  }

  Future<void> getLectureCourseDetails(String lectureId) async {
    emit(GetCourseLectureDetailsLoadingState());
    Either<Failure, BaseResponseEntity<CourseLectureDetailsEntity>> response =
        await courseLectureDetailsUseCases.call(lectureId);
    response.fold(
      (failure) => emit(GetCourseLectureDetailsErrorState(
          error: HandleFailure.mapFailureToMsg(failure))),
      (response) =>
          emit(GetCourseLectureDetailsSuccessState(response: response)),
    );
  }

  String? videoId;

  Future<void> buyCourse(BuyCourseRequest request) async {
    emit(BuyCourseLoadingState());
    Either<Failure, BaseResponseEntity> response =
        await buyCourseUseCases.call(request);
    response.fold(
      (failure) => emit(
        BuyCourseErrorState(
          error: HandleFailure.mapFailureToMsg(failure),
        ),
      ),
      (response) => emit(
        BuyCourseSuccessState(
          response: response,
        ),
      ),
    );
  }
}
