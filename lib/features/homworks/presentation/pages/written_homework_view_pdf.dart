import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:sudanet_app_flutter/features/homworks/data/models/written_homework_item_model.dart';
import 'package:sudanet_app_flutter/widgets/screenshot_prevention_widget.dart';

class WrittenHomeworkViewPdf extends StatelessWidget {
  final WrittenHomeworkItemModel writtenHomework;

  const WrittenHomeworkViewPdf({super.key, required this.writtenHomework});
  @override
  Widget build(BuildContext context) {
    return ScreenshotPreventionWidget(
      child: Scaffold(
          appBar: AppBar(
            title: Text(writtenHomework.name ?? ''),
          ),
          body: PDF().cachedFromUrl(
            writtenHomework.link ?? '',
            placeholder: (progress) => Center(child: Text('$progress %')),
            errorWidget: (error) => Center(child: Text(error.toString())),
          )),
    );
  }
}
