
import '../../presentation/screens/exam_screen.dart';

class SaveAnswerRequest {
  final String? answer;
  final int? examQuestionId;
  final ExamType type;

  SaveAnswerRequest({
    required this.type,
    required this.answer,
    required this.examQuestionId,
  });

  Map<String, dynamic> toJson() => {
        "Answer": answer,
        type == ExamType.homework ? 'HomeWorkQuestionId' : 'ExamQuestionId': examQuestionId,
      };
}
