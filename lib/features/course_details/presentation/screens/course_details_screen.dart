import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../widgets/custom_app_bar_widget.dart';
import '../../../../widgets/custom_error_widget.dart';
import '../../../../widgets/custom_loading_widget.dart';
import '../../../../widgets/toast_and_snackbar.dart';
import '../../domain/entities/course_details_entity.dart';
import '../cubit/course_details_cubit.dart';

///
class CourseDetailsScreen extends StatefulWidget {
  final String id;

  const CourseDetailsScreen({super.key, required this.id});

  @override
  State<CourseDetailsScreen> createState() => _CourseDetailsScreenState();
}

class _CourseDetailsScreenState extends State<CourseDetailsScreen> with WidgetsBindingObserver {
  bool _isInForeground = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;

    if (kDebugMode) {
      print('isInForeground : $_isInForeground');
    }
    switch (state) {
      case AppLifecycleState.resumed:
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  late CourseDetailsEntity courseDetails;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
      listener: _listener,
      listenWhen: (previous, current) {
        return previous != current;
      },
      buildWhen: (previous, current) {
        return previous != current;
      },
      builder: (context, state) {
        if (state is GetCourseDetailsLoadingState) {
          return const Scaffold(body: CustomLoadingScreen());
        }
        if (state is GetCourseDetailsErrorState) {
          return const Scaffold(body: CustomErrorWidget());
        }
        return ModalProgressHUD(
          inAsyncCall: state is GetCourseLectureDetailsLoadingState,
          // child: CustomVideoWidget(
          //   videoId: courseDetails.youtubeID,
          //   builder: (BuildContext context, Widget player) {
          //     return BodyScreen(
          //       player: AspectRatio(aspectRatio: 16 / 9, child: player),
          //       courseDetails: courseDetails,
          //     );
          //   },
          // ),
          ///
          // child: Scaffold(
          //   appBar: isFullScreen
          //       ? null
          //       : CustomAppBarWidget(title: courseDetails.categoryName),
          //   body: Column(
          //     children: [
          //       Stack(
          //         children: [
          //           WebViewX(
          //             initialSourceType: SourceType.url,
          //             initialContent:
          //                 'https://iframe.mediadelivery.net/embed/191416/2e3fd468-ea92-4aa2-be3c-d82dde9f1590?autoplay=true&loop=true&muted=false&preload=true&responsive=true',
          //             onWebViewCreated: (controller) {
          //               webviewController = controller;
          //               webviewController.loadContent(
          //                 'https://iframe.mediadelivery.net/embed/191416/2e3fd468-ea92-4aa2-be3c-d82dde9f1590?autoplay=true&loop=true&muted=false&preload=true&responsive=true',
          //                 SourceType.url,
          //               );
          //             },
          //             onPageStarted: (value) {
          //               print('Start=> $value');
          //             },
          //             onPageFinished: (value) {
          //               print('finished => $value');
          //               if (value.isNotEmpty &&
          //                   value
          //                       .contains('https://iframe.mediadelivery.net')) {
          //                 setState(() {
          //                   isShowBtnFullScreen = true;
          //                 });
          //               }
          //             },
          //             width: context.width,
          //             height:
          //                 isFullScreen ? context.height : context.height * 0.35,
          //             javascriptMode: JavascriptMode.unrestricted,
          //             navigationDelegate: (request) {
          //               return NavigationDecision.navigate;
          //             },
          //           ),
          //           if (isShowBtnFullScreen)
          //             Positioned(
          //               bottom: 2.0,
          //               right: 2.0,
          //               child: GestureDetector(
          //                 onTap: () {
          //                   if (isFullScreen) {}
          //                   if (MediaQuery.of(context).orientation ==
          //                       Orientation.portrait) {
          //                     SystemChrome.setPreferredOrientations([
          //                       DeviceOrientation.landscapeLeft,
          //                       DeviceOrientation.landscapeRight
          //                     ]);
          //                     SystemChrome.setEnabledSystemUIMode(
          //                         SystemUiMode.manual,
          //                         overlays: [SystemUiOverlay.bottom]);
          //                   } else {
          //                     SystemChrome.setPreferredOrientations(
          //                         [DeviceOrientation.portraitUp]);
          //                     SystemChrome.setEnabledSystemUIMode(
          //                         SystemUiMode.manual,
          //                         overlays: [SystemUiOverlay.top]);
          //                   }
          //
          //                   setState(() {
          //                     isFullScreen = !isFullScreen;
          //                   });
          //                 },
          //                 child: Container(
          //                   decoration: BoxDecoration(
          //                       color: Colors.deepOrange,
          //                       borderRadius: BorderRadius.circular(5.0)),
          //                   child: Icon(
          //                     isFullScreen
          //                         ? Icons.fullscreen_exit
          //                         : Icons.fullscreen,
          //                     size: 35.0,
          //                     color: Colors.white,
          //                   ),
          //                 ),
          //               ),
          //             )
          //         ],
          //       ),
          //       if (!isFullScreen)
          //         Expanded(
          //             child: BodyScreen(
          //           courseDetails: courseDetails,
          //         ))
          //     ],
          //   ),
          // ),
          ///
          // child: CustomIframeVideoWidget(
          //   videoUrl: courseDetails.youtubeID,
          //   appBar: CustomAppBarWidget(title: courseDetails.categoryName),
          //   child:
          // ),
          child: Scaffold(
            appBar: CustomAppBarWidget(title: courseDetails.categoryName),
            body: BodyScreen(
              courseDetails: courseDetails,
            ),
          ),
        );
      },
    );
  }

  void _listener(context, state) {
    if (state is GetCourseDetailsSuccessState) {
      courseDetails = state.response.data!;
    }
    if (state is GetCourseLectureDetailsSuccessState) {
      ToastAndSnackBar.toastSuccess(message: state.response.message);

      MagicRouterName.navigateTo(RoutesNames.courseLectures, arguments: {
        'courseLectures': state.response.data!,
        'initVideoID': courseDetails.youtubeID,
      });
    }

    if (state is GetCourseLectureDetailsErrorState) {
      ToastAndSnackBar.toastError(message: state.error);
    }

    if (state is BuyCourseErrorState) {
      ToastAndSnackBar.toastError(message: state.error);
    }
    if (state is BuyCourseSuccessState) {
      ToastAndSnackBar.toastSuccess(message: state.response.message);
      sl<CourseDetailsCubit>().get(context).getCourseDetails('${courseDetails.id}');
      MagicRouter.pop();
    }
  }
}

