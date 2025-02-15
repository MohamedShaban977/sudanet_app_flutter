import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webviewx/webviewx.dart';

class CustomIframeVideoWidget extends StatefulWidget {
  final Widget child;
  final String videoUrl;
  final PreferredSizeWidget? appBar;

  const CustomIframeVideoWidget(
      {super.key, required this.child, this.appBar, required this.videoUrl});

  @override
  State<CustomIframeVideoWidget> createState() =>
      _CustomIframeVideoWidgetState();
}

class _CustomIframeVideoWidgetState extends State<CustomIframeVideoWidget> {
  bool isFullScreen = false;
  bool isShowBtnFullScreen = false;

  late final WebViewController _controller;
  String _url = '';

  @override
  void initState() {
    super.initState();

    _url = widget.videoUrl;

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            debugPrint('onPageFinished => $url');
            setState(() {
              isShowBtnFullScreen = true;
            });
            // }
          },
          onWebResourceError: (WebResourceError error) {},
        ),
      );

    if (_url.isNotEmpty) {
      _controller.loadRequest(Uri.parse(_url));
    } else {
      _controller.loadHtmlString('''
          <HTML>
             <BODY>
                <H3 style='height:100vh;display:flex;justify-content: center;align-items: center;font-size: 30px'>Loading...</H3>
             </BODY>
          </HTML>
          ''');
    }
  }

  @override
  void dispose() {
    _controller.clearCache();
    _controller.clearLocalStorage();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isFullScreen ? null : widget.appBar,
      body: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: context.width,
                height: isFullScreen ? context.height : context.height * 0.3,
                child: WebViewWidget(
                  controller: _controller,
                ),
              ),
              if (isShowBtnFullScreen)
                Positioned(
                  bottom: 6.0,
                  right: isFullScreen ? 5.0 : 2.0,
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
                          color: Colors.deepOrange[400],
                          borderRadius:
                              BorderRadius.circular(isFullScreen ? 5.0 : 2.0)),
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
          if (!isFullScreen) Expanded(child: widget.child)
        ],
      ),
    );
  }
}
