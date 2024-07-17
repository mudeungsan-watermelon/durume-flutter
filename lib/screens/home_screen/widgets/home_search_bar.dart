import 'package:durume_flutter/screens/search_screen/search_screen.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_view.dart';
import 'package:durume_flutter/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatefulWidget {
  VoidCallback openDrawer;

  HomeSearchBar({
    super.key,
    required this.openDrawer,
  });

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {

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
                  onTap: widget.openDrawer,
                  child: const Icon(Icons.menu)
              ),
              Container(
                child: TextButton(
                  onPressed: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => Dialog.fullscreen(
                        child: Column(
                          children: [
                            CustomSearchBar(),
                            const Text("지난 검색 내역")
                          ],
                        ),
                      )
                    );
                    // 페이지 이동 방식
                    // // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
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