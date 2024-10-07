import 'package:flutter/material.dart';

Color softBlack = const Color(0xFF49454F);
Color iconBlack = const Color(0xFF1C1B1F);
Color textBlack = const Color(0xFF202124);
Color softGrey = const Color(0xFF79747E);
Color primaryColor = const Color(0xFF65558f);

String redMarkerImgUrl = "https://durume.s3.ap-southeast-2.amazonaws.com/search.png";
String favoriteMarkerImgUrl = "https://durume.s3.ap-southeast-2.amazonaws.com/favorite.png";

BoxDecoration basicBoxStyle({double borderRadius = 50, bool borderDirectional = false}) {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: borderDirectional ?
        BorderRadiusDirectional.vertical(top: Radius.circular(borderRadius))
        : BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.8),
            spreadRadius: 0,
            blurRadius: 5.0,
            offset: const Offset(0, 3)
        )
      ]
  );
}