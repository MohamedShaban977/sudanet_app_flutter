/*

{
        "lectureNumber": 1,
        "lectureId": 11,
        "lectureName": "الحصة الاولي",
        "courseId": 4,
        "courseName": "لغة عربية",
        "videos": [
            {
                "sort": 1,
                "youtubeID": "TCpQVdayQik",
                "videoName": "الحصة"
            }
        ],
        "exams": [],
        "files": []
    }
*/


import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../domain/entities/course_lecture_details_entity.dart';

class CourseLectureDetailsResponse extends CourseLectureDetailsEntity {
  CourseLectureDetailsResponse({
    final int? lectureNumber,
    final int? lectureId,
    final String? lectureName,
    final int? courseId,
    final String? courseName,
    final List<Videos>? videos,
    final List<Exam>? exams,
    final List<Files>? files,
  }) : super(
          lectureNumber: lectureNumber.orZero(),
          lectureId: lectureId.orZero(),
          courseId: courseId.orZero(),
          lectureName: lectureName.orEmpty(),
          courseName: courseName.orEmpty(),
          videos: videos.orEmptyList(),
          exams: exams.orEmptyList(),
          files: files.orEmptyList(),
        );

  factory CourseLectureDetailsResponse.fromJson(Map<String, dynamic> json) =>
      CourseLectureDetailsResponse(
        lectureNumber: json["lectureNumber"],
        lectureId: json["lectureId"],
        lectureName: json["lectureName"],
        courseId: json["courseId"],
        courseName: json["courseName"],
        videos: json["videos"] == null
            ? []
            : List<Videos>.from(json["videos"]!.map((x) => Videos.fromJson(x))),
        exams: json["exams"] == null
            ? []
            : List<Exam>.from(json["exams"]!.map((x) => Exam.fromJson(x))),
        files: json["files"] == null
            ? []
            : List<Files>.from(json["files"]!.map((x) => Files.fromJson(x))),
      );
}

class Videos extends VideosEntity {
  Videos({
    final int? sort,
    final String? youtubeID,
    final String? videoName,
  }) : super(
          sort: sort.orZero(),
          youtubeID: youtubeID.orEmpty(),
          videoName: videoName.orEmpty(),
        );

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        sort: json["sort"],
        youtubeID: json["youtubeID"],
        videoName: json["videoName"],
      );
}

class Files extends FilesEntity {
  Files({
    final int? sort,
    final String? fileName,
    final String? filePath,
  }) : super(
          sort: sort.orZero(),
          fileName: fileName.orEmpty(),
          filePath: filePath.orEmpty(),
        );

  factory Files.fromJson(Map<String, dynamic> json) => Files(
        sort: json["sort"],
        fileName: json["fileName"],
        filePath: json["filePath"],
      );
}

class Exam extends ExamEntity {
  Exam({
    final int? id,
    final int? sort,
    final String? examName,
  }) : super(
          id: id.orZero(),
          sort: sort.orZero(),
          examName: examName.orEmpty(),
        );

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        sort: json["sort"],
        examName: json["examName"],
      );
}
