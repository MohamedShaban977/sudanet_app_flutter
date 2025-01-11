class ErrorUnauthorizedResponse {
  ErrorUnauthorizedResponse({
    this.detail,
  });

  final String? detail;

  factory ErrorUnauthorizedResponse.fromJson(Map<String, dynamic> json) =>
      ErrorUnauthorizedResponse(
        detail: json["detail"],
      );
}

class ErrorBadRequestResponse {
  final String? type;
  final String? title;
  final int? status;
  final String? traceId;
  final Errors? errors;

  ErrorBadRequestResponse({
    this.type,
    this.title,
    this.status,
    this.traceId,
    this.errors,
  });

  factory ErrorBadRequestResponse.fromJson(Map<String, dynamic> json) =>
      ErrorBadRequestResponse(
        type: json["type"],
        title: json["title"],
        status: json["status"],
        traceId: json["traceId"],
        errors: json["errors"] == null ? null : Errors.fromJson(json["errors"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "title": title,
        "status": status,
        "traceId": traceId,
        "errors": errors?.toJson(),
      };
}

class Errors {
  final List<String>? name;

  Errors({
    this.name,
  });

  factory Errors.fromJson(Map<String, dynamic> json) => Errors(
        name: json["Name"] == null
            ? []
            : List<String>.from(json["Name"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "Name": name == null ? [] : List<dynamic>.from(name!.map((x) => x)),
      };
}
