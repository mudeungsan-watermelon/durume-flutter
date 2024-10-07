import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';

Widget SmallRoundedBtn({String text = "", bool isFilled = false, void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          color: isFilled ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: isFilled ? primaryColor : softGrey)
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Text(text, style: TextStyle(color: isFilled ? Colors.white : primaryColor),),
      ),
    ),
  );
}