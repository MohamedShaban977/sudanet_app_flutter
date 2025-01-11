/*

{
        "id": 3,
        "examTime": "10 دقائق ",
        "remainingExamTime": "0:15 دقائق ",
        "examName": "أمتحان الحصة الثانية",
        "questionsCount": 10
    }
*/
import 'package:equatable/equatable.dart';

class ExamReadyEntity extends Equatable {
  final int id;
  final String examTime;
  final String remainingExamTime;
  final String examName;
  final int questionsCount;

  const ExamReadyEntity({
    required this.id,
    required this.examTime,
    required this.remainingExamTime,
    required this.examName,
    required this.questionsCount,
  });

  @override
  List<Object?> get props => [
        id,
        examTime,
        remainingExamTime,
        examName,
        questionsCount,
      ];
}
