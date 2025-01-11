/*      {
            "id": 1,
            "name": "تجارب 6 ابتدائي",
            "imgPath": "https://suda-net.com/Upload/8985724022023090854صs2.png",
            "teacherName": "أ/ مازن",
            "price": "200",
            "currencyName": "جنية"
               "categoryName": "الصف الدراسي السادس",
            "categoryId": 1
        }
        */

import 'package:equatable/equatable.dart';

class CoursesEntity extends Equatable {
  final int id;
  final String name;
  final String imagePath;
  final String teacherName;
  final String price;
  final String currencyName;
  final String categoryName;
  final int categoryId;

  const CoursesEntity({
    required this.id,
    required this.name,
    required this.imagePath,
    required this.teacherName,
    required this.price,
    required this.currencyName,
    required this.categoryName,
    required this.categoryId,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        imagePath,
        teacherName,
        price,
        currencyName,
        categoryName,
        categoryId,
      ];
}
