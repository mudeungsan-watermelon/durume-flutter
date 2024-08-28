import 'package:durume_flutter/databases/search_history/search_history.dart';
import 'package:durume_flutter/databases/search_history/search_history_provider.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/screens/search_screen/widgets/search_history_list.dart';
import 'package:durume_flutter/widgets/custom_search_bar.dart';
import 'package:durume_flutter/widgets/filter_bar.dart';
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
    DatabaseModel dbModel = Provider.of<DatabaseModel>(context);
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
          // FutureBuilder(
          //   future: dbModel.searchHistoryProvider!.getSearchHistory(),
          //   builder: (context, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return const CircularProgressIndicator();
          //     } else if (snapshot.hasError) {
          //       print('최근 검색어 에러: ${snapshot.error}');
          //       return Text('최근 검색어를 불러올 수 없습니다.');
          //     } else {
          //       List<SearchHistory> datas = snapshot.data as List<SearchHistory>;
          //       if (datas.isNotEmpty) {
          //         return SearchHistoryList(histories: datas,);
          //       }
          //       return _SearchSuggester();
          //     }
          //   }
          // )
          SearchHistoryList(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

Widget _SearchSuggester() {
  return const Padding(
    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
    child: Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            children: [
              Text(
                "추천 검색어",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                )
              ),
            ],
          ),
        ),
        SizedBox(height: 8,),
        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Filter(text: "🍚 음식점", category: "음식점", code: "FD6"),
                Filter(text: "☕️ 카페", category: "카페", code: "CE7"),
                Filter(text: "📸 관광명소", category: "관광명소", code: "AT4"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Filter(text: "🎨 문화", category: "문화", code: "CT1"),
                Filter(text: "🏪 편의점", category: "편의점", code: "CS2"),
                Filter(text: "🛏️ 숙소", category: "숙소", code: "AD5"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Filter(text: "🚗 주차장", category: "주차장", code: "PK6"),
                Filter(text: "⛽️ 주유소", category: "주유소", code: "OL7"),
              ],
            ),
          ],
        )
      ],
    ),
  );
}
