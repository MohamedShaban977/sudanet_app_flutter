
// {
// "examName": "أمتحان الحصة الثانية",
// "isFail": true,
// "percentage": "0%"
// }
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../domain/entities/end_exam_entity.dart';

class EndExamResponse extends EndExamEntity {
  EndExamResponse({
    final String? examName,
    final bool? isFail,
    final String? percentage,
  }) : super(
          examName: examName.orEmpty(),
          percentage: percentage.orEmpty(),
          isFail: isFail.orEmptyB(),
        );

  factory EndExamResponse.fromJson(Map<String, dynamic> json) =>
      EndExamResponse(
        examName: json["examName"],
        isFail: json["isFail"],
        percentage: json["percentage"],
      );
}
