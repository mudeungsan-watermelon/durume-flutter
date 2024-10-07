import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

Widget ReviewOverView() {
  return Row(
    children: [
      Row(
        children: [
          Icon(Symbols.kid_star, fill: 1, color: primaryColor, size: 20,),
          const SizedBox(width: 6,),
          Text("4.48", style: TextStyle(fontSize: 16, color: textBlack),),
        ],
      ),
      const SizedBox(width: 8,),
      Text("·", style: TextStyle(fontSize: 16, color: textBlack),),
      const SizedBox(width: 8,),
      Text("리뷰 12개", style: TextStyle(fontSize: 16, color: textBlack),)
    ],
  );
}

Widget CustomDragHandle = Padding(
  padding: const EdgeInsets.symmetric(vertical: 16),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
            color: softGrey,
            borderRadius: BorderRadius.circular(100)
        ),
      )
    ],
  ),
);
