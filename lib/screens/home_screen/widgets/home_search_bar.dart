import 'package:durume_flutter/screens/search_screen/search_screen.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_view.dart';
import 'package:durume_flutter/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class HomeSearchBar extends StatefulWidget {
  final VoidCallback openDrawer;

  const HomeSearchBar({
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
                    // // 한 페이지에서
                    // showDialog(
                    //   context: context,
                    //   builder: (BuildContext context) => const Dialog.fullscreen(
                    //     child: Column(
                    //       children: [
                    //         CustomSearchBar(),
                    //         Text("지난 검색 내역")
                    //       ],
                    //     ),
                    //   )
                    // );
                    
                    // 다른 페이지에서
                    // Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                    Navigator.of(context).pushNamed('/search');
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