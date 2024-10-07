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
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.settings)
            ],
          ),
          Container(
            child: const Text("프로필"),
          ),
          const DrawerContent(text: "즐겨찾기"),
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

