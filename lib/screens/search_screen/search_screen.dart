import 'package:durume_flutter/screens/search_screen/widgets/search_history.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // String? query;
  Map<String, dynamic>? results;

  void setResults(val) {
    if (val != null && val.isNotEmpty) {
      setState(() {
        results = val;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // const SizedBox(height: 24,),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
              child: CustomSearchBar(),
            ),
          ),
          // results != null ? SearchView(results: results!) : const Text("검색결과 없음")
          SearchHistory()
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
