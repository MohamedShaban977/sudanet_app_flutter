part of 'homework_student_cubit.dart';

@immutable
class HomeworkStudentState {}

class HomeworkStudentInitial extends HomeworkStudentState {}

class HomeworkStudentLoadingState extends HomeworkStudentState {}

class HomeworkStudentSuccessState extends HomeworkStudentState {
  final List<HomeworkItemModel> homeworks;

  HomeworkStudentSuccessState({required this.homeworks});
}

class HomeworkStudentErrorState extends HomeworkStudentState {
  final String error;

  HomeworkStudentErrorState({required this.error});
}

class WrittenHomeworkStudentLoadingState extends HomeworkStudentState {}

class WrittenHomeworkStudentSuccessState extends HomeworkStudentState {
  final List<WrittenHomeworkItemModel> homeworks;

  WrittenHomeworkStudentSuccessState({required this.homeworks});
}

class WrittenHomeworkStudentErrorState extends HomeworkStudentState {
  final String error;

  WrittenHomeworkStudentErrorState({required this.error});
}
