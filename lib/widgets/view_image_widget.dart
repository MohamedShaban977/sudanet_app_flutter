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
    return Image.network(
      imagePath,
      height: height,
      width: width,
      gaplessPlayback: true,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress != null) {
          return SizedBox(
              height: height,
              width: width,
              child: Center(
                child: CircularProgressIndicator(),
              ));
        }
        return child;
      },
      frameBuilder: (context, child, _, __) {
        return SizedBox(
          height: height,
          width: width,
          child: child,
        );
      },
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
    );
  }
}
