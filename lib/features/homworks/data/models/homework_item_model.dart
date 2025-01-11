class HomeworkItemModel {
  final int? id;
  final String? name;
  final int? questionCount;

  HomeworkItemModel({
    this.id,
    this.name,
    this.questionCount,
  });

  factory HomeworkItemModel.fromJson(Map<String, dynamic> json) => HomeworkItemModel(
        id: json["id"],
        name: json["name"],
        questionCount: json["questionCount"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "questionCount": questionCount,
      };
}
