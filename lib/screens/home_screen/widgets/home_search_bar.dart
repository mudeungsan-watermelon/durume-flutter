import 'package:durume_flutter/screens/search_screen/search_screen.dart';
import 'package:durume_flutter/screens/search_screen/widgets/search_view.dart';
import 'package:durume_flutter/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatefulWidget {
  VoidCallback openDrawer;
  GlobalKey<ScaffoldState> scaffoldKey;

  HomeSearchBar({
    super.key,
    required this.openDrawer,
    required this.scaffoldKey,
    // required this.setResults,
  });

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {
  Map<String, dynamic>? _results;

  void _setResults(val) {
    if (val != null && val.isNotEmpty) {
      setState(() {
        _results = val;
        print("###################$_results");
      });
    }
  }

  void _resetResults() {
    setState(() {
      _results = null;
    });
  }

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
                            CustomSearchBar(setResults: _setResults, resetResults: _resetResults, scaffoldKey: widget.scaffoldKey),
                            _results != null ? SearchView(response: _results!) : Text("검색결과 없음")
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