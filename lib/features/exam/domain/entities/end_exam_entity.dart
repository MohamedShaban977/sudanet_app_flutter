import 'package:equatable/equatable.dart';

// {
// "examName": "أمتحان الحصة الثانية",
// "isFail": true,
// "percentage": "0%"
// }
class EndExamEntity extends Equatable {
  final String examName;
  final bool isFail;
  final String percentage;

  const EndExamEntity(
      {required this.examName, required this.isFail, required this.percentage});

  @override
  List<Object?> get props => [examName, isFail, percentage];
}
