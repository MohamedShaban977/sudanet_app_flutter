import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ScreenshotPreventionWidget extends StatefulWidget {
  final Widget child;

  const ScreenshotPreventionWidget({
    super.key,
    required this.child,
  });

  @override
  State<ScreenshotPreventionWidget> createState() =>
      _ScreenshotPreventionWidgetState();
}

class _ScreenshotPreventionWidgetState
    extends State<ScreenshotPreventionWidget> {
  @override
  void initState() {
    super.initState();
    _preventScreenshots();
  }

  @override
  void dispose() {
    _allowScreenshots();
    super.dispose();
  }

  Future<void> _preventScreenshots() async {
    // Prevent screenshots on Android
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
    );

    // Prevent screenshots on iOS
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top,
        SystemUiOverlay.bottom,
      ],
    );

    // Add FLAG_SECURE on Android
    if (Theme.of(context).platform == TargetPlatform.android) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ),
      );
      await const MethodChannel('preventScreenshot')
          .invokeMethod('preventScreenshot');
    }
  }

  Future<void> _allowScreenshots() async {
    await SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
