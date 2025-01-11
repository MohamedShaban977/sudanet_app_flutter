class BuyCourseRequest {
  final String courseId;
  final String courseCode;

  BuyCourseRequest({
    required this.courseId,
    required this.courseCode,
  });

  Map<String, dynamic> toJson() => {
        "CourseId": courseId,
        "CourseCode": courseCode,
      };
}
