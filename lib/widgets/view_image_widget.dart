import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    this.width,
    this.height,
    required this.imagePath,
  });

  final double? width;
  final double? height;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Image.network(
        imagePath,
        fit: BoxFit.fill,
        height: height,
        width: width,
        gaplessPlayback: true,
        errorBuilder: (context, error, stackTrace) {
          return SizedBox(
            height: height,
            width: width,
            child: const Icon(
              Icons.image_outlined,
              size: 30,
            ),
          );
        },
      ),
    );
  }
}
