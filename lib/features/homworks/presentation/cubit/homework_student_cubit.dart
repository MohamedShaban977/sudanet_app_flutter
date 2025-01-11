import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/homework_item_model.dart';
import '../../data/repositories/homework_student_repository.dart';

part 'homework_student_state.dart';

class HomeworkStudentCubit extends Cubit<HomeworkStudentState> {
  HomeworkStudentCubit(this.repository) : super(HomeworkStudentInitial());

  final HomeworksStudentRepository repository;

  HomeworkStudentCubit get(context) => BlocProvider.of(context);

  List<HomeworkItemModel> homeworks = [];

  Future<void> getHomeworkBySubject(String subjectId) async {
    emit(HomeworkStudentLoadingState());
    Either<Failure, CollectionResponse<HomeworkItemModel>> response = await repository.getHomeworkBySubject('223');
    response.fold(
      (failure) => emit(HomeworkStudentErrorState(error: HandleFailure.mapFailureToMsg(failure))),
      (response) {
        emit(HomeworkStudentSuccessState(homeworks: response.data ?? []));
        homeworks = response.data ?? [];
      },
    );
  }
}
