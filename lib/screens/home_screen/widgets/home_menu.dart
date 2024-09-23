import 'package:durume_flutter/screens/my_screen/my_screen.dart';
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
      padding: EdgeInsets.all(16),
      child: Container(
        decoration: basicBoxStyle(borderRadius: 18),
        // color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 35, horizontal: 42),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Menu(context, Symbols.map, "지도", TempScreen()),
                  _Menu(context, Symbols.explore, "여행", TempScreen()),
                  _Menu(context, Symbols.person, "마이", MyScreen()),
                  _Menu(context, Symbols.settings, "설정", TempScreen()),
                ],
              ),
            ),
          ],
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
          Icon(icon, size: 32,),
          SizedBox(height: 6),
          Text(text, style: TextStyle(fontSize: 17), textAlign: TextAlign.center,)
        ],
      ),
    ),
  );
}