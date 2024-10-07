import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_symbols_icons/symbols.dart';

Future showHomeMenu(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.2),
    context: context,
    builder: (context) => Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: basicBoxStyle(borderRadius: 18),
        // color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 42),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Menu(context, Symbols.map, "지도", null, goBack: true),
                  _Menu(context, Symbols.explore, "여행", null),
                  _Menu(context, Symbols.person, "마이", null),
                  _Menu(context, Symbols.settings, "설정", null),
                ],
              ),
            ),
          ],
        ),
      ),
    )
  );
}

Widget _Menu(BuildContext context, IconData icon, String text, dynamic screen, {bool goBack = false}) {
  return Container(
    child: GestureDetector(
      onTap: (){
        if (screen != null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
        } else {
          if (goBack) {
            Navigator.pop(context);
          } else {
            Fluttertoast.showToast(msg: "향후 개발 예정입니다.");
          }
        }
      },
      child: Column(
        children: [
          Icon(icon, size: 32,),
          const SizedBox(height: 6),
          Text(text, style: const TextStyle(fontSize: 17), textAlign: TextAlign.center,)
        ],
      ),
    ),
  );
}