import 'package:flutter/material.dart';

double widthRatio(context) => MediaQuery.of(context).size.width / 375;
double heightRatio(context) => MediaQuery.of(context).size.height / 812;

Color softBlack = const Color(0xFF49454F);
Color iconBlack = const Color(0xFF1C1B1F);
Color textBlack = const Color(0xFF202124);
Color softGrey = const Color(0xFF79747E);
Color primaryColor = const Color(0xFF65558f);

String redMarkerImgUrl = "https://github.com/mudeungsan-watermelon/durume-flutter/blob/develop_yeji/assets/image/location_on.png?raw=true";

BoxDecoration basicBoxStyle({double borderRadius = 50, bool borderDirectional = false}) {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: borderDirectional ?
        BorderRadiusDirectional.vertical(top: Radius.circular(borderRadius))
        : BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 0,
            blurRadius: 5.0,
            offset: Offset(0, 3)
        )
      ]
  );
}