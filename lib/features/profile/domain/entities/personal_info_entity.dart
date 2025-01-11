import 'package:equatable/equatable.dart';

/*
{
"name": "Moamen Mostafa",
"parentPhone": "07277337623",
"email": "m@m.com",
"phoneNumber": "01277337624"
}*/
class PersonInfoEntity extends Equatable {
  final String name;
  final String email;
  final String phoneNumber;
  final String parentPhone;

  const PersonInfoEntity({
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.parentPhone,
  });

  @override
  List<Object?> get props => [
        name,
        email,
        phoneNumber,
        parentPhone,
      ];
}
