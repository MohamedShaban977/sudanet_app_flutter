
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../domain/entities/slider_entity.dart';

class SliderResponse extends SliderEntity {
  SliderResponse({
    final String? imagePath,
    final String? link,
  }) : super(imagePath: imagePath.orEmpty(), link: link.orEmpty());

  factory SliderResponse.fromJson(Map<String, dynamic> json) => SliderResponse(
        imagePath: json["imgPath"],
        link: json["link"],
      );
}
