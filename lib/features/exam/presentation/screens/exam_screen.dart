import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';
import 'package:sudanet_app_flutter/core/locale/app_localizations.dart';

import 'package:vector_math/vector_math_64.dart' as vector;

import '../../../../app/injection_container.dart';
import '../../../../core/app_manage/color_manager.dart';
import '../../../../core/app_manage/strings_manager.dart';
import '../../../../core/app_manage/values_manager.dart';
import '../../../../core/packages/quickalert/quickalert.dart';
import '../../../../core/routes/magic_router.dart';
import '../../../../core/routes/routes_name.dart';
import '../../../../widgets/custom_button_with_loading.dart';
import '../../../../widgets/custom_error_widget.dart';
import '../../../../widgets/custom_loading_widget.dart';
import '../../../../widgets/toast_and_snackbar.dart';
import '../../data/models/exam_response.dart';
import '../../data/models/save_answer_request.dart';
import '../cubit/exam_cubit.dart';

// ignore: constant_identifier_names
enum ExamQuestionType { MULTI, SORT, TORF, LINK }

enum ExamType { exam, homework }

class ExamScreen extends StatefulWidget {
  final String id;

  final ExamType type;

  const ExamScreen({super.key, required this.id, required this.type});

  @override
  State<ExamScreen> createState() => _ExamScreenState();
}

class _ExamScreenState extends State<ExamScreen> with WidgetsBindingObserver {
  bool _isInForeground = true;

  ExamModel? _examModel;

  int _indexQuestion = 0;
  final ValueNotifier<String?> answerValue = ValueNotifier(null);

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    _isInForeground = state == AppLifecycleState.resumed;

