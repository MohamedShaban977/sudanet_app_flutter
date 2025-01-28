import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../../../categories/domain/entities/categories_entity.dart';
import '../../../courses/domain/entities/courses_entity.dart';
import '../../domain/entities/slider_entity.dart';
import '../../domain/use_cases/home_use_case.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit({
    required this.categoriesUseCases,
    required this.coursesUseCases,
    required this.sliderUseCases,
  }) : super(HomeInitial());

  final HomeCategoriesUseCases categoriesUseCases;
  final HomeCourseUseCases coursesUseCases;
  final SliderUseCases sliderUseCases;

  HomeCubit get(context) => BlocProvider.of(context);

  final List<CategoriesEntity> categoriesItems = [];

  Future<void> getCategories() async {
    emit(GetCategoriesLoadingState());
    Either<Failure, CollectionResponseEntity<CategoriesEntity>> response =
        await categoriesUseCases.call(NoParams());
    response.fold(
        (failure) => emit(GetCategoriesErrorState(
            error: HandleFailure.mapFailureToMsg(failure))), (response) {
      // categoriesItems =  response.data!;
      categoriesItems.clear();
      categoriesItems.addAll(response.data!);

      emit(GetCategoriesSuccessState(response: response));
    });
  }

  final List<CoursesEntity> coursesItems = [];

  Future<void> getCourses() async {
    emit(GetCoursesLoadingState());
    Either<Failure, CollectionResponseEntity<CoursesEntity>> response =
        await coursesUseCases.call(NoParams());
    response.fold(
        (failure) => emit(GetCoursesErrorState(
            error: HandleFailure.mapFailureToMsg(failure))), (response) {
      coursesItems.clear();

      coursesItems.addAll(response.data!);
      emit(GetCoursesSuccessState(response: response));
    });
  }

  final List<SliderEntity> sliderItems = [];

  Future<void> getSlider() async {
    emit(GetSliderLoadingState());
    Either<Failure, CollectionResponseEntity<SliderEntity>> response =
        await sliderUseCases.call(NoParams());
    response.fold(
        (failure) => emit(
            GetSliderErrorState(error: HandleFailure.mapFailureToMsg(failure))),
        (response) {
      sliderItems.clear();
      sliderItems.addAll(response.data!);
      emit(GetSliderSuccessState(response: response));
    });
  }
}
