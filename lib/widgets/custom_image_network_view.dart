import 'package:flutter/material.dart';

import '../core/app_manage/color_manager.dart';

class CustomViewImageNetwork extends StatelessWidget {
  const CustomViewImageNetwork({
    Key? key,
    required this.image,
    this.height,
    this.width,
    this.fit,
  }) : super(key: key);
  final String image;

  final double? height;

  final double? width;

  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image, // product.imageLink,
      height: height,
      // 110.0,
      width: width,
      fit: fit ?? BoxFit.cover,
      gaplessPlayback: true,
      errorBuilder: (context, _, __) {
        return SizedBox(
          height: height, // 110.0,
          child: const Center(
            child: Icon(
              Icons.error_outline,
              size: 50.0,
              color: ColorManager.error,
            ),
          ),
        );
      },
    );
  }
}