///
class BodyScreen extends StatelessWidget {
  final CourseDetailsEntity courseDetails;

  const BodyScreen({
    super.key,
    required this.courseDetails,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      CardDetailsCourseWidget(courseDetails: courseDetails),
      const SizedBox(height: 20.0),
      CardContentCourseWidget(courseDetails: courseDetails),
    ]);
  }
}

///
class CardDetailsCourseWidget extends StatelessWidget {
  final CourseDetailsEntity courseDetails;

  const CardDetailsCourseWidget({
    super.key,
    required this.courseDetails,
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

            /// Name course
            Text(courseDetails.name, style: context.bodyLarge.copyWith(color: ColorManager.primary)),
            const SizedBox(height: 20.0),

            /// description course
            Text(courseDetails.description, style: context.bodyMedium),
            const SizedBox(height: 20.0),

            /// teacherName course
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Icon(
                    FontAwesomeIcons.chalkboardUser,
                    // size: 30.0,
                    color: ColorManager.grey,
                  ),
                  const SizedBox(width: 20.0),
                  Text(courseDetails.teacherName)
                ],
              ),
            ),
            const SizedBox(height: 40.0),

            /// price and currency Name
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     crossAxisAlignment: CrossAxisAlignment.end,
            //     children: [
            //       Text(
            //           '${courseDetails.price}    ${courseDetails.currencyName}',
            //           style: context.displayLarge
            //               .copyWith(color: ColorManager.textGray)),
            //       SizedBox(
            //         width: 150.0,
            //         height: 46.0,
            //         child: Visibility(
            //           visible: courseDetails.purchased,
            //           replacement: ElevatedButton(
            //               onPressed: () =>
            //                   PurchaseCourses.show(
            //                     context,
            //                     courseId: courseDetails.id,
            //                     isAlert: false,
            //                   ),
            //               child: Text(AppStrings.purchase.tr())),
            //           child: ElevatedButton(
            //               style: ElevatedButton.styleFrom(
            //                 disabledForegroundColor: ColorManager.primary,
            //                 disabledBackgroundColor: ColorManager.white,
            //                 elevation: 0.0,
            //                 side: const BorderSide(
            //                   color: ColorManager.secondary,
            //                 ),
            //               ),
            //               onPressed: null,
            //               child: Text(AppStrings.buyingSucceeded.tr())),
            //         ),
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}

///
class CardContentCourseWidget extends StatelessWidget {
  final CourseDetailsEntity courseDetails;

