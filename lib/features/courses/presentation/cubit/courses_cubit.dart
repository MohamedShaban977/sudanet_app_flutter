import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../../domain/entities/courses_entity.dart';
import '../../domain/use_cases/courses_use_case.dart';

part 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit({
    required this.coursesUseCases,
  }) : super(CoursesInitial());

  final CoursesUseCases coursesUseCases;

  CoursesCubit get(context) => BlocProvider.of(context);

  final List<CoursesEntity> coursesAllItems = [];

  Future<void> getAllCourses() async {
    emit(GetCoursesLoadingState());
    Either<Failure, CollectionResponseEntity<CoursesEntity>> response =
        await coursesUseCases.call(NoParams());
    response.fold(
        (failure) => emit(GetCoursesErrorState(
            error: HandleFailure.mapFailureToMsg(failure))), (response) {
      coursesAllItems.clear();
      coursesAllItems.addAll(response.data!);
      emit(GetCoursesSuccessState(response: response));
    });
  }
}

// extension ReplaceAllList on
