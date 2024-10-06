import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/gemini_model_utils.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

Widget BarrierFreeMainCategory({String text = "", IconData icon = Symbols.accessible_forward, bool isFirst = false}) {
  return Padding(
    padding: EdgeInsets.only(top: isFirst ? 4 : 30, bottom: 0),
    child: Row(
      children: [
        Icon(icon, size: 24),
        SizedBox(width: 8,),
        Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
      ],
    ),
  );
}

Widget BarrierFreeSubCategory(String category, String? content) {
  return hasNoValue(content) ? Container() :
  Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, color: softGrey),
        ),
        SizedBox(height: 2,),
        BarrierFreeContent(content: content!)
      ],
    ),
  );
}

Widget BarrierFreeContent({String? content, bool isLoading = false}) {
  if (isLoading) {
    return Text(
      "정보 불러오는 중",
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 18, color: softGrey),
    );
  } else {
    if (hasNoValue(content)) {
      return Text("정보 없음", textAlign: TextAlign.left, style: TextStyle(fontSize: 18, color: softGrey),);
    }
    return Text(content!, textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),);
  }
}

Widget BarrierFreeInfoModal(void Function()? onTap) {
  return Positioned(
      top: 22,
      left: 100,
      child: Container(
        width: 230,
        decoration: BoxDecoration(
            color: const Color(0xffededed),
            borderRadius: const BorderRadius.only(
                topRight:  Radius.circular(8),
                bottomLeft:  Radius.circular(8),
                bottomRight:  Radius.circular(8)
            ),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.8),
                  spreadRadius: 0,
                  blurRadius: 5.0,
                  offset: const Offset(0, 3)
              )
            ]
        ),
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 16, bottom: 16, right: 16),
              child: Text(barrierFreeInfoModalText, style: TextStyle(fontSize: 14),),
            ),
            Positioned(
                top: 10,
                right: 10,
                child: GestureDetector(
                  onTap: onTap,
                  child: Icon(Symbols.clear, size: 18, color: softGrey,),
                )
            )
          ],
        ),
      )
  );
}

bool hasNoValue(String? info) {
  if (info == null || info == "" || info == "없음") return true;
  return false;
}