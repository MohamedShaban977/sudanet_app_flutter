
class ExamsBySubjectItemModel {
  final int? id;
  final String? name;
  final int? questionCount;
  final int? time;
  final String? dateFrom;
  final String? dateTo;

  ExamsBySubjectItemModel({
    this.id,
    this.name,
    this.questionCount,
    this.time,
    this.dateFrom,
    this.dateTo,
  });

  factory ExamsBySubjectItemModel.fromJson(Map<String, dynamic> json) => ExamsBySubjectItemModel(
    id: json["id"],
    name: json["name"],
    questionCount: json["questionCount"],
    time: json["time"],
    dateFrom: json["dateFrom"],
    dateTo: json["dateTo"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "questionCount": questionCount,
    "time": time,
    "dateFrom": dateFrom,
    "dateTo": dateTo,
  };
}
