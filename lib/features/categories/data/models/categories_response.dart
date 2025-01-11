
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../domain/entities/categories_entity.dart';

class CategoriesResponse extends CategoriesEntity {
  CategoriesResponse({
    final int? id,
    final String? name,
    final String? imagePath,
  }) : super(
          id: id.orZero(),
          name: name.orEmpty(),
          imagePath: imagePath.orEmpty(),
        );

  factory CategoriesResponse.fromJson(Map<String, dynamic> json) =>
      CategoriesResponse(
        id: json["id"],
        imagePath: json["imgPath"],
        name: json["name"],
      );
}
