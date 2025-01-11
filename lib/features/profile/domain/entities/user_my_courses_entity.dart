/* {
            "courseId": 1,
            "courseName": "رياضيات",
            "courseImage": "https://suda-net.com/Upload/22580625202373539PMmathematics-tomwang112.jpg",
            "teacherName": "أ/ مازن",
            "buyingDate": "3/3/2023"
        }
        */

import 'package:equatable/equatable.dart';

class UserMyCoursesEntity extends Equatable {
  final int courseId;
  final String courseName;
  final String courseImage;
  final String teacherName;
  final String buyingDate;

  const UserMyCoursesEntity(
      {required this.courseId,
      required this.courseName,
      required this.courseImage,
      required this.teacherName,
      required this.buyingDate});

  @override
  List<Object?> get props => [
        courseId,
        courseName,
        courseImage,
        teacherName,
        buyingDate,
      ];
}
