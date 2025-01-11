import 'package:equatable/equatable.dart';

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
class CourseLectureDetailsEntity extends Equatable {
  final int lectureNumber;
  final int lectureId;
  final int courseId;
  final String lectureName;
  final String courseName;
  final List<VideosEntity> videos;

  /// TODO: add model Exams and Files
  final List<ExamEntity> exams;
  final List<FilesEntity> files;

  const CourseLectureDetailsEntity(
      {required this.lectureNumber,
      required this.lectureId,
      required this.courseId,
      required this.lectureName,
      required this.courseName,
      required this.videos,
      required this.exams,
      required this.files});

  @override
  List<Object?> get props => [
        lectureNumber,
        lectureId,
        lectureName,
        courseId,
        courseName,
        videos,
        files,
        exams
      ];
}

/*
  {
                "sort": 1,
                "youtubeID": "TCpQVdayQik",
                "videoName": "الحصة"
            }
            */
class VideosEntity extends Equatable {
  final int sort;
  final String youtubeID;
  final String videoName;

  const VideosEntity({
    required this.sort,
    required this.youtubeID,
    required this.videoName,
  });

  @override
  List<Object?> get props => [
        sort,
        youtubeID,
        videoName,
      ];
}

/*{
                "sort": 0,
                "fileName": "مراجعة عامة",
                "filePath": "https://suda-net.com/Upload/1726625202380552PMIC-sample-business-requirements-document-template-11238_WORD.docx"
            }*/
class FilesEntity extends Equatable {
  final int sort;
  final String filePath;
  final String fileName;

  const FilesEntity({
    required this.sort,
    required this.filePath,
    required this.fileName,
  });

  @override
  List<Object?> get props => [
        sort,
        fileName,
        filePath,
      ];
}

/*
{
"id":3,
"sort":0,
"examName":"أمتحان الحصة الثانية"
}
* */
class ExamEntity extends Equatable {
  final int id;
  final int sort;
  final String examName;

  const ExamEntity({
    required this.id,
    required this.sort,
    required this.examName,
  });

  @override
  List<Object?> get props => [
        id,
        sort,
        examName,
      ];
}
