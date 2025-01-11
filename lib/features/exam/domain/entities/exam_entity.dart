/*
{
"studentExamId": 11,
        "examTime": "10 دقائق ",
        "remainingExamTimeBySeconds": 600,
"examName": "أمتحان الحصة الثانية",
"questionsCount": 2,
"examQuestions": [
{
"examQuestionId": 21,
"examQuestionImage": "https://suda-net.com/Upload/6742722202354653AMWhatsAppImage2023-06-06at11.39.11PM.jpeg",
"examQuestionAnswer": 0,
"binHere": true
}
],
"percentage": null
}*/

import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ExamEntity extends Equatable {
  final int studentExamId;

  final String examTime;
  final int remainingExamTimeBySeconds;

  final int questionsCount;

  final String examName;

  final String? percentage;
  final List<ExamQuestionsEntity> examQuestions;

  const ExamEntity({
    required this.studentExamId,
    required this.examTime,
    required this.remainingExamTimeBySeconds,
    required this.questionsCount,
    required this.examName,
    required this.percentage,
    required this.examQuestions,
  });

  @override
  List<Object?> get props => [
        studentExamId,
        examTime,
        remainingExamTimeBySeconds,
        questionsCount,
        examName,
        percentage,
        examQuestions,
      ];
}

/*{
"examQuestionId": 21,
"examQuestionImage": "https://suda-net.com/Upload/6742722202354653AMWhatsAppImage2023-06-06at11.39.11PM.jpeg",
"examQuestionAnswer": 0,
"binHere": true
}*/
class ExamQuestionsEntity {
  final int examQuestionId;
  int? examQuestionAnswer;
  final String examQuestionImage;
  final bool binHere;

  ExamQuestionsEntity(
      {required this.examQuestionId,
      required this.examQuestionAnswer,
      required this.examQuestionImage,
      required this.binHere});

  // @override
  // List<Object?> get props => [
  //       examQuestionId,
  //       examQuestionImage,
  //       binHere,
  //       examQuestionAnswer,
  //     ];

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    if (kDebugMode) {
      log(other.toString());
    }
    return other is ExamQuestionsEntity &&
        other.examQuestionId == examQuestionId &&
        other.examQuestionImage == examQuestionImage &&
        other.binHere == binHere;
  }

  @override
  int get hashCode =>
      examQuestionId.hashCode ^ examQuestionImage.hashCode ^ binHere.hashCode;

  @override
  String toString() {
    return 'ExamQuestionsEntity: ( examQuestionId: $examQuestionId, examQuestionImage: $examQuestionImage, binHere:$binHere, examQuestionAnswer: $examQuestionAnswer )';
  }
}
