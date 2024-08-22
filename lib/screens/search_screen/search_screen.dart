import 'package:durume_flutter/databases/search_history/search_history.dart';
import 'package:durume_flutter/databases/search_history/search_history_provider.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/screens/search_screen/widgets/search_history_list.dart';
import 'package:durume_flutter/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  // final SearchHistoryProvider _searchHistoryProvider = SearchHistoryProvider();
  // String? query;
  Map<String, dynamic>? results;
  // late Future<List<SearchHistory>> histories;

  // @override
  // void initState() {
  //   super.initState();
  //   histories = _searchHistoryProvider.getSearchHistory();
  // }

  void setResults(val) {
    if (val != null && val.isNotEmpty) {
      setState(() {
        results = val;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // DatabaseModel dbModel = Provider.of<DatabaseModel>(context);
    return Scaffold(
      body: Column(
        children: [
          // const SizedBox(height: 24,),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
              child: const CustomSearchBar(),
            ),
          ),
          // results != null ? SearchView(results: results!) : const Text("검색결과 없음")
          SearchHistoryList()
          // FutureBuilder(
          //   future: histories,
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     } else if (snapshot.hasError) {
          //       return Text('Error: ${snapshot.error}');
          //     } else {
          //       List<SearchHistory> histories = snapshot.data as List<SearchHistory>;
          //       return SearchHistoryList(histories: histories);
          //     }
          //   }
          // )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
