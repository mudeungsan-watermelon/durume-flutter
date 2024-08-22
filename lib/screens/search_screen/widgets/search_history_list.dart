import 'package:durume_flutter/databases/search_history/search_history.dart';
import 'package:durume_flutter/databases/search_history/search_history_provider.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SearchHistoryList extends StatefulWidget {
  SearchHistoryList({
    super.key,
    // required this.searchHistoryProvider,
    // required this.histories,
  });

  // final SearchHistoryProvider searchHistoryProvider;

  @override
  State<SearchHistoryList> createState() => _SearchHistoryListState();
}

class _SearchHistoryListState extends State<SearchHistoryList> {
  // late Future<List<SearchHistory>> histories;
  late DatabaseModel dbModel;

  @override
  void initState() {
    super.initState();
    // histories = widget.searchHistoryProvider.getSearchHistory();

  }

  void deleteSearchHistory(int id) {
    dbModel.searchHistoryProvider!.deleteSearchHistory(id);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    dbModel = Provider.of<DatabaseModel>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("최근 검색어"),
              TextButton(
                onPressed: (){
                  // widget.searchHistoryProvider.deleteAllSearchHistory();
                  dbModel.searchHistoryProvider!.deleteAllSearchHistory();
                  setState(() {});
                },
                child: Text("모두 지우기")
              )
            ],
          ),
          FutureBuilder(
            future: dbModel.searchHistoryProvider!.getSearchHistory(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<SearchHistory> datas = snapshot.data as List<SearchHistory>;
                if (datas.isNotEmpty) {
                  return Column(
                    children: [
                      ...datas.map((history) => _HistoryRecord(
                          history: history,
                          deleteHistory: deleteSearchHistory
                      ))
                    ],
                  );
                }
                return Text("머리고 쓰지");
              }
            }
          )
        ],
      ),
    );
  }
}

class _HistoryRecord extends StatelessWidget {
  // final String text;
  final SearchHistory history;
  final Function deleteHistory;

  const _HistoryRecord({
    super.key,
    required this.history,
    required this.deleteHistory,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(history.query),
        GestureDetector(
          onTap: () {
            // 삭제 코드
            deleteHistory(history.id);
          },
          child: Icon(Icons.close),
        )
      ],
    );
  }
}

