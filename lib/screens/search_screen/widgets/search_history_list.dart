import 'package:durume_flutter/databases/search_history/search_history.dart';
import 'package:durume_flutter/databases/search_history/search_history_provider.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class SearchHistoryList extends StatefulWidget {
  const SearchHistoryList({
    super.key,
    // required this.searchHistoryProvider,
    // required this.histories,
  });

  // List<SearchHistory> histories;
  // final SearchHistoryProvider searchHistoryProvider;

  @override
  State<SearchHistoryList> createState() => _SearchHistoryListState();
}

class _SearchHistoryListState extends State<SearchHistoryList> {
  // List<SearchHistory> histories;
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

  void deleteAllSearchHistory() {
    dbModel.searchHistoryProvider!.deleteAllSearchHistory();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    dbModel = Provider.of<DatabaseModel>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      // child: Column(
      //   children: [
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     const Text(
          //       "최근 검색어",
          //       style: TextStyle(
          //         fontWeight: FontWeight.w500,
          //       )
          //     ),
          //     TextButton(
          //       onPressed: (){
          //         // widget.searchHistoryProvider.deleteAllSearchHistory();
          //         dbModel.searchHistoryProvider!.deleteAllSearchHistory();
          //         setState(() {});
          //         Fluttertoast.showToast(msg: "최근 검색어가 삭제되었습니다.");
          //       },
          //         style: TextButton.styleFrom(padding: EdgeInsets.zero),
          //       child: const Text(
          //         "모두 지우기",
          //         style: TextStyle(
          //           fontWeight: FontWeight.w400,
          //         ),
          //       )
          //     )
          //   ],
          // ),
          // SizedBox(height: 8,),
        child: FutureBuilder(
          future: dbModel.searchHistoryProvider!.getSearchHistory(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  _SearchHistoryHeader(deleteAllSearchHistory, false),
                  const CircularProgressIndicator(),
                ],
              );
            } else if (snapshot.hasError) {
              return Column(
                children: [
                  _SearchHistoryHeader(deleteAllSearchHistory, false),
                  _NoHistory("최근 검색어를 불러올 수 없습니다.")
                ],
              );
            } else {
              List<SearchHistory> datas = snapshot.data as List<SearchHistory>;
              if (datas.isNotEmpty) {
                return Column(
                  children: [
                    _SearchHistoryHeader(deleteAllSearchHistory, true),
                    Column(
                      children: [
                        ...datas.map((history) => _HistoryRecord(
                            history: history,
                            deleteHistory: deleteSearchHistory
                        ))
                      ],
                    ),
                  ],
                );
              }
              return Column(
                children: [
                  _SearchHistoryHeader(deleteAllSearchHistory, false),
                  _NoHistory("최근 검색어가 존재하지 않습니다."),
                ],
              );
            }
          }
        )
      //   ],
      // ),
    );
  }
}

Widget _SearchHistoryHeader(Function deleteAllSearchHistory, bool hasValue) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
              "최근 검색어",
              style: TextStyle(
                fontWeight: FontWeight.w500,
              )
          ),
          TextButton(
              onPressed: hasValue ? (){
                deleteAllSearchHistory();
                Fluttertoast.showToast(msg: "최근 검색어가 삭제되었습니다.");
              } : (){},
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                hasValue ? "모두 지우기" : "",
                style: const TextStyle(
                  fontWeight: FontWeight.w400,
                ),
              )
          )
        ],
      ),
      const SizedBox(height: 8,),
    ],
  );
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
        Row(
          children: [
            Icon(Symbols.search, color: iconGrey, size: 20,),
            const SizedBox(width: 8,),
            Text(history.query, style: TextStyle(fontSize: 16)),
          ],
        ),
        GestureDetector(
          onTap: () {
            // 삭제 코드
            deleteHistory(history.id);
            Fluttertoast.showToast(msg: "최근 검색어가 삭제되었습니다.");
          },
          child: Icon(Icons.close, color: iconGrey, size: 20,),
        )
      ],
    );
  }
}

Widget _NoHistory(String text) {
  return Column(
    children: [
      const SizedBox(height: 60,),
      const Icon(Symbols.fmd_bad, size: 70, weight: 3),
      const SizedBox(height: 16,),
      Text(text, style: const TextStyle(fontSize: 18),)
    ],
  );
}

