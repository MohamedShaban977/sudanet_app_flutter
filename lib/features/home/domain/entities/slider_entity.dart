/*
{
"imgPath": "https://suda-net.com/Upload/68539524202394222PMPicture5.jpg",
"link": "https://www.youtube.com/results?search_query=VCard+php"
}*/

import 'package:equatable/equatable.dart';

class SliderEntity extends Equatable {
  final String imagePath;
  final String link;

  const SliderEntity({required this.imagePath, required this.link});

  @override
  List<Object?> get props => [imagePath, link];
}
