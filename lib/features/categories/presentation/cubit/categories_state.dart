part of 'categories_cubit.dart';

abstract class CategoriesState extends Equatable {
  const CategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesInitial extends CategoriesState {}

class GetAllCategoriesLoadingState extends CategoriesState {}

class GetAllCategoriesSuccessState extends CategoriesState {}

class GetAllCategoriesErrorState extends CategoriesState {
  final String error;

  const GetAllCategoriesErrorState({required this.error});

  @override
  List<Object> get props => [error];
}
