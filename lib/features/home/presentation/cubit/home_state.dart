part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

///
class GetCategoriesLoadingState extends HomeState {}

class GetCategoriesSuccessState extends HomeState {
  final CollectionResponseEntity<CategoriesEntity> response;

  GetCategoriesSuccessState({required this.response});
}

class GetCategoriesErrorState extends HomeState {
  final String error;

  GetCategoriesErrorState({required this.error});
}

///
class GetCoursesLoadingState extends HomeState {}

class GetCoursesSuccessState extends HomeState {
  final CollectionResponseEntity<CoursesEntity> response;

  GetCoursesSuccessState({required this.response});
}

class GetCoursesErrorState extends HomeState {
  final String error;

  GetCoursesErrorState({required this.error});
}

///
class GetSliderLoadingState extends HomeState {}

class GetSliderSuccessState extends HomeState {
  final CollectionResponseEntity<SliderEntity> response;

  GetSliderSuccessState({required this.response});
}

class GetSliderErrorState extends HomeState {
  final String error;

  GetSliderErrorState({required this.error});
}

///
class ChangeSliderState extends HomeState {}
