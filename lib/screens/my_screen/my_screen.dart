import 'package:flutter/material.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {

            },
            child: Image.asset(
              "assets/images/kakao_login_medium_narrow.png"
            ),
          )
        ],
      ),
    );
  }
}
