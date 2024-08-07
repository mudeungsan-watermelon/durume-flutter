import 'package:flutter/material.dart';

double widthRatio(context) => MediaQuery.of(context).size.width / 375;
double heightRatio(context) => MediaQuery.of(context).size.height / 812;

Color softBlack = const Color(0xFF49454F);
Color iconBlack = const Color(0xFF1C1B1F);

// BoxDecoration basicBoxStyle = BoxDecoration(
//     color: Colors.white,
//     borderRadius: BorderRadius.circular(50),
//     boxShadow: [
//       BoxShadow(
//           color: Colors.grey.withOpacity(0.3),
//           spreadRadius: 0,
//           blurRadius: 5.0,
//           offset: Offset(0, 3)
//       )
//     ]
// );

BoxDecoration basicBoxStyle({double borderRadius = 50}) {
  return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(borderRadius),
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