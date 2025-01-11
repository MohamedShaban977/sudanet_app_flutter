class RouteRequest {
  RouteRequest({
    this.id,
  });

  final String? id;

  factory RouteRequest.fromJson(Map<String, dynamic> json) => RouteRequest(
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
      };
}
