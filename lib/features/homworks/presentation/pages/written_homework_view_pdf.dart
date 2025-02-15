import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import 'package:sudanet_app_flutter/features/homworks/data/models/written_homework_item_model.dart';
import 'package:sudanet_app_flutter/widgets/custom_app_bar_widget.dart';

class WrittenHomeworkViewPdf extends StatelessWidget {
  final WrittenHomeworkItemModel writtenHomework;

  const WrittenHomeworkViewPdf({super.key, required this.writtenHomework});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarWidget(
        title: writtenHomework.name ?? '',
      ),
      body: PDF().fromUrl(
        writtenHomework.link ?? '',
        placeholder: (progress) => Center(
          child: Text(
            '$progress %',
            style: context.bodySmall,
          ),
        ),
        errorWidget: (error) => Center(
          child: Text(
            error.toString(),
          ),
        ),
      ),
    );
  }
}
