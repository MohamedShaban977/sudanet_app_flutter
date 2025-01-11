/*{
        "id": 1,
        "name": "تجارب 6 ابتدائي",
        "imgPath": "https://suda-net.com/Upload/8985724022023090854صs2.png",
        "teacherName": "أ/ مازن",
        "price": "200",
        "currencyName": "جنية",
        "categoryName": "الصف الدراسي السادس",
        "categoryId": 1,
        "youtubeID": "GU7OhANE0sU",
        "desc": "اقوي تجميعة تجارب 6 ابتدائي",
        "purchased": false,
        "courseLectures": [
            {
                "name": "المقدمة",
                "videoCount": 1,
                "examCount": 1,
                "fileCount": 1,
                "id": 0,
                "isFree": false
            }
        ]
    }
    */

import 'package:equatable/equatable.dart';

class CourseDetailsEntity extends Equatable {
  final int id;
  final String name;
  final String description;
  final String imagePath;
  final String teacherName;
  final String price;
  final String currencyName;
  final String categoryName;
  final int categoryId;
  final String youtubeID;
  final bool purchased;
  final List<CourseLecturesEntity> courseLectures;

  const CourseDetailsEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.imagePath,
      required this.teacherName,
      required this.price,
      required this.currencyName,
      required this.categoryName,
      required this.categoryId,
      required this.youtubeID,
      required this.courseLectures,
      required this.purchased});

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        imagePath,
        teacherName,
        price,
        currencyName,
        categoryName,
        categoryId,
        youtubeID,
        purchased,
        courseLectures,
      ];
}

/*             {
                "name": "المقدمة",
                "videoCount": 1,
                "examCount": 1,
                "fileCount": 1,
                "id": 0,
                "isFree": false
            }
            */

class CourseLecturesEntity extends Equatable {
  final String name;
  final int videoCount;
  final int examCount;
  final int fileCount;
  final int id;

  final bool isFree;

  const CourseLecturesEntity(
      {required this.id,
      required this.name,
      required this.videoCount,
      required this.examCount,
      required this.fileCount,
      required this.isFree});

  @override
  List<Object?> get props => [
        id,
        name,
        videoCount,
        examCount,
        fileCount,
        isFree,
      ];
}
