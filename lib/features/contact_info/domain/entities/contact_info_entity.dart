/*{
        "phone1": "01222222",
        "phone2": "01222222",
        "phone3": "01222222",
        "whatsapp1": "01222222",
        "whatsapp2": "01222222",
        "whatsapp3": "01222222",
        "mail1": "m@m.com",
        "mail2": "m@m.com",
        "mail3": "m@m.com",
        "facebookLink": "#",
        "twitterLink": "#",
        "instegramLink": "#",
        "youtubeLink": "#",
        "about": " ",
        "terms": " "
    },*/
import 'package:equatable/equatable.dart';

class ContactInfoEntity extends Equatable {
  final String phone1;
  final String phone2;
  final String phone3;
  final String whatsapp1;
  final String whatsapp2;
  final String whatsapp3;
  final String mail1;
  final String mail2;
  final String mail3;
  final String facebookLink;
  final String twitterLink;
  final String instegramLink;
  final String youtubeLink;
  final String about;
  final String terms;

  const ContactInfoEntity(
      {required this.phone1,
      required this.phone2,
      required this.phone3,
      required this.whatsapp1,
      required this.whatsapp2,
      required this.whatsapp3,
      required this.mail1,
      required this.mail2,
      required this.mail3,
      required this.facebookLink,
      required this.twitterLink,
      required this.instegramLink,
      required this.youtubeLink,
      required this.about,
      required this.terms});

  @override
  List<Object?> get props => [
        phone1,
        phone2,
        phone3,
        whatsapp1,
        whatsapp2,
        whatsapp3,
        mail1,
        mail2,
        mail3,
        facebookLink,
        twitterLink,
        instegramLink,
        youtubeLink
      ];
}
