import 'package:flutter/material.dart';

class SearchHistory extends StatelessWidget {
  const SearchHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("최근 검색어"),
              TextButton(onPressed: (){}, child: Text("모두 지우기"))
            ],
          ),
          Column(
            children: [
              _HistoryRecord(text: "덕수궁"),
              _HistoryRecord(text: "국립현대미술관"),
              _HistoryRecord(text: "애정마라샹궈"),
              _HistoryRecord(text: "숭실대학교"),
              _HistoryRecord(text: "챔피언스필드"),
            ],
          )
        ],
      ),
    );
  }
}

class _HistoryRecord extends StatelessWidget {
  final String text;
  
  const _HistoryRecord({
    super.key,
    required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text),
        Icon(Icons.close)
      ],
    );
  }
}

