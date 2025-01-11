
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../domain/entities/user_my_courses_entity.dart';

class UserMyCoursesResponse extends UserMyCoursesEntity {
  UserMyCoursesResponse({
    final int? courseId,
    final String? courseName,
    final String? courseImage,
    final String? teacherName,
    final String? buyingDate,
  }) : super(
          courseId: courseId.orZero(),
          courseName: courseName.orEmpty(),
          courseImage: courseImage.orEmpty(),
          teacherName: teacherName.orEmpty(),
          buyingDate: buyingDate.orEmpty(),
        );

  factory UserMyCoursesResponse.fromJson(Map<String, dynamic> json) =>
      UserMyCoursesResponse(
        courseId: json["courseId"],
        courseName: json["courseName"],
        courseImage: json["courseImage"],
        teacherName: json["teacherName"],
        buyingDate: json["buyingDate"],
      );
}