    if (kDebugMode) {
      print('isInForeground : $_isInForeground');
    }
    switch (state) {
      case AppLifecycleState.resumed:
        sl<ExamCubit>().get(context).getExamQuestionOrPercentage(
              examId: widget.id,
              type: widget.type,
            );
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
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  AppBar _buildAppBarHomeWork(BuildContext context) {
    return AppBar(
      elevation: AppSize.s5,
      centerTitle: false,
      backgroundColor: ColorManager.background,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: ColorManager.background,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.dark,
      ),
      title: Text(AppStrings.homeworks.tr(),
          style: context.displayLarge.copyWith(
              color: ColorManager.textGray, fontWeight: FontWeight.w700)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExamCubit, ExamState>(
      listener: _initListener,
      builder: (context, state) {
        if (state is GetExamQuestionOrPercentageErrorState) {
          return const Scaffold(body: CustomErrorWidget());
        }
        if (state is GetExamQuestionOrPercentageLoadingState) {
          return const CustomLoadingScreen();
        }
        return Scaffold(
          appBar: widget.type == ExamType.homework
              ? _buildAppBarHomeWork(context)
              : CustomAppBarExam(
                  examModel: _examModel,
                  type: widget.type,
                ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ///  question image
                ImageQuestionWidget(
                  examQuestionImage: _examModel
                          ?.examQuestions?[_indexQuestion].examQuestionImage ??
                      '',
                ),
                const SizedBox(height: 15.0),

                /// answers button

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ValueListenableBuilder(
                    valueListenable: answerValue,
                    builder: (context, value, child) {
                      if (ExamQuestionType.MULTI.name ==
                              _examModel?.examQuestions?[_indexQuestion]
                                  .examQuestionType ||
                          ExamQuestionType.TORF.name ==
                              _examModel?.examQuestions?[_indexQuestion]
                                  .examQuestionType) {
                        return Column(
                          children: List.generate(
                            (_examModel?.examQuestions?[_indexQuestion]
                                        .examQuestionOptions ??
                                    [])
                                .length,
                            (index) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4.0),
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: value ==
                                          _examModel
                                              ?.examQuestions?[_indexQuestion]
                                              .examQuestionOptions?[index]
                                              .optionValue
                                      ? ColorManager.white
                                      : ColorManager.darkGrey,
                                  backgroundColor: value ==
                                          _examModel
                                              ?.examQuestions?[_indexQuestion]
                                              .examQuestionOptions?[index]
                                              .optionValue
                                      ? ColorManager.primary
                                      : null,
                                  side: const BorderSide(
                                      color: ColorManager.primary, width: 1.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  fixedSize: Size(context.width, 56.0),
                                ),
                                onPressed: () {
                                  answerValue.value = _examModel
                                      ?.examQuestions?[_indexQuestion]
                                      .examQuestionOptions?[index]
                                      .optionValue;
                                },
                                child: Text(_examModel
                                        ?.examQuestions?[_indexQuestion]
                                        .examQuestionOptions?[index]
                                        .option ??
                                    ''),
                              ),
                            ),
                          ),
                        );
                      }

                      if (ExamQuestionType.SORT.name ==
                          _examModel?.examQuestions?[_indexQuestion]
                              .examQuestionType) {
                        return ReorderableQuestion(
                          choices: _examModel?.examQuestions?[_indexQuestion]
                                  .examQuestionOptions ??
                              [],
                          onOrderChanged: (value) {
                            answerValue.value = value
                                .map((e) => e.optionValue)
                                .toList()
                                .join(',');
                          },
                        );
                      }
                      if (ExamQuestionType.LINK.name ==
                          _examModel?.examQuestions?[_indexQuestion]
                              .examQuestionType) {
                        return MatchingQuestion(
                          columnA: _examModel?.examQuestions?[_indexQuestion]
                                  .examLinkQuestionOptions?.optionsA ??
                              [],
                          columnB: _examModel?.examQuestions?[_indexQuestion]
                                  .examLinkQuestionOptions?.optionsB ??
                              [],
                          onMatchesChanged: (matches) {
                            String result = matches.entries
                                .map((entry) => '${entry.key}-${entry.value}')
                                .join(',');
                            answerValue.value = result;
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),

                const SizedBox(height: 6.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Visibility(
                        visible: (_indexQuestion > 0),
                        child: ElevatedButton(
                          onPressed: () {
                            if (_indexQuestion > 0) {
                              setState(() {
                                _indexQuestion -= 1;
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(context.width * 0.35, 50.0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                          ),
                          child: Text(AppStrings.previous.tr()),
                        ),
                      ),
                      SizedBox(
                        width: context.width * 0.35,
                        child: Visibility(
                          visible: _indexQuestion ==
                              (_examModel?.questionsCount ?? 0) - 1,

                          /// next Question
                          replacement: Center(
                            child: CustomButtonWithLoading(
                              onTap: () async {
                                await sl<ExamCubit>().get(context).saveAnswer(
                                    request: SaveAnswerRequest(
                                      type: widget.type,
                                      answer: answerValue.value,
                                      examQuestionId: _examModel
                                          ?.examQuestions?[_indexQuestion]
                                          .examQuestionId,
                                    ),
                                    type: widget.type);
                              },
                              height: 50.0,
                              width: context.width * 0.35,
                              text: AppStrings.next.tr(),
                            ),
                          ),

                          ///  finishing exam
                          child: CustomButtonWithLoading(
                            onTap: () async {
                              await sl<ExamCubit>().get(context).saveAnswer(
                                  request: SaveAnswerRequest(
                                    type: widget.type,
                                    answer: answerValue.value,
                                    examQuestionId: _examModel
                                        ?.examQuestions?[_indexQuestion]
                                        .examQuestionId,
                                  ),
                                  type: widget.type);
                            },
                            height: 50.0,
                            width: context.width * 0.35,
                            text: AppStrings.finishExam.tr(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 6.0),
              ],
            ),
          ),
        );
      },
    );
  }

  void _initListener(context, state) async {
    if (state is GetExamQuestionOrPercentageSuccessState) {
      _examModel = state.data;

      if (_examModel?.percentage != null) {
        MagicRouter.pop();

        QuickAlert.show(
          context: MagicRouter.currentContext!,
          type: QuickAlertType.success,
          title: '${AppStrings.examResult.tr()}\t ${state.data?.examName}',
          text:
              '${AppStrings.appreciation.tr()}: ${AppStrings.successful.tr()}\n\n , ${AppStrings.successRate.tr()}: ${state.data?.percentage}',
          borderRadius: AppSize.s8,
          widget: Column(children: [
            ElevatedButton(
                onPressed: () => MagicRouter.pop(),
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  backgroundColor: ColorManager.primary,
                  foregroundColor: ColorManager.white,
                ),
                child: Text(AppStrings.cancel.tr()))
          ]),
        ).then((value) => MagicRouter.pop());
      }

      for (int i = 0; i < (_examModel?.examQuestions ?? []).length; i++) {
        if (_examModel?.examQuestions?[i].binHere ?? false) {
          _indexQuestion = i;
          return;
        }
      }
    }

    if (state is SaveAnswerSuccessState) {
      ToastAndSnackBar.toastSuccess(message: state.response.message);

      _examModel?.examQuestions?[_indexQuestion].examQuestionAnswer =
          answerValue.value;
      if (_indexQuestion < (_examModel?.questionsCount ?? 0) - 1) {
        _indexQuestion += 1;
        answerValue.value = null;
      } else if (_indexQuestion == (_examModel?.questionsCount ?? 0) - 1) {
        _showAlertConfirmEndedExam(context);
      }
    }
    if (state is SaveAnswerErrorState) {
      ToastAndSnackBar.toastError(message: state.error);
    }
    if (state is EndExamSuccessState) {
      ToastAndSnackBar.showSnackBarWarning(
        context,
        title: AppStrings.endedExamTitle.tr(),
        message: AppStrings.endedExamMassage.tr(),
        durationMilliseconds: 5000,
      );
      await Future.delayed(const Duration(milliseconds: 6000), () {
        if (state.response.data!.isFail) {
          ToastAndSnackBar.showSnackBarFailure(
            context,
            title:
                '${AppStrings.examResult.tr()}\t ${state.response.data!.examName}',
            message:
                '${AppStrings.appreciation.tr()} : ${AppStrings.fail.tr()} \t , ${AppStrings.successRate.tr()}: ${state.response.data!.percentage}',
            // durationMilliseconds: 800,
          );
        } else {
          ToastAndSnackBar.showSnackBarSuccess(
            context,
            title:
                '${AppStrings.examResult.tr()}\t ${state.response.data!.examName}',
            message:
                '${AppStrings.appreciation.tr()}: ${AppStrings.successful.tr()}\t , ${AppStrings.successRate.tr()}: ${state.response.data!.percentage}',
            // durationMilliseconds: 800,
          );
        }
      });

      MagicRouterName.navigateAndPopUntilFirstPage(
        RoutesNames.examLayoutRoute,
        arguments: {
          'id': widget.id,
          'type': widget.type,
        },
      );
    }
  }

  void _showAlertConfirmEndedExam(BuildContext context) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.confirm,
      title: AppStrings.examCompleted.tr(),
      text: AppStrings.reviewYourAnswersBeforeFinishing.tr(),
      borderRadius: AppSize.s8,
      widget: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        // ElevatedButton(
        //     onPressed: () {
        //       MagicRouter.pop();
        //       setState(() {
        //         sl<ExamCubit>().get(context).getExamQuestionOrPercentage(examId: widget.id, type: widget.type);
        //         _indexQuestion = 0;
        //       });
        //     },
        //     child: Text(AppStrings.reviewAnswers.tr())),
        ElevatedButton(
            onPressed: () {
              sl<ExamCubit>().get(context).endExam(
                  studentExamId: '${_examModel?.studentExamId}',
                  type: widget.type);
              MagicRouter.pop();
            },
            style: ElevatedButton.styleFrom(
              elevation: 0.0,
              backgroundColor: ColorManager.white,
              foregroundColor: ColorManager.primary,
            ),
            child: Text(AppStrings.ending.tr()))
      ]),
    );
  }
}

class CustomAppBarExam extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarExam({
    super.key,
    required ExamModel? examModel,
    required this.type,
  }) : _examModel = examModel;

  final ExamModel? _examModel;
  final ExamType type;
  static const double _toolbarHeight = 70.0;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: _toolbarHeight,
      elevation: 0.5,
      centerTitle: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _examModel?.examName ?? '',
                style: context.bodyLarge
                    .copyWith(color: ColorManager.primary, fontSize: 22.0),
                textAlign: TextAlign.center,
              ),
              if (type == ExamType.exam) ...[
                const SizedBox(height: 10.0),
                Text('${AppStrings.examDuration.tr()} ${_examModel?.examTime} ',
                    style: context.displayMedium.copyWith(
                      color: ColorManager.textGray,
                    ),
                    textAlign: TextAlign.center),
              ]
            ],
          ),
          if (type == ExamType.exam)
            TweenAnimationBuilder<Duration>(
                duration: Duration(
                  milliseconds:
                      ((_examModel?.remainingExamTimeBySeconds ?? 0) * 1000 -
                              5000)
                          .toInt(),
                ),
                tween: Tween(
                    begin: Duration(
                      milliseconds:
                          ((_examModel?.remainingExamTimeBySeconds ?? 0) *
                                      1000 -
                                  5000)
                              .toInt(),
                    ),
                    end: Duration.zero),
                onEnd: () async {
                  if (type == ExamType.exam) {
                    debugPrint('Timer ended');
                    await ToastAndSnackBar.showSnackBarWarning(
                      context,
                      title: '',
                      message: AppStrings.examTimeIsUp.tr(),
                      durationMilliseconds: 5000,
                    );
                    await Future.delayed(const Duration(milliseconds: 5000),
                        () {
                      if (context.mounted) {
                        sl<ExamCubit>().get(context).endExam(
                            studentExamId: '${_examModel?.studentExamId}',
                            type: type);
                      }
                    });
                  }
                },
                builder: (BuildContext context, Duration value, Widget? child) {
                  final minutes = value.inMinutes;
                  final seconds = value.inSeconds % 60;
                  return SizedBox(
                    height: 45.0,
                    width: 130.0,
                    child: Card(
                      color: minutes <= 2
                          ? Colors.redAccent.shade200
                          : ColorManager.primary,
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                        child: DefaultTextStyle(
                          style: const TextStyle(
                            color: ColorManager.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 24,
                          ),
                          child: Text(
                            '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}',
                            softWrap: true,
                            textAlign: TextAlign.end,
                          ),
                        ),
                      ),
                    ),
                  );
                }),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(_toolbarHeight);

