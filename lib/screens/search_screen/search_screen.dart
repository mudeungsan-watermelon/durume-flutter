import 'package:durume_flutter/screens/home_screen/widgets/search_view.dart';
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
          const SizedBox(height: 24,),
          // CustomSearchBar(),
          results != null ? SearchView(results: results!) : const Text("검색결과 없음")
          // SearchHistory()
        ],
      ),
      floatingActionButton: ElevatedButton(
        onPressed: (){},
        child: const Text("지도에서 보기"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
