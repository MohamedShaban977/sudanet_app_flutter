/*       {
            "id": 1,
            "imgPath": "https://suda-net.com/Upload/4998924022023085023صs1.png",
            "name": "الصف الدراسي السادس"
        }
        */

import 'package:equatable/equatable.dart';

class CategoriesEntity extends Equatable {
  final int id;
  final String name;
  final String imagePath;

  const CategoriesEntity({
    required this.id,
    required this.name,
    required this.imagePath,
  });

  @override
  List<Object?> get props => [id, name, imagePath];
}
