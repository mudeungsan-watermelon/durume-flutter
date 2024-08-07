import 'package:durume_flutter/screens/temp_screen.dart';
import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

Future showHomeMenu(BuildContext context) {
  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    barrierColor: Colors.black.withOpacity(0.2),
    context: context,
    builder: (context) => Padding(
      padding: EdgeInsets.all(16*heightRatio(context)),
      child: Container(
        decoration: basicBoxStyle(borderRadius: 18),
        // color: Colors.white,
        height: 120*heightRatio(context),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 28*heightRatio(context), horizontal: 30*heightRatio(context)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Menu(context, Symbols.cognition, "AI 검색", TempScreen()),
              _Menu(context, Symbols.favorite, "즐겨찾기", TempScreen()),
              _Menu(context, Symbols.assignment, "공지사항", TempScreen()),
              _Menu(context, Symbols.settings, "설정", TempScreen()),
            ],
          ),
        ),
      ),
    )
  );
}

Widget _Menu(BuildContext context, IconData icon, String text, dynamic screen) {
  return Container(
    child: GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => screen));
      },
      child: Column(
        children: [
          Icon(icon, size: 30,),
          SizedBox(height: 6),
          Text(text, style: TextStyle(fontSize: 12), textAlign: TextAlign.center,)
        ],
      ),
    ),
  );
}