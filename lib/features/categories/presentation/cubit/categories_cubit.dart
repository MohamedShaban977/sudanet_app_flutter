import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/useCases/use_case.dart';
import '../../domain/entities/categories_entity.dart';
import '../../domain/useCases/Categories_use_case.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit({required this.getAllCategoriesUseCases})
      : super(CategoriesInitial());

  final GetAllCategoriesUseCases getAllCategoriesUseCases;

  CategoriesCubit get(context) => BlocProvider.of(context);


  final List<CategoriesEntity> categoriesItems = [];

  Future<void> getCategories() async {
    emit(GetAllCategoriesLoadingState());
    Either<Failure, CollectionResponseEntity<CategoriesEntity>> response =
    await getAllCategoriesUseCases.call(NoParams());
    response.fold(
            (failure) =>
            emit(GetAllCategoriesErrorState(
                error: HandleFailure.mapFailureToMsg(failure))),

            (response) {
          categoriesItems.clear();
          categoriesItems.addAll(response.data!);

          emit(GetAllCategoriesSuccessState());
        });
  }


}
