import 'package:durume_flutter/screens/home_screen/widgets/search_view.dart';
import 'package:flutter/material.dart';

class SearchResultModal extends StatefulWidget {
  final Map<String, dynamic>? results;
  // double? height;

  SearchResultModal({
    super.key,
    this.results,
    // this.height,
  });

  @override
  State<SearchResultModal> createState() => _SearchResultModalState();
}

class _SearchResultModalState extends State<SearchResultModal> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: widget.height,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text("검색결과"),
            widget.results != null ? SearchView(results: widget.results!) : Text("검색결과 없음")
          ],
        ),
      ),
    );
  }
}