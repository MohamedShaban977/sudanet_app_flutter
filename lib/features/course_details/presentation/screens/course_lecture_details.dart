import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:external_path/external_path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:intl/intl.dart';

import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../widgets/custom_app_bar_widget.dart';
import '../../domain/entities/course_lecture_details_entity.dart';

class CourseLecturesScreen extends StatefulWidget {
  final CourseLectureDetailsEntity courseLectureDetails;
  final String initVideoID;

  const CourseLecturesScreen({super.key, required this.courseLectureDetails, required this.initVideoID});

  @override
  State<CourseLecturesScreen> createState() => _CourseLecturesScreenState();
}

class _CourseLecturesScreenState extends State<CourseLecturesScreen> {
  // late YoutubePlayerController _controller;
  // late YoutubeMetaData _videoMetaData;
  // bool _muted = false;
  // bool _isPlayerReady = false;

  bool isFullScreen = false;
  bool isShowBtnFullScreen = false;
  late final WebViewController _controller;

  String videoUrl = '';

  int? _progressLoading;

  final List<String> _fileNamesDownloaded = [];
  String? _fileName;

  final ReceivePort _port = ReceivePort();

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
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            if (kDebugMode) {
              print('onPageFinished => $url');
            }
            // if (url.isNotEmpty && url.contains(videoUrl)) {
            setState(() {
              isShowBtnFullScreen = true;
            });
            // }
          },
          onWebResourceError: (WebResourceError error) {},
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..loadRequest(Uri.parse(videoUrl));

    // var id = YoutubePlayer.convertUrlToId(
    //     (widget.courseLectureDetails.videos.isNotEmpty)
    //         ? widget.courseLectureDetails.videos.first.youtubeID
    //         : widget.initVideoID);
    ///
    // _controller = YoutubePlayerController(
    //   initialVideoId: id!,
    //   flags: const YoutubePlayerFlags(
    //     autoPlay: true,
    //   ),
    // )..addListener(_listener);
    // _videoMetaData = const YoutubeMetaData();

    IsolateNameServer.registerPortWithName(_port.sendPort, 'downloader_send_port');

    _port.listen((dynamic data) {
      // String id = data[0];
      // DownloadTaskStatus status = DownloadTaskStatus(data[1]);
      _progressLoading = data[2];
      setState(() {});
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  static void downloadCallback(String id, int status, int progress) {
    final SendPort send = IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  // void _listener() {
  //   if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
  //     setState(() {
  //       _videoMetaData = _controller.metadata;
  //     });
  //   }
  // }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    // _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    // _controller.dispose();
    IsolateNameServer.removePortNameMapping('downloader_send_port');

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullScreen ? null : CustomAppBarWidget(title: widget.courseLectureDetails.courseName),
      body: ListView(children: [
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
                    if (MediaQuery.of(context).orientation == Orientation.portrait) {
                      SystemChrome.setPreferredOrientations(
                          [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
                    } else {
                      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
                      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
                    }

                    setState(() {
                      isFullScreen = !isFullScreen;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(color: Colors.deepOrange, borderRadius: BorderRadius.circular(5.0)),
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
        CardViewMainDataCourseLectureWidget(lectureDetailsEntity: widget.courseLectureDetails),
        // const SizedBox(height: 40.0),
        CardViewVideosCourseLectureWidget(
          lectureDetailsEntity: widget.courseLectureDetails,
          playerController: _controller,
        )
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: isFullScreen
          ? const SizedBox.shrink()
          : FloatingActionButton.extended(
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              onPressed: () => _buildShowBottomSheetContentAndExamsCourses(context),
              isExtended: true,
              label: const Text('المحتوى العلمى | الامتحانات'),
            ),
    );
  }

  _buildShowBottomSheetContentAndExamsCourses(BuildContext context) {
    // _controller.pause();
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // enableDrag: true,

      builder: (context) => SingleChildScrollView(
        child: SizedBox(
          height: context.height * 0.6,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            child: Column(
              children: [
                Container(
                  height: 6.0,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  width: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                const SizedBox(height: 20.0),
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text('تحميل المحتوى العلمى',
                      style: context.bodyMedium.copyWith(
                        color: ColorManager.primary,
                      )),
                ),
                const SizedBox(height: 10.0),
                ...List.generate(
                  widget.courseLectureDetails.files.length,
                  (index) => Card(
                    // elevation: 0.0,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                      child: TextButton(
                        onPressed: () async {
                          late String appStorage;
                          final status = await Permission.storage.request();
                          if (status.isGranted) {
                            // final externalDirectory = await getExternalStorageDirectory();

                            if (Platform.isAndroid) {
                              appStorage = (await ExternalPath.getExternalStoragePublicDirectory(
                                  ExternalPath.DIRECTORY_DOWNLOADS));
                            } else if (Platform.isIOS) {
                              Directory appDocDir = (await getApplicationDocumentsDirectory());
                              appStorage = appDocDir.path;
                            }
                            await FlutterDownloader.enqueue(
                              url: widget.courseLectureDetails.files[index].filePath,
                              savedDir: appStorage,
                              fileName: _fileNameAndCurrantData(index),
                              showNotification: true,
                              openFileFromNotification: true,
                            );
                            _fileName = widget.courseLectureDetails.files[index].fileName;
                            _fileNamesDownloaded.add(widget.courseLectureDetails.files[index].fileName);
                          } else {}

                          ///
                          // _downloadFile(
                          //   path:
                          //       widget.lectureDetailsEntity.files[index].filePath,
                          //   name:
                          //       widget.lectureDetailsEntity.files[index].fileName,
                          // );
                        },
                        style: TextButton.styleFrom(
                          foregroundColor: ColorManager.secondary.withValues(alpha: 0.9),
                          // elevation: 0.0,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(widget.courseLectureDetails.files[index].fileName, style: context.bodyMedium),
                            ),
                            (_progressLoading != null &&
                                    _progressLoading != 100 &&
                                    _fileName == widget.courseLectureDetails.files[index].fileName)
                                ? Text(
                                    '$_progressLoading',
                                    style: context.bodyMedium,
                                  )
                                : (_fileNamesDownloaded.contains(widget.courseLectureDetails.files[index].fileName))
                                    ? const Icon(
                                        Icons.check,
                                        size: 25,
                                        color: Colors.green,
                                      )
                                    : const Icon(
                                        Icons.download,
                                        size: 25,
                                        color: ColorManager.primary,
                                      ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                if (widget.courseLectureDetails.files.isEmpty)
                  Align(
                    alignment: AlignmentDirectional.center,
                    child: Text(AppStrings.nosDataAvailable.tr(),
                        textAlign: TextAlign.center, style: context.bodyMedium.copyWith(color: ColorManager.textGray)),
                  ),
                const SizedBox(height: 20.0),
                const Divider(
                  height: 10.0,
                  thickness: 2,
                ),
                const SizedBox(height: 20.0),
                // Align(
                //   alignment: AlignmentDirectional.centerStart,
                //   child: Text('الامتحانات',
                //       style: context.bodyMedium.copyWith(
                //         color: ColorManager.primary,
                //       )),
                // ),
                // const SizedBox(height: 10.0),
                // ...List.generate(
                //   widget.courseLectureDetails.exams.length,
                //   (index) => Card(
                //     // elevation: 0.0,
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(
                //           horizontal: 15.0, vertical: 5.0),
                //       child: TextButton(
                //         onPressed: () {
                //           // _controller.pause();
                //           MagicRouterName.navigateTo(
                //               RoutesNames.examLayoutRoute,
                //               arguments: {
                //                 'id':
                //                     '${widget.courseLectureDetails.exams[index].id}'
                //               });
                //         },
                //         style: TextButton.styleFrom(
                //           foregroundColor:
                //               ColorManager.secondary.withOpacity(0.9),
                //           // elevation: 0.0,
                //         ),
                //         child: Row(
                //           children: [
                //             Expanded(
                //               child: Text(
                //                   widget.courseLectureDetails.exams[index]
                //                       .examName,
                //                   style: context.bodyMedium),
                //             ),
                //             const Icon(
                //               Icons.question_mark,
                //               size: 25,
                //               color: ColorManager.primary,
                //             )
                //           ],
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // if (widget.courseLectureDetails.exams.isEmpty)
                //   Align(
                //     alignment: AlignmentDirectional.center,
                //     child: Text(AppStrings.nosDataAvailable.tr(),
                //         textAlign: TextAlign.center,
                //         style: context.bodyMedium
                //             .copyWith(color: ColorManager.textGray)),
                //   ),
              ],
            ),
          ),
        ),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    );
  }

  String _fileNameAndCurrantData(int index) {
    DateTime dateTime = DateTime.now();

    String fileName = widget.courseLectureDetails.files[index].fileName;
    String extensionFile = widget.courseLectureDetails.files[index].filePath.split('.').last;
    var dateTimeFormat = DateFormat('dd-MM-yyyy-hhmmss').format(dateTime);
    return '$fileName-$dateTimeFormat.$extensionFile';
  }

/*  _downloadFile({required String path, required String name}) async {
    late String appStorage;
    if (await Permission.storage.request().isGranted) {
      if (Platform.isAndroid) {
        appStorage = (await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS));
      } else if (Platform.isIOS) {
        Directory appDocDir = (await getApplicationDocumentsDirectory());
        appStorage = appDocDir.path;
      }
      setState(() {
        _progress = true;
        _fileName = name;
        // _fileNamesDownloaded.add(name);
      });
      // final appStorage = await getExternalStorageDirectory();
      final file = File('$appStorage/$name.${path.split('.').last}');
      print(file.path);
      final response = await Dio().get(
        path,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
      print(response.data);
      final ref = file.openSync(mode: FileMode.write);
      ref.writeFromSync(response.data);
      await ref.close();

      setState(() {
        _progress = false;
        _fileName = name;
        _fileNamesDownloaded.add(name);
      });
      return file;
    }
  }*/

/*  List<Widget> _topActions() {
    return <Widget>[
      const SizedBox(width: 8.0),
      Expanded(
        child: Text(
          _controller.metadata.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),
    ];
  }

  List<Widget> _bottomActions() {
    return [
      const SizedBox(width: 8.0),

      // const SizedBox(width: 14.0),
      SizedBox(
        // width: 100.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              _durationFormatter(
                _videoMetaData.duration.inMilliseconds,
              ),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
            const Text(
              ' / ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
            CurrentPosition(),
          ],
        ),
      ),
      // const SizedBox(width: 8.0),
      ProgressBar(
        isExpanded: true,
        colors: const ProgressBarColors(),
      ),
      IconButton(
        icon: Icon(
          _muted ? Icons.volume_off : Icons.volume_up,
          color: Colors.white,
        ),
        padding: EdgeInsets.zero,
        onPressed: _isPlayerReady
            ? () {
                _muted ? _controller.unMute() : _controller.mute();
                setState(() {
                  _muted = !_muted;
                });
              }
            : null,
      ),
      const PlaybackSpeedButton(),
      FullScreenButton(),
    ];
  }

  /// Formats duration in milliseconds to xx:xx:xx format.
  String _durationFormatter(int milliSeconds) {
    var seconds = milliSeconds ~/ 1000;
    final hours = seconds ~/ 3600;
    seconds = seconds % 3600;
    var minutes = seconds ~/ 60;
    seconds = seconds % 60;
    final hoursString = hours >= 10
        ? '$hours'
        : hours == 0
            ? '00'
            : '0$hours';
    final minutesString = minutes >= 10
        ? '$minutes'
        : minutes == 0
            ? '00'
            : '0$minutes';
    final secondsString = seconds >= 10
        ? '$seconds'
        : seconds == 0
            ? '00'
            : '0$seconds';
    final formattedTime =
        '${hoursString == '00' ? '' : '$hoursString:'}$minutesString:$secondsString';
    return formattedTime;
  }*/
}

///
/*class BodyScreen extends StatelessWidget {
  final Widget player;
  final CourseLectureDetailsEntity lectureDetailsEntity;
  final YoutubePlayerController playerController;

  const BodyScreen({
    super.key,
    required this.player,
    required this.lectureDetailsEntity,
    required this.playerController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(title: lectureDetailsEntity.courseName),
      body: ListView(children: [
        player,
        CardViewMainDataCourseLectureWidget(
            lectureDetailsEntity: lectureDetailsEntity),
        // const SizedBox(height: 40.0),
        CardViewVideosCourseLectureWidget(
          lectureDetailsEntity: lectureDetailsEntity,
          playerController: playerController,
        )
      ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: ColorManager.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        onPressed: () => _buildShowBottomSheetContentAndExamsCourses(context),
        isExtended: true,
        label: const Text('المحتوى العلمى | الامتحانات'),
      ),
    );
  }

  _buildShowBottomSheetContentAndExamsCourses(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // enableDrag: true,
      builder: (context) => ContentAndExamsCourses(
          controller: playerController,
          lectureDetailsEntity: lectureDetailsEntity),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
      ),
      backgroundColor: Theme.of(context).bottomSheetTheme.backgroundColor,
    );
  }
}*/

///
/*

class ContentAndExamsCourses extends StatefulWidget {
  const ContentAndExamsCourses({
    super.key,
    required this.lectureDetailsEntity,
    required this.controller,
  });

  final CourseLectureDetailsEntity lectureDetailsEntity;
  final YoutubePlayerController controller;

  @override
  State<ContentAndExamsCourses> createState() => _ContentAndExamsCoursesState();
}

class _ContentAndExamsCoursesState extends State<ContentAndExamsCourses> {
  bool _progress = false;
  int? _progressLoading;

  final List<String> _fileNamesDownloaded = [];
  String? _fileName;

  final ReceivePort _port = ReceivePort();

  @override
  void initState() {
    super.initState();
    IsolateNameServer.registerPortWithName(
        _port.sendPort, 'downloader_send_port');

    _port.listen((dynamic data) {
      String id = data[0];
      DownloadTaskStatus status = DownloadTaskStatus(data[1]);
      _progressLoading = data[2];
      setState(() {});
      print(_progressLoading);
    });
    FlutterDownloader.registerCallback(downloadCallback);
  }

  @override
  void dispose() {
    IsolateNameServer.removePortNameMapping('downloader_send_port');
    widget.controller.dispose();
    super.dispose();
  }

  @override
  void deactivate() {
    widget.controller.pause();
    print('deactivate');
    super.deactivate();
  }

  static void downloadCallback(String id, int status, int progress) {
    final SendPort send =
        IsolateNameServer.lookupPortByName('downloader_send_port')!;
    send.send([id, status, progress]);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: context.height * 0.6,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Column(
            children: [
              Container(
                height: 6.0,
                margin: const EdgeInsets.symmetric(vertical: 8),
                width: MediaQuery.of(context).size.width / 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('تحميل المحتوى العلمى',
                    style: context.bodyMedium.copyWith(
                      color: ColorManager.primary,
                    )),
              ),
              const SizedBox(height: 10.0),
              ...List.generate(
                widget.lectureDetailsEntity.files.length,
                (index) => Card(
                  // elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    child: TextButton(
                      onPressed: () async {
                        late String appStorage;
                        final status = await Permission.storage.request();
                        if (status.isGranted) {
                          // final externalDirectory = await getExternalStorageDirectory();

                          if (Platform.isAndroid) {
                            appStorage = (await ExternalPath
                                .getExternalStoragePublicDirectory(
                                    ExternalPath.DIRECTORY_DOWNLOADS));
                          } else if (Platform.isIOS) {
                            Directory appDocDir =
                                (await getApplicationDocumentsDirectory());
                            appStorage = appDocDir.path;
                          }
                          final res = await FlutterDownloader.enqueue(
                            url: widget
                                .lectureDetailsEntity.files[index].filePath,
                            savedDir: appStorage,
                            fileName: _fileNameAndCurrantData(index),
                            showNotification: true,
                            openFileFromNotification: true,
                          );
                          _fileName =
                              widget.lectureDetailsEntity.files[index].fileName;
                          _fileNamesDownloaded.add(widget
                              .lectureDetailsEntity.files[index].fileName);
                        } else {}

                        ///
                        // _downloadFile(
                        //   path:
                        //       widget.lectureDetailsEntity.files[index].filePath,
                        //   name:
                        //       widget.lectureDetailsEntity.files[index].fileName,
                        // );
                      },
                      style: TextButton.styleFrom(
                        foregroundColor:
                            ColorManager.secondary.withOpacity(0.9),
                        // elevation: 0.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                widget
                                    .lectureDetailsEntity.files[index].fileName,
                                style: context.bodyMedium),
                          ),
                          (_progressLoading != null &&
                                  _progressLoading != 100 &&
                                  _fileName ==
                                      widget.lectureDetailsEntity.files[index]
                                          .fileName)
                              ? */
/*CircularProgressIndicator(
                                  backgroundColor: Colors.grey,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.green),
                                  value: double.tryParse(
                                      _progressLoading.toString()),
                                )*/
/*

                              Text(
                                  '$_progressLoading',
                                  style: context.bodyMedium,
                                )
                              : (_fileNamesDownloaded.contains(widget
                                      .lectureDetailsEntity
                                      .files[index]
                                      .fileName))
                                  ? const Icon(
                                      Icons.check,
                                      size: 25,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.download,
                                      size: 25,
                                      color: ColorManager.primary,
                                    ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.lectureDetailsEntity.files.isEmpty)
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(AppStrings.nosDataAvailable.tr(),
                      textAlign: TextAlign.center,
                      style: context.bodyMedium
                          .copyWith(color: ColorManager.textGray)),
                ),
              const SizedBox(height: 20.0),
              const Divider(
                height: 10.0,
                thickness: 2,
              ),
              const SizedBox(height: 20.0),
              Align(
                alignment: AlignmentDirectional.centerStart,
                child: Text('الامتحانات',
                    style: context.bodyMedium.copyWith(
                      color: ColorManager.primary,
                    )),
              ),
              const SizedBox(height: 10.0),
              ...List.generate(
                widget.lectureDetailsEntity.exams.length,
                (index) => Card(
                  // elevation: 0.0,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5.0),
                    child: TextButton(
                      onPressed: () => MagicRouterName.navigateTo(
                          RoutesNames.examLayoutRoute,
                          arguments: {
                            'id':
                                '${widget.lectureDetailsEntity.exams[index].id}'
                          }),
                      style: TextButton.styleFrom(
                        foregroundColor:
                            ColorManager.secondary.withOpacity(0.9),
                        // elevation: 0.0,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                                widget
                                    .lectureDetailsEntity.exams[index].examName,
                                style: context.bodyMedium),
                          ),
                          const Icon(
                            Icons.question_mark,
                            size: 25,
                            color: ColorManager.primary,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              if (widget.lectureDetailsEntity.exams.isEmpty)
                Align(
                  alignment: AlignmentDirectional.center,
                  child: Text(AppStrings.nosDataAvailable.tr(),
                      textAlign: TextAlign.center,
                      style: context.bodyMedium
                          .copyWith(color: ColorManager.textGray)),
                ),
            ],
          ),
        ),
      ),
    );
  }

  String _fileNameAndCurrantData(int index) {
    DateTime dateTime = DateTime.now();

    String fileName = widget.lectureDetailsEntity.files[index].fileName;
    String extensionFile =
        widget.lectureDetailsEntity.files[index].filePath.split('.').last;
    var dateTimeFormat = DateFormat('dd-MM-yyyy-hhmmss').format(dateTime);
    print('$fileName-$dateTimeFormat.$extensionFile');
    return '$fileName-$dateTimeFormat.$extensionFile';
  }

  _downloadFile({required String path, required String name}) async {
    late String appStorage;
    if (await Permission.storage.request().isGranted) {
      if (Platform.isAndroid) {
        appStorage = (await ExternalPath.getExternalStoragePublicDirectory(
            ExternalPath.DIRECTORY_DOWNLOADS));
      } else if (Platform.isIOS) {
        Directory appDocDir = (await getApplicationDocumentsDirectory());
        appStorage = appDocDir.path;
      }
      setState(() {
        _progress = true;
        _fileName = name;
        // _fileNamesDownloaded.add(name);
      });
      // final appStorage = await getExternalStorageDirectory();
      final file = File('$appStorage/$name.${path.split('.').last}');
      print(file.path);
      final response = await Dio().get(
        path,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          receiveTimeout: const Duration(seconds: 10),
        ),
      );
      print(response.data);
      final ref = file.openSync(mode: FileMode.write);
      ref.writeFromSync(response.data);
      await ref.close();

      setState(() {
        _progress = false;
        _fileName = name;
        _fileNamesDownloaded.add(name);
      });
      return file;
    }
  }
}
*/

///
///
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
            Text(lectureDetailsEntity.lectureName, style: context.bodyLarge.copyWith(color: ColorManager.primary)),
            const SizedBox(height: 20.0),
            Text(lectureDetailsEntity.courseName, style: context.bodyMedium),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}

class CardViewVideosCourseLectureWidget extends StatefulWidget {
  final CourseLectureDetailsEntity lectureDetailsEntity;
  final WebViewController playerController;

  const CardViewVideosCourseLectureWidget({
    super.key,
    required this.lectureDetailsEntity,
    required this.playerController,
  });

  @override
  State<CardViewVideosCourseLectureWidget> createState() => _CardViewVideosCourseLectureWidgetState();
}

class _CardViewVideosCourseLectureWidgetState extends State<CardViewVideosCourseLectureWidget> {
  String? currentUrl = '';

  getUrl() async {
    currentUrl = await widget.playerController.currentUrl();
    setState(() {});
    if (kDebugMode) {
      print('currentUrl ==> $currentUrl');
    }
  }

  @override
  void initState() {
    super.initState();
    getUrl();
  }

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
            ...List.generate(
                widget.lectureDetailsEntity.videos.length,
                (index) => Column(
                      children: [
                        Card(
                          color: widget.lectureDetailsEntity.videos[index].youtubeID == currentUrl
                              ? ColorManager.secondary_2
                              : null,
                          elevation: 0.0,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                            child: TextButton(
                              onPressed: widget.lectureDetailsEntity.videos[index].youtubeID != currentUrl
                                  ? () {
                                      widget.playerController
                                          .loadRequest(Uri.parse(widget.lectureDetailsEntity.videos[index].youtubeID));
                                    }
                                  : null,
                              style: TextButton.styleFrom(
                                foregroundColor: ColorManager.secondary.withValues(alpha: 0.9),
                                // elevation: 0.0,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(widget.lectureDetailsEntity.videos[index].videoName,
                                        style: context.bodyLarge.copyWith(color: ColorManager.primary)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        const Divider(
                          height: 10.0,
                          thickness: 2,
                        ),
                        const SizedBox(height: 10.0),
                      ],
                    )),
            if (widget.lectureDetailsEntity.videos.isEmpty)
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(AppStrings.nosDataAvailable.tr(),
                    textAlign: TextAlign.center, style: context.bodyLarge.copyWith(color: ColorManager.textGray)),
              ),
            const SizedBox(height: 40.0),
          ],
        ),
      ),
    );
  }
}
