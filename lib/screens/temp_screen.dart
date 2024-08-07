import 'package:flutter/material.dart';

class TempScreen extends StatelessWidget {
  const TempScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 200,),
          Text("임시페이지"),
        ],
      ),
    );
  }
}
