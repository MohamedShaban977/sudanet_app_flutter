import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../widgets/custom_app_bar_widget.dart';
import '../../domain/entities/course_lecture_details_entity.dart';

class CourseLecturesScreen extends StatefulWidget {
  final CourseLectureDetailsEntity courseLectureDetails;
  final String initVideoID;

  const CourseLecturesScreen(
      {super.key,
      required this.courseLectureDetails,
      required this.initVideoID});

  @override
  State<CourseLecturesScreen> createState() => _CourseLecturesScreenState();
}

class _CourseLecturesScreenState extends State<CourseLecturesScreen> {
  bool isFullScreen = false;
  bool isShowBtnFullScreen = false;
  late final WebViewController _controller;

  String videoUrl = '';

  @override
  void initState() {
    super.initState();
    videoUrl = (widget.courseLectureDetails.videos.isNotEmpty)
        ? widget.courseLectureDetails.videos.first.youtubeID
        : widget.initVideoID;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (kDebugMode) {
              print('onPageFinished => $url');
            }
            setState(() {
              isShowBtnFullScreen = true;
            });
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      )
      ..loadRequest(Uri.parse(videoUrl));
  }

  @override
  void deactivate() {
    super.deactivate();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullScreen
          ? null
          : CustomAppBarWidget(title: widget.courseLectureDetails.courseName),
      body: ListView(
        children: [
          Stack(
            children: [
              SizedBox(
                width: context.width,
                height: isFullScreen ? context.height : context.height * 0.35,
                child: WebViewWidget(
                  controller: _controller,
                ),
              ),
              if (isShowBtnFullScreen)
                Positioned(
                  bottom: 8.0,
                  right: 5.0,
                  child: GestureDetector(
                    onTap: () {
                      if (isFullScreen) {}
                      if (MediaQuery.of(context).orientation ==
                          Orientation.portrait) {
                        SystemChrome.setPreferredOrientations([
                          DeviceOrientation.landscapeLeft,
                          DeviceOrientation.landscapeRight
                        ]);
                        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                            overlays: [SystemUiOverlay.bottom]);
                      } else {
                        SystemChrome.setPreferredOrientations(
                            [DeviceOrientation.portraitUp]);
                        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                            overlays: [SystemUiOverlay.top]);
                      }

                      setState(() {
                        isFullScreen = !isFullScreen;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(5.0)),
                      child: Icon(
                        isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
            ],
          ),
          CardViewMainDataCourseLectureWidget(
            lectureDetailsEntity: widget.courseLectureDetails,
          ),
        ],
      ),
    );
  }
}

class CardViewMainDataCourseLectureWidget extends StatelessWidget {
  final CourseLectureDetailsEntity lectureDetailsEntity;

  const CardViewMainDataCourseLectureWidget({
    super.key,
    required this.lectureDetailsEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.1,
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20.0),
            Text(lectureDetailsEntity.lectureName,
                style: context.bodyLarge.copyWith(color: ColorManager.primary)),
            const SizedBox(height: 20.0),
            Text(lectureDetailsEntity.courseName, style: context.bodyMedium),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