// void _showAlertEndedTimeExam(BuildContext context) {
//   QuickAlert.show(
//     context: context,
//     type: QuickAlertType.warning,
//     title: AppStrings.examCompleted.tr(),
//     text: AppStrings.reviewYourAnswersBeforeFinishing.tr(),
//     borderRadius: AppSize.s8,
//     widget: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//       ElevatedButton(
//           onPressed: () {
//             MagicRouter.pop();
//             setState(() {
//               _indexQuestion = 0;
//             });
//             MagicRouter.pop();
//           },
//           child: Text(AppStrings.reviewAnswers.tr())),
//       ElevatedButton(
//           onPressed: () {
//             sl<ExamCubit>()
//                 .get(context)
//                 .endExam('${_examModel
//                .studentExamId}');
//             MagicRouter.pop();
//           },
//           style: ElevatedButton.styleFrom(
//             elevation: 0.0,
//             backgroundColor: ColorManager.white,
//             foregroundColor: ColorManager.primary,
//           ),
//           child: Text(AppStrings.ending.tr()))
//     ]),
//   );
// }
}

class ImageQuestionWidget extends StatelessWidget {
  const ImageQuestionWidget({
    super.key,
    required this.examQuestionImage,
  });

  final String examQuestionImage;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        SizedBox(
          height: context.heightBody * 0.4,
          width: context.width,
          child: ClipRect(
            child: Hero(
              tag: "someTag",
              child: PhotoView(
                imageProvider: NetworkImage(examQuestionImage),
                gaplessPlayback: true,
                maxScale: PhotoViewComputedScale.covered * 2.0,
                minScale: PhotoViewComputedScale.contained * 0.8,
                initialScale: PhotoViewComputedScale.covered,
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 10.0,
          child: MaterialButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HeroPhotoViewRouteWrapper(
                      imageProvider: NetworkImage(examQuestionImage),
                    ),
                  ),
                );
              },
              color: ColorManager.primary,
              elevation: 5.0,
              shape: const CircleBorder(),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.fullscreen,
                  color: ColorManager.white,
                  size: 30.0,
                ),
              )),
        ),
      ],
    );
  }
}

class NewLineStep extends StatelessWidget {
  const NewLineStep({
    super.key,
    this.isActive = false,
    this.isFirst = false,
    this.isLast = false,
  });

  final bool isActive;
  final bool isFirst;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        height: 8,
        decoration: BoxDecoration(
          borderRadius: isFirst
              ? const BorderRadiusDirectional.horizontal(
                  start: Radius.circular(100.0))
              : isLast
                  ? const BorderRadiusDirectional.horizontal(
                      end: Radius.circular(100.0))
                  : BorderRadius.circular(0.0),
          color: isActive ? ColorManager.primary : Colors.grey[300],
        ),
      ),
      // child: Container(
      //   height: 10.0,
      //   decoration: BoxDecoration(
      //     borderRadius: BorderRadius.circular(10.0),
      //   ),
      //   child: Divider(
      //     height: 10.0,
      //     color: isActive ? ColorManager.primary : Colors.grey[300],
      //     thickness: 8,
      //   ),
      // ),
    );
  }
}

class DividerWidget extends StatelessWidget {
  const DividerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: Colors.red,
      ),
    );
  }
}

class AnswerButtonWidget extends StatelessWidget {
  final void Function()? onPressed;
  final bool isSelectedAnswer;

  final String text;

  const AnswerButtonWidget(
      {super.key,
      required this.onPressed,
      required this.isSelectedAnswer,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: const Size.fromHeight(50.0),
        backgroundColor:
            isSelectedAnswer ? ColorManager.primary : ColorManager.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
            side: const BorderSide(
              color: ColorManager.primary,
              width: 1.5,
            )),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            text,
            style: context.labelLarge.copyWith(
                color: ColorManager.primary, fontWeight: FontWeight.w700),
          ),
          const Spacer(),
          if (isSelectedAnswer)
            Icon(
              Icons.check_circle_sharp,
              color: Colors.green[700],
              size: 30.0,
            )
        ],
      ),
    );
  }
}

class HeroPhotoViewRouteWrapper extends StatelessWidget {
  final ImageProvider imageProvider;
  final BoxDecoration? backgroundDecoration;
  final dynamic minScale;
  final dynamic maxScale;

  const HeroPhotoViewRouteWrapper(
      {super.key,
      required this.imageProvider,
      this.backgroundDecoration,
      this.minScale,
      this.maxScale});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: MediaQuery.of(context).size.height,
      ),
      child: PhotoView(
        imageProvider: imageProvider,
        backgroundDecoration: backgroundDecoration,
        minScale: minScale,
        maxScale: maxScale,
        heroAttributes: const PhotoViewHeroAttributes(tag: "someTag"),
      ),
    );
  }
}

class InteractiveImage extends StatefulWidget {
  const InteractiveImage(this.image, {super.key});

  final Image image;

  @override
  State createState() => _InteractiveImageState();
}

class _InteractiveImageState extends State<InteractiveImage> {
  _InteractiveImageState();

  double _scale = 1.0;
  double _previousScale = 0.0;

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return GestureDetector(
      onScaleStart: (ScaleStartDetails details) {
        // Does this need to go into setState, too?
        // We are only saving the scale from before the zooming started
        // for later - this does not affect the rendering...
        _previousScale = _scale;
      },
      onScaleUpdate: (ScaleUpdateDetails details) {
        setState(() => _scale = _previousScale * details.scale);
      },
      onScaleEnd: (ScaleEndDetails details) {
        // See comment above
        _previousScale = 0.0;
      },
      child: SizedBox(
        height: 200,
        child: Transform(
          transform: Matrix4.diagonal3(vector.Vector3(_scale, _scale, _scale)),
          alignment: FractionalOffset.center,
          child: widget.image,
        ),
      ),
    );
  }
}

