import 'package:durume_flutter/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  VoidCallback openDrawer;

  HomeSearchBar({
    super.key,
    required this.openDrawer
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 8, 0),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.grey,
          ),
          height: double.infinity,
          child: Row(
            children: [
              GestureDetector(
                  onTap: openDrawer,
                  child: const Icon(Icons.menu)
              ),
              Container(
                child: TextButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                  },
                  child: Text("검색창"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}