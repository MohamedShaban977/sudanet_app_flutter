import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../courses/domain/entities/courses_entity.dart';
import '../../domain/use_cases/courses_by_category_use_case.dart';

part 'courses_by_category_state.dart';

class CoursesByCategoryCubit extends Cubit<CoursesByCategoryState> {
  CoursesByCategoryCubit({required this.coursesByCategoryUseCases})
      : super(CoursesByCategoryInitial());

  final CoursesByCategoryUseCases coursesByCategoryUseCases;

  CoursesByCategoryCubit get(context) => BlocProvider.of(context);

  final List<CoursesEntity> coursesByCategoryIdItems = [];

  Future<void> getCoursesByCategoryId(String categoryId) async {
    emit(CoursesByCategoryLoadingState());
    Either<Failure, CollectionResponseEntity<CoursesEntity>> response =
        await coursesByCategoryUseCases.call(categoryId);
    response.fold(
        (failure) => emit(CoursesByCategoryErrorState(
            error: HandleFailure.mapFailureToMsg(failure))), (response) {
      coursesByCategoryIdItems.clear();
      coursesByCategoryIdItems.addAll(response.data!);
      emit(CoursesByCategorySuccessState(response: response));
    });
  }
}