class ReorderableQuestion extends StatefulWidget {
  final List<ExamQuestionOption> choices;
  final Function(List<ExamQuestionOption>) onOrderChanged;

  const ReorderableQuestion({
    super.key,
    required this.choices,
    required this.onOrderChanged,
  });

  @override
  State<ReorderableQuestion> createState() => _ReorderableQuestionState();
}

class _ReorderableQuestionState extends State<ReorderableQuestion> {
  late List<ExamQuestionOption> _items;

  @override
  void initState() {
    super.initState();
    _items = List.from(widget.choices);
  }

  @override
  Widget build(BuildContext context) {
    return ReorderableListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _items.length,
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }
          final item = _items.removeAt(oldIndex);
          _items.insert(newIndex, item);
          widget.onOrderChanged(_items);
        });
      },
      itemBuilder: (context, index) {
        return Card(
          key: ValueKey(_items[index]),
          elevation: 0.0,
          color: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
            side: const BorderSide(color: ColorManager.primary),
          ),
          margin: const EdgeInsets.symmetric(vertical: 4),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: ColorManager.white,
              foregroundColor: ColorManager.primary,
              child: Center(child: Text('${index + 1}')),
            ),
            title: Text(_items[index].option ?? ''),
            trailing: const Icon(Icons.drag_handle),
          ),
        );
      },
    );
  }
}

class MatchingQuestion extends StatefulWidget {
  final List<ExamQuestionOption> columnA;
  final List<ExamQuestionOption> columnB;
  final Function(Map<String, String?>) onMatchesChanged;

  const MatchingQuestion({
    super.key,
    required this.columnA,
    required this.columnB,
    required this.onMatchesChanged,
  });

  @override
  State<MatchingQuestion> createState() => _MatchingQuestionState();
}

class _MatchingQuestionState extends State<MatchingQuestion> {
  Map<String, String?> matches = {};
  String? selectedFromA;

  @override
  void initState() {
    super.initState();
    for (var element in widget.columnA) {
      if (element.optionValue != null) {
        matches.addEntries({element.optionValue!: null}.entries);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            // Column A
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'العمود أ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ...List.generate(
                    widget.columnA.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: selectedFromA ==
                                      widget.columnA[index].optionValue ||
                                  matches[widget.columnA[index].optionValue] !=
                                      null
                              ? Colors.green
                              : null,
                          foregroundColor: matches.containsKey(
                                  widget.columnA[index].optionValue)
                              ? Colors.white
                              : null,
                        ),
                        onPressed: () {
                          setState(() {
                            selectedFromA = widget.columnA[index].optionValue;
                          });
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                                '${widget.columnA[index].optionValue}- ${widget.columnA[index].option}'),
                            const SizedBox(width: AppPadding.p4),
                            matches[widget.columnA[index].optionValue] != null
                                ? Container(
                                    padding:
                                        const EdgeInsets.all(AppPadding.p4),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.rectangle,
                                      borderRadius:
                                          BorderRadius.circular(AppPadding.p4),
                                      color: Colors.green,
                                    ),
                                    child: Center(
                                        child: Text(matches[widget
                                                .columnA[index].optionValue] ??
                                            '')),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Column B
            Expanded(
              child: Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'العمود ب',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  ...List.generate(
                    widget.columnB.length,
                    (index) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: matches.containsValue(
                                  widget.columnB[index].optionValue)
                              ? Colors.green
                              : null,
                          foregroundColor: matches.containsValue(
                                  widget.columnB[index].optionValue)
                              ? Colors.white
                              : null,
                          disabledBackgroundColor: matches.containsValue(
                                  widget.columnB[index].optionValue)
                              ? Colors.green
                              : null,
                        ),
                        onPressed: selectedFromA != null
                            ? () {
                                setState(() {
                                  matches[selectedFromA!] =
                                      widget.columnB[index].optionValue ?? '';
                                  selectedFromA = null;
                                  widget.onMatchesChanged(matches);
                                });
                              }
                            : null,
                        child: Text(
                            '${widget.columnB[index].optionValue}-  ${widget.columnB[index].option} '),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
