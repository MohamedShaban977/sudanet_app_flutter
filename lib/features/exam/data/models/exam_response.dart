class ExamModel {
  final int? studentExamId;
  final String? examTime;
  final int? remainingExamTimeBySeconds;
  final String? examName;
  final int? questionsCount;
  final List<ExamQuestion>? examQuestions;
  final dynamic percentage;

  ExamModel({
    this.studentExamId,
    this.examTime,
    this.remainingExamTimeBySeconds,
    this.examName,
    this.questionsCount,
    this.examQuestions,
    this.percentage,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        studentExamId: json["studentExamId"],
        examTime: json["examTime"],
        remainingExamTimeBySeconds: json["remainingExamTimeBySeconds"],
        examName: json["examName"],
        questionsCount: json["questionsCount"],
        examQuestions: json["examQuestions"] == null
            ? []
            : List<ExamQuestion>.from(json["examQuestions"]!.map((x) => ExamQuestion.fromJson(x))),
        percentage: json["percentage"],
      );

  Map<String, dynamic> toJson() => {
        "studentExamId": studentExamId,
        "examTime": examTime,
        "remainingExamTimeBySeconds": remainingExamTimeBySeconds,
        "examName": examName,
        "questionsCount": questionsCount,
        "examQuestions": examQuestions == null ? [] : List<dynamic>.from(examQuestions!.map((x) => x.toJson())),
        "percentage": percentage,
      };
}

class ExamQuestion {
  final int? examQuestionId;
  final String? examQuestionType;
  final String? examQuestionImage;
  final List<ExamQuestionOption>? examQuestionOptions;
  final ExamLinkQuestionOptions? examLinkQuestionOptions;
  String? examQuestionAnswer;
  final bool? binHere;

  ExamQuestion({
    this.examQuestionId,
    this.examQuestionType,
    this.examQuestionImage,
    this.examQuestionOptions,
    this.examLinkQuestionOptions,
    this.examQuestionAnswer,
    this.binHere,
  });

  factory ExamQuestion.fromJson(Map<String, dynamic> json) => ExamQuestion(
        examQuestionId: json["examQuestionId"],
        examQuestionType: json["examQuestionType"],
        examQuestionImage: json["examQuestionImage"],
        examQuestionOptions: json["examQuestionOptions"] == null
            ? []
            : List<ExamQuestionOption>.from(json["examQuestionOptions"]!.map((x) => ExamQuestionOption.fromJson(x))),
        examLinkQuestionOptions: json["examLinkQuestionOptions"] == null
            ? null
            : ExamLinkQuestionOptions.fromJson(json["examLinkQuestionOptions"]),
        examQuestionAnswer: json["examQuestionAnswer"],
        binHere: json["binHere"],
      );

  Map<String, dynamic> toJson() => {
        "examQuestionId": examQuestionId,
        "examQuestionType": examQuestionType,
        "examQuestionImage": examQuestionImage,
        "examQuestionOptions":
            examQuestionOptions == null ? [] : List<dynamic>.from(examQuestionOptions!.map((x) => x.toJson())),
        "examLinkQuestionOptions": examLinkQuestionOptions?.toJson(),
        "examQuestionAnswer": examQuestionAnswer,
        "binHere": binHere,
      };
}

class ExamLinkQuestionOptions {
  final List<ExamQuestionOption>? optionsA;
  final List<ExamQuestionOption>? optionsB;

  ExamLinkQuestionOptions({
    this.optionsA,
    this.optionsB,
  });

  factory ExamLinkQuestionOptions.fromJson(Map<String, dynamic> json) => ExamLinkQuestionOptions(
        optionsA: json["optionsA"] == null
            ? []
            : List<ExamQuestionOption>.from(json["optionsA"]!.map((x) => ExamQuestionOption.fromJson(x))),
        optionsB: json["optionsB"] == null
            ? []
            : List<ExamQuestionOption>.from(json["optionsB"]!.map((x) => ExamQuestionOption.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "optionsA": optionsA == null ? [] : List<dynamic>.from(optionsA!.map((x) => x.toJson())),
        "optionsB": optionsB == null ? [] : List<dynamic>.from(optionsB!.map((x) => x.toJson())),
      };
}

class ExamQuestionOption {
  final String? option;
  final String? optionValue;

  ExamQuestionOption({
    this.option,
    this.optionValue,
  });

  factory ExamQuestionOption.fromJson(Map<String, dynamic> json) => ExamQuestionOption(
        option: json["option"],
        optionValue: json["optionValue"],
      );

  Map<String, dynamic> toJson() => {
        "option": option,
        "optionValue": optionValue,
      };
}
