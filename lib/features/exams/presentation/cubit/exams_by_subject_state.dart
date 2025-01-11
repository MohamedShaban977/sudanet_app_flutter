part of 'exams_by_subject_cubit.dart';

@immutable
class ExamsBySubjectState {}

class ExamsBySubjectInitial extends ExamsBySubjectState {}

class ExamsBySubjectLoadingState extends ExamsBySubjectState {}

class ExamsBySubjectSuccessState extends ExamsBySubjectState {
  final CollectionResponse<ExamsBySubjectItemModel> response;

  ExamsBySubjectSuccessState({required this.response});
}

class ExamsBySubjectErrorState extends ExamsBySubjectState {
  final String error;

  ExamsBySubjectErrorState({required this.error});
}

class ExamsNotificationLoadingState extends ExamsBySubjectState {}

class ExamsNotificationSuccessState extends ExamsBySubjectState {
  final CollectionResponse<ExamsBySubjectItemModel> response;

  ExamsNotificationSuccessState({required this.response});
}

class ExamsNotificationErrorState extends ExamsBySubjectState {
  final String error;

  ExamsNotificationErrorState({required this.error});
}
