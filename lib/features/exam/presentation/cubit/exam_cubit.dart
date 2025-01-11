import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/api/service_response.dart';
import '../../../../core/error/failures.dart';
import '../../data/models/exam_response.dart';
import '../../data/models/save_answer_request.dart';
import '../../domain/entities/end_exam_entity.dart';
import '../../domain/entities/exam_ready_entity.dart';
import '../../domain/repositories/exam_repository.dart';
import '../screens/exam_screen.dart';

part 'exam_state.dart';

class ExamCubit extends Cubit<ExamState> {
  ExamCubit({required this.repository}) : super(ExamInitial());

  final ExamRepository repository;

  ExamCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getExamReady({required String examId, required ExamType type}) async {
    emit(GetExamReadyLoadingState());
    Either<Failure, BaseResponseEntity<ExamReadyEntity>> response =
        await repository.getExamReady(examId: examId, type: type);
    response.fold(
      (failure) => emit(GetExamReadyErrorState(HandleFailure.mapFailureToMsg(failure))),
      (response) => emit(GetExamReadySuccessState(response)),
    );
  }

  Future<void> getExamQuestionOrPercentage({required String examId, required ExamType type}) async {
    emit(GetExamQuestionOrPercentageLoadingState());
    Either<Failure, BaseResponseEntity<ExamModel>> response =
        await repository.getExamQuestionOrPercentage(examId: examId, type: type);

    response.fold(
      (failure) => emit(GetExamQuestionOrPercentageErrorState(HandleFailure.mapFailureToMsg(failure))),
      (response) => emit(GetExamQuestionOrPercentageSuccessState(response.data)),
    );
  }

  Future<void> saveAnswer({required SaveAnswerRequest request, required ExamType type}) async {
    emit(SaveAnswerLoadingState());
    Either<Failure, BaseResponseEntity<bool>> response = await repository.saveAnswer(request: request, type: type);
    response.fold(
        (failure) => emit(
              SaveAnswerErrorState(
                HandleFailure.mapFailureToMsg(failure),
              ),
            ),
        (response) => emit(SaveAnswerSuccessState(response)));
  }

  Future<void> endExam({required String studentExamId, required ExamType type}) async {
    emit(EndExamLoadingState());
    Either<Failure, BaseResponseEntity<EndExamEntity>> response =
        await repository.endExam(studentExamId: studentExamId, type: type);
    response.fold(
        (failure) => emit(
              EndExamErrorState(
                HandleFailure.mapFailureToMsg(failure),
              ),
            ),
        (response) => emit(EndExamSuccessState(response)));
  }
}
