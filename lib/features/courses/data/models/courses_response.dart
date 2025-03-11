import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../domain/entities/courses_entity.dart';

class CoursesResponse extends CoursesEntity {
  CoursesResponse({
    final int? id,
    final String? name,
    final String? imagePath,
    final String? teacherName,
    final String? price,
    final String? currencyName,
    final String? categoryName,
    final int? categoryId,
    final bool? lecturesEnabled,
    final bool? homeWorkEnabled,
    final bool? filesEnabled,
    final bool? examsEnabled,
  }) : super(
          id: id.orZero(),
          name: name.orEmpty(),
          imagePath: imagePath.orEmpty(),
          teacherName: teacherName.orEmpty(),
          price: price.orEmpty(),
          currencyName: currencyName.orEmpty(),
          categoryName: categoryName.orEmpty(),
          categoryId: categoryId.orZero(),
          lecturesEnabled: lecturesEnabled.orEmptyB(),
          homeWorkEnabled: homeWorkEnabled.orEmptyB(),
          filesEnabled: filesEnabled.orEmptyB(),
          examsEnabled: examsEnabled.orEmptyB(),
        );

  factory CoursesResponse.fromJson(Map<String, dynamic> json) =>
      CoursesResponse(
        id: json["id"],
        name: json["name"],
        imagePath: json["imgPath"],
        teacherName: json["teacherName"],
        price: json["price"],
        currencyName: json["currencyName"],
        categoryName: json["categoryName"],
        categoryId: json["categoryId"],
        lecturesEnabled: json["lecturesEnabled"],
        homeWorkEnabled: json["homeWorkEnabled"],
        filesEnabled: json["filesEnabled"],
        examsEnabled: json["examsEnabled"],
      );
}
