
import 'package:sudanet_app_flutter/core/app_manage/extension_manager.dart';

import '../../domain/entities/contact_info_entity.dart';

class ContactInfoResponse extends ContactInfoEntity {
  ContactInfoResponse({
    final String? phone1,
    final String? phone2,
    final String? phone3,
    final String? whatsapp1,
    final String? whatsapp2,
    final String? whatsapp3,
    final String? mail1,
    final String? mail2,
    final String? mail3,
    final String? facebookLink,
    final String? twitterLink,
    final String? instegramLink,
    final String? youtubeLink,
    final String? about,
    final String? terms,
  }) : super(
          phone1: phone1.orEmpty(),
          phone2: phone2.orEmpty(),
          phone3: phone3.orEmpty(),
          whatsapp1: whatsapp1.orEmpty(),
          whatsapp2: whatsapp2.orEmpty(),
          whatsapp3: whatsapp3.orEmpty(),
          mail1: mail1.orEmpty(),
          mail2: mail2.orEmpty(),
          mail3: mail3.orEmpty(),
          facebookLink: facebookLink.orEmpty(),
          twitterLink: twitterLink.orEmpty(),
          instegramLink: instegramLink.orEmpty(),
          youtubeLink: youtubeLink.orEmpty(),
          about: about.orEmpty(),
          terms: terms.orEmpty(),
        );

  factory ContactInfoResponse.fromJson(Map<String, dynamic> json) =>
      ContactInfoResponse(
        phone1: json["phone1"],
        phone2: json["phone2"],
        phone3: json["phone3"],
        whatsapp1: json["whatsapp1"],
        whatsapp2: json["whatsapp2"],
        whatsapp3: json["whatsapp3"],
        mail1: json["mail1"],
        mail2: json["mail2"],
        mail3: json["mail3"],
        facebookLink: json["facebookLink"],
        twitterLink: json["twitterLink"],
        instegramLink: json["instegramLink"],
        youtubeLink: json["youtubeLink"],
        about: json["about"],
        terms: json["terms"],
      );
}
