part of 'courses_by_category_cubit.dart';

abstract class CoursesByCategoryState extends Equatable {
  const CoursesByCategoryState();

  @override
  List<Object> get props => [];
}

class CoursesByCategoryInitial extends CoursesByCategoryState {}

class CoursesByCategoryLoadingState extends CoursesByCategoryState {}

class CoursesByCategorySuccessState extends CoursesByCategoryState {
  final CollectionResponseEntity<CoursesEntity> response;

  const CoursesByCategorySuccessState({required this.response});

  @override
  List<Object> get props => [response];
}

class CoursesByCategoryErrorState extends CoursesByCategoryState {
  final String error;

  const CoursesByCategoryErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
