part of 'exam_cubit.dart';

abstract class ExamState extends Equatable {
  const ExamState();

  @override
  List<Object> get props => [];
}

class ExamInitial extends ExamState {}

///
class GetExamReadyLoadingState extends ExamState {}

class GetExamReadySuccessState extends ExamState {
  final BaseResponseEntity<ExamReadyEntity> response;

  const GetExamReadySuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class GetExamReadyErrorState extends ExamState {
  final String error;

  const GetExamReadyErrorState(this.error);

  @override
  List<Object> get props => [error];
}

///
class GetExamQuestionOrPercentageLoadingState extends ExamState {}

class GetExamQuestionOrPercentageSuccessState extends ExamState {
  final ExamModel? data;

  const GetExamQuestionOrPercentageSuccessState(this.data);
}

class GetExamQuestionOrPercentageErrorState extends ExamState {
  final String error;

  const GetExamQuestionOrPercentageErrorState(this.error);

  @override
  List<Object> get props => [error];
}

///
class SaveAnswerLoadingState extends ExamState {}

class SaveAnswerSuccessState extends ExamState {
  final BaseResponseEntity<bool> response;

  const SaveAnswerSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class SaveAnswerErrorState extends ExamState {
  final String error;

  const SaveAnswerErrorState(this.error);

  @override
  List<Object> get props => [error];
}

///
class EndExamLoadingState extends ExamState {}

class EndExamSuccessState extends ExamState {
  final BaseResponseEntity<EndExamEntity> response;

  const EndExamSuccessState(this.response);

  @override
  List<Object> get props => [response];
}

class EndExamErrorState extends ExamState {
  final String error;

  const EndExamErrorState(this.error);

  @override
  List<Object> get props => [error];
}
