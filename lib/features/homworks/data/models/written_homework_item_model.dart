class WrittenHomeworkItemModel {
  final int? id;
  final String? name;
  final String? link;

  WrittenHomeworkItemModel({
    this.id,
    this.name,
    this.link,
  });

  factory WrittenHomeworkItemModel.fromJson(Map<String, dynamic> json) =>
      WrittenHomeworkItemModel(
        id: json["id"],
        name: json["name"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "link": link,
      };
}
