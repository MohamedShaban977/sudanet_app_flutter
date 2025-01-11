
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../domain/entities/course_details_entity.dart';

class CourseDetailsResponse extends CourseDetailsEntity {
  CourseDetailsResponse({
    final int? id,
    final String? name,
    final String? imgPath,
    final String? teacherName,
    final String? price,
    final String? currencyName,
    final String? categoryName,
    final int? categoryId,
    final String? youtubeId,
    final String? desc,
    final bool? purchased,
    final List<CourseLectureResponse>? courseLectures,
  }) : super(
          id: id.orZero(),
          name: name.orEmpty(),
          imagePath: imgPath.orEmpty(),
          teacherName: teacherName.orEmpty(),
          price: price.orEmpty(),
          currencyName: currencyName.orEmpty(),
          categoryName: categoryName.orEmpty(),
          categoryId: categoryId.orZero(),
          youtubeID: youtubeId.orEmpty(),
          description: desc.orEmpty(),
          purchased: purchased.orEmptyB(),
          courseLectures: courseLectures.orEmptyList(),
        );

  factory CourseDetailsResponse.fromJson(Map<String, dynamic> json) =>
      CourseDetailsResponse(
        id: json["id"],
        name: json["name"],
        imgPath: json["imgPath"],
        teacherName: json["teacherName"],
        price: json["price"],
        currencyName: json["currencyName"],
        categoryName: json["categoryName"],
        categoryId: json["categoryId"],
        youtubeId: json["youtubeID"],
        desc: json["desc"],
        purchased: json["purchased"],
        courseLectures: json["courseLectures"] == null
            ? []
            : List<CourseLectureResponse>.from(json["courseLectures"]!
                .map((x) => CourseLectureResponse.fromJson(x))),
      );
}

class CourseLectureResponse extends CourseLecturesEntity {
  CourseLectureResponse({
    final int? id,
    final String? name,
    final int? videoCount,
    final int? examCount,
    final int? fileCount,
    final bool? isFree,
  }) : super(
          id: id.orZero(),
          name: name.orEmpty(),
          videoCount: videoCount.orZero(),
          examCount: examCount.orZero(),
          fileCount: fileCount.orZero(),
          isFree: isFree.orEmptyB(),
        );

  factory CourseLectureResponse.fromJson(Map<String, dynamic> json) =>
      CourseLectureResponse(
        id: json["id"],
        name: json["name"],
        videoCount: json["videoCount"],
        examCount: json["examCount"],
        fileCount: json["fileCount"],
        isFree: json["isFree"],
      );
}
