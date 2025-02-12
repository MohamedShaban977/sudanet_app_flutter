import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/exams_by_subject_item_model.dart';
import '../../data/repositories/exams_by_subject_repository.dart';

part 'exams_by_subject_state.dart';

class ExamsBySubjectCubit extends Cubit<ExamsBySubjectState> {
  ExamsBySubjectCubit({required this.repository})
      : super(ExamsBySubjectInitial());

  final ExamsBySubjectRepository repository;

  ExamsBySubjectCubit get(context) => BlocProvider.of(context);

  List<ExamsBySubjectItemModel> examsBySubject = [];

  Future<void> getExamsBySubject(String subjectId) async {
    emit(ExamsBySubjectLoadingState());
    Either<Failure, CollectionResponse<ExamsBySubjectItemModel>> response =
        await repository.getExamsBySubject(subjectId);
    response.fold(
      (failure) => emit(ExamsBySubjectErrorState(
          error: HandleFailure.mapFailureToMsg(failure))),
      (response) {
        emit(ExamsBySubjectSuccessState(response: response));
        examsBySubject = response.data ?? [];
      },
    );
  }

  List<ExamsBySubjectItemModel> examsNotification = [];

  Future<void> getExamsNotification() async {
    emit(ExamsNotificationLoadingState());
    Either<Failure, CollectionResponse<ExamsBySubjectItemModel>> response =
        await repository.getExamsNotification();
    response.fold(
      (failure) => emit(ExamsNotificationErrorState(
          error: HandleFailure.mapFailureToMsg(failure))),
      (response) {
        emit(ExamsNotificationSuccessState(response: response));
        examsNotification = response.data ?? [];
      },
    );
  }
}
