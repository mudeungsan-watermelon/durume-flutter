import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  VoidCallback closeDrawer;

  CustomDrawer({
    super.key,
    required this.closeDrawer
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 200,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.settings)
            ],
          ),
          Container(
            child: Text("프로필"),
          ),
          DrawerContent(text: "즐겨찾기"),
          DrawerContent(text: "추천 스폿"),
          DrawerContent(text: "내가 쓴 리뷰"),
          DrawerContent(text: "두루, 광주"),
          DrawerContent(text: "이벤트"),
        ],
      ),
    );
  }
}

class DrawerContent extends StatelessWidget {
  final String text;

  const DrawerContent({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Text(text),
    );
  }
}

