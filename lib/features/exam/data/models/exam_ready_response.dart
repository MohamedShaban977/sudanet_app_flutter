
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../domain/entities/exam_ready_entity.dart';

class ExamReadyResponse extends ExamReadyEntity {
  ExamReadyResponse({
    final int? id,
    final String? examTime,
    final String? remainingExamTime,
    final String? examName,
    final int? questionsCount,
  }) : super(
          id: id.orZero(),
          examTime: examTime.orEmpty(),
          remainingExamTime: remainingExamTime.orEmpty(),
          examName: examName.orEmpty(),
          questionsCount: questionsCount.orZero(),
        );

  factory ExamReadyResponse.fromJson(Map<String, dynamic> json) =>
      ExamReadyResponse(
        id: json["id"],
        examTime: json["examTime"],
        remainingExamTime: json["remainingExamTime"],
        examName: json["examName"],
        questionsCount: json["questionsCount"],
      );
}
