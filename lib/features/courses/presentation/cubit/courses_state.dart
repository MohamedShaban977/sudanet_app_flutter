part of 'courses_cubit.dart';

abstract class CoursesState extends Equatable {
  const CoursesState();

  @override
  List<Object> get props => [];
}

class CoursesInitial extends CoursesState {}

class GetCoursesLoadingState extends CoursesState {}

class GetCoursesSuccessState extends CoursesState {
  final CollectionResponseEntity<CoursesEntity> response;

  const GetCoursesSuccessState({required this.response});

  @override
  List<Object> get props => [response];
}

class GetCoursesErrorState extends CoursesState {
  final String error;

  const GetCoursesErrorState({required this.error});

  @override
  List<Object> get props => [error];
}

// export class Courses extends Equatable {}