  const CardContentCourseWidget({
    super.key,
    required this.courseDetails,
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
            Text(AppStrings.contentCourse.tr(), style: context.bodyLarge.copyWith(color: ColorManager.textGray)),
            const SizedBox(height: 20.0),
            // Text('(7) حصص * (10) فيديوهات * 10س . 54د',
            //     style: context.bodyMedium),
            const SizedBox(height: 20.0),
            ...List.generate(
              courseDetails.courseLectures.length,
              (index) => ContentSession(
                iconLeading: _checkCoursePurchasedOrIsFree(index) ? FontAwesomeIcons.lockOpen : FontAwesomeIcons.lock,
                title: courseDetails.courseLectures[index].name,
                count: '${courseDetails.courseLectures[index].videoCount}',
                iconTrailing: FontAwesomeIcons.play,
              ),
            ),

            if (courseDetails.courseLectures.isEmpty)
              Align(
                alignment: AlignmentDirectional.center,
                child: Text(AppStrings.nosDataAvailable.tr(),
                    textAlign: TextAlign.center, style: context.bodyLarge.copyWith(color: ColorManager.textGray)),
              ),
            const SizedBox(height: 20.0),
          ],
        ),
      ),
    );
  }

  bool _checkCoursePurchasedOrIsFree(int index) {
    return courseDetails.courseLectures[index].isFree || courseDetails.purchased;
  }
}

///
class ContentSession extends StatelessWidget {
  final IconData iconLeading;
  final IconData iconTrailing;
  final String count;
  final String title;

  const ContentSession({
    super.key,
    required this.iconLeading,
    required this.iconTrailing,
    required this.count,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: ColorManager.lightGrey),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              iconLeading,
              // courseDetails.courseLectures[index].isFree
              //     ? FontAwesomeIcons.lockOpen
              //     : FontAwesomeIcons.lock,
              size: 20.0,
              color: ColorManager.primary,
            ),
            const SizedBox(width: 20.0),
            Expanded(
              child: Text(
                title,
                // AppStrings.videos.tr(),
                style: context.titleMedium.copyWith(
                  color: ColorManager.primary,
                  fontSize: 16.0,
                ),
              ),
            ),
            const SizedBox(width: 20.0),

            // Row(
            //   children: [
            //     Text(
            //       count,
            //       style: context.titleMedium.copyWith(
            //         color: ColorManager.primary,
            //         fontSize: 16.0,
            //       ),
            //     ),
            //     const SizedBox(width: 10.0),
            //     Text(
            //       title,
            //       // AppStrings.videos.tr(),
            //       style: context.titleMedium.copyWith(
            //         color: ColorManager.primary,
            //         fontSize: 16.0,
            //       ),
            //     ),
            //   ],
            // ),
            Icon(
              iconTrailing,
              // FontAwesomeIcons.play,
              size: 20.0,
              color: ColorManager.primary,
            ),
          ],
        ),
      ),
    );
  }
}

///
class CustomExpandedTitle extends StatefulWidget {
  final String textTitle;

  final Icon iconLeading;
  final List<Widget> children;
  final void Function()? onTap;

  final bool isExpanded;

  const CustomExpandedTitle(
      {super.key,
      required this.textTitle,
      required this.iconLeading,
      required this.children,
      this.isExpanded = false,
      this.onTap});

  @override
  State<CustomExpandedTitle> createState() => _CustomExpandedTitleState();
}

class _CustomExpandedTitleState extends State<CustomExpandedTitle> with SingleTickerProviderStateMixin {
  bool _isExpanded = false;

  _setExpanded([bool? value]) {
    setState(() {
      _isExpanded = value ?? widget.isExpanded;
    });
  }

  @override
  void initState() {
    _setExpanded();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: ExpansionTile(
        title: Text(widget.textTitle,
            style: context.displayMedium.copyWith(
                fontWeight: _isExpanded ? FontWeight.w700 : FontWeight.normal,
                color: _isExpanded ? ColorManager.primary : context.displayMedium.color)),
        // collapsedTextColor: ColorManager.primary,
        // textColor: ColorManager.primary,
        backgroundColor: ColorManager.secondary,
        initiallyExpanded: _isExpanded,
        collapsedIconColor: ColorManager.textGray,
        iconColor: ColorManager.primary,
        leading: widget.iconLeading,

        // const Icon(
        //   FontAwesomeIcons.lockOpen,
        //   size: 20.0,
        // ),
        onExpansionChanged: (value) => _setExpanded(value),
        // trailing: AnimatedIcon(
        //   icon: AnimatedIcons.add_event,
        //   progress: _controller,
        //   semanticLabel: 'Show menu',
        // ),
        trailing: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          transitionBuilder: (child, anim) => RotationTransition(
            turns: child.key == const ValueKey('icon1')
                ? Tween<double>(begin: 1, end: 0).animate(anim)
                : Tween<double>(begin: 0, end: 1).animate(anim),
            child: ScaleTransition(scale: anim, child: child),
          ),
          child: _isExpanded
              ? const Icon(Icons.remove, key: ValueKey('icon1'))
              : const Icon(Icons.add, key: ValueKey('icon2')),
        ),
        children: widget.children,
      ),
    );
  }
}
