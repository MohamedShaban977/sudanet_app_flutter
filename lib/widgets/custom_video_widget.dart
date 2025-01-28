import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomVideoWidget extends StatefulWidget {
  final String videoId;

  final Widget Function(BuildContext context, Widget player) builder;

  const CustomVideoWidget(
      {super.key, required this.videoId, required this.builder});

  @override
  State<CustomVideoWidget> createState() => _CustomVideoWidgetState();
}

class _CustomVideoWidgetState extends State<CustomVideoWidget> {
  late YoutubePlayerController _controller;
  late YoutubeMetaData _videoMetaData;
  bool _muted = false;
  bool _isPlayerReady = false;

  @override
  void initState() {
    super.initState();
    if (widget.videoId.isNotEmpty) {
      var id = YoutubePlayer.convertUrlToId(widget.videoId) ?? '';
      _controller = YoutubePlayerController(
        initialVideoId: id,
        flags: const YoutubePlayerFlags(
          autoPlay: false,
        ),
      )..addListener(_listener);
      _videoMetaData = const YoutubeMetaData();
    }
  }

  void _listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onEnterFullScreen: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
          // SystemUiOverlay.top,
        ]);
      },
      onExitFullScreen: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
          SystemUiOverlay.top,
          SystemUiOverlay.bottom,
        ]);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: _topActions(),
        // aspectRatio: 0.1,
        width: context.width * 0.5,
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          // _controller
          //     .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          // _showSnackBar('Next Video Started!');
          _controller.load(data.videoId);
          _controller.pause();
        },
        actionsPadding: const EdgeInsets.only(top: 8.0),
        controlsTimeOut: _videoMetaData.duration,
        bottomActions: _bottomActions(),
      ),
      builder: widget.builder,
    );
  }

  List<Widget> _topActions() {
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

      /*  Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: LayoutBuilder(builder: (context, constraints) {
                debugPrint(constraints.toString());
                return Container(
                  color: Colors.transparent,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 8.0),
                              Text(
                                _controller.metadata.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          const Spacer(flex: 3),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Spacer(),
                          //     IconButton(
                          //       icon: const Icon(
                          //         Icons.first_page,
                          //         color: Colors.white,
                          //         size: 30.0,
                          //       ),
                          //       // onPressed: _isPlayerReady
                          //       //     ? () => _controller.load(
                          //       //      _ids[
                          //       // (_ids.indexOf(_controller.metadata.videoId) -
                          //       //     1) %
                          //       //     _ids.length]
                          //       // )
                          //       //     : null,
                          //       onPressed: () {
                          //         if (_controller.value.position.inSeconds <=
                          //             10) {
                          //           _controller
                          //               .seekTo(const Duration(seconds: 0));
                          //         } else {
                          //           int p0 =
                          //               _controller.value.position.inSeconds -
                          //                   10;
                          //           _controller.seekTo(Duration(seconds: p0));
                          //         }
                          //       },
                          //     ),
                          //     const Spacer(),
                          //     PlayPauseButton(),
                          //     const Spacer(),
                          //     IconButton(
                          //       icon: const Icon(
                          //         Icons.last_page,
                          //         color: Colors.white,
                          //         size: 30.0,
                          //       ),
                          //       onPressed: () {
                          //
                          //           int p0 =
                          //               _controller.value.position.inSeconds +
                          //                   10;
                          //           _controller.seekTo(Duration(seconds: p0));
                          //
                          //       },
                          //     ),
                          //     const Spacer(),
                          //   ],
                          // ),
                          const Spacer(flex: 5),
                        ],
                      ),
                      Positioned(
                        top: constraints.maxHeight / 2.6,
                        child: IconButton(
                          icon: const Icon(
                            Icons.first_page,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          // onPressed: _isPlayerReady
                          //     ? () => _controller.load(
                          //      _ids[
                          // (_ids.indexOf(_controller.metadata.videoId) -
                          //     1) %
                          //     _ids.length]
                          // )
                          //     : null,
                          onPressed: () {
                            if (_controller.value.position.inSeconds <= 10) {
                              _controller.seekTo(const Duration(seconds: 0));
                            } else {
                              int p0 =
                                  _controller.value.position.inSeconds - 10;
                              _controller.seekTo(Duration(seconds: p0));
                            }
                          },
                        ),
                      ),
                      Positioned(
                        top: constraints.maxHeight / 2.6,
                        right: 20.0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.last_page,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {
                            int p0 = _controller.value.position.inSeconds + 10;
                            _controller.seekTo(Duration(seconds: p0));
                          },
                        ),
                      ),
                      ...[
                        TouchShutter(
                          timeOut: _videoMetaData.duration,
                          controller: _controller,
                          disableDragSeek: true,
                        )
                      ]
                    ],
                  ),
                );
              }),
            ),
          ),*/
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
              durationFormatter(
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
  String durationFormatter(int milliSeconds) {
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
  }

/*  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }*/
}

class CustomVideoControllerWidget extends StatefulWidget {
  final YoutubePlayerController playerController;

  final Widget Function(BuildContext context, Widget player) builder;

  const CustomVideoControllerWidget(
      {super.key, required this.builder, required this.playerController});

  @override
  State<CustomVideoControllerWidget> createState() =>
      _CustomVideoControllerWidgetState();
}

class _CustomVideoControllerWidgetState
    extends State<CustomVideoControllerWidget> {
  late YoutubeMetaData _videoMetaData;
  bool _muted = false;
  bool _isPlayerReady = false;

  // @override
  // void initState() {
  //   super.initState();
  //   if (widget.videosIds.isNotEmpty) {
  //     var id = YoutubePlayer.convertUrlToId(widget.videosIds.first) ?? '';
  //     _controller = YoutubePlayerController(
  //       initialVideoId: id,
  //       flags: const YoutubePlayerFlags(
  //         autoPlay: false,
  //       ),
  //     )..addListener(_listener);
  //     _videoMetaData = const YoutubeMetaData();
  //   }
  // }
  //
  // void _listener() {
  //   if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
  //     setState(() {
  //       _videoMetaData = _controller.metadata;
  //     });
  //   }
  // }
  //
  // @override
  // void deactivate() {
  //   // Pauses video while navigating to next page.
  //   _controller.pause();
  //   // print("Deactivated");
  //   super.deactivate();
  // }
  //
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: widget.playerController,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: _topActions(),
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          // _controller
          //     .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
          // _showSnackBar('Next Video Started!');
          widget.playerController.load(data.videoId);
          widget.playerController.pause();
        },
        actionsPadding: const EdgeInsets.only(top: 8.0),
        controlsTimeOut: _videoMetaData.duration,
        bottomActions: _bottomActions(),
      ),
      builder: widget.builder,
    );
  }

  List<Widget> _topActions() {
    return <Widget>[
      const SizedBox(width: 8.0),
      Expanded(
        child: Text(
          widget.playerController.metadata.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
          textAlign: TextAlign.start,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
      ),

      /*  Expanded(
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: LayoutBuilder(builder: (context, constraints) {
                debugPrint(constraints.toString());
                return Container(
                  color: Colors.transparent,
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Stack(
                    children: [
                      Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(width: 8.0),
                              Text(
                                _controller.metadata.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                ),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            ],
                          ),
                          const Spacer(flex: 3),
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //   children: [
                          //     const Spacer(),
                          //     IconButton(
                          //       icon: const Icon(
                          //         Icons.first_page,
                          //         color: Colors.white,
                          //         size: 30.0,
                          //       ),
                          //       // onPressed: _isPlayerReady
                          //       //     ? () => _controller.load(
                          //       //      _ids[
                          //       // (_ids.indexOf(_controller.metadata.videoId) -
                          //       //     1) %
                          //       //     _ids.length]
                          //       // )
                          //       //     : null,
                          //       onPressed: () {
                          //         if (_controller.value.position.inSeconds <=
                          //             10) {
                          //           _controller
                          //               .seekTo(const Duration(seconds: 0));
                          //         } else {
                          //           int p0 =
                          //               _controller.value.position.inSeconds -
                          //                   10;
                          //           _controller.seekTo(Duration(seconds: p0));
                          //         }
                          //       },
                          //     ),
                          //     const Spacer(),
                          //     PlayPauseButton(),
                          //     const Spacer(),
                          //     IconButton(
                          //       icon: const Icon(
                          //         Icons.last_page,
                          //         color: Colors.white,
                          //         size: 30.0,
                          //       ),
                          //       onPressed: () {
                          //
                          //           int p0 =
                          //               _controller.value.position.inSeconds +
                          //                   10;
                          //           _controller.seekTo(Duration(seconds: p0));
                          //
                          //       },
                          //     ),
                          //     const Spacer(),
                          //   ],
                          // ),
                          const Spacer(flex: 5),
                        ],
                      ),
                      Positioned(
                        top: constraints.maxHeight / 2.6,
                        child: IconButton(
                          icon: const Icon(
                            Icons.first_page,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          // onPressed: _isPlayerReady
                          //     ? () => _controller.load(
                          //      _ids[
                          // (_ids.indexOf(_controller.metadata.videoId) -
                          //     1) %
                          //     _ids.length]
                          // )
                          //     : null,
                          onPressed: () {
                            if (_controller.value.position.inSeconds <= 10) {
                              _controller.seekTo(const Duration(seconds: 0));
                            } else {
                              int p0 =
                                  _controller.value.position.inSeconds - 10;
                              _controller.seekTo(Duration(seconds: p0));
                            }
                          },
                        ),
                      ),
                      Positioned(
                        top: constraints.maxHeight / 2.6,
                        right: 20.0,
                        child: IconButton(
                          icon: const Icon(
                            Icons.last_page,
                            color: Colors.white,
                            size: 30.0,
                          ),
                          onPressed: () {
                            int p0 = _controller.value.position.inSeconds + 10;
                            _controller.seekTo(Duration(seconds: p0));
                          },
                        ),
                      ),
                      ...[
                        TouchShutter(
                          timeOut: _videoMetaData.duration,
                          controller: _controller,
                          disableDragSeek: true,
                        )
                      ]
                    ],
                  ),
                );
              }),
            ),
          ),*/
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
              durationFormatter(
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
                _muted
                    ? widget.playerController.unMute()
                    : widget.playerController.mute();
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
  String durationFormatter(int milliSeconds) {
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
  }

/*  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.w300,
            fontSize: 16.0,
          ),
        ),
        backgroundColor: Colors.blueAccent,
        behavior: SnackBarBehavior.floating,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
    );
  }*/
}
