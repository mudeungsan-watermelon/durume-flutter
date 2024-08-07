import 'package:durume_flutter/screens/home_screen/widgets/search_view.dart';
import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';

class SearchResultModal extends StatefulWidget {
  final Map<String, dynamic>? results;

  SearchResultModal({
    super.key,
    this.results,
  });

  @override
  State<SearchResultModal> createState() => _SearchResultModalState();
}

class _SearchResultModalState extends State<SearchResultModal> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: basicBoxStyle(borderRadius: 30, borderDirectional: true),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 46,
                    height: 6,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(100)
                    ),
                  )
                ],
              ),
            ),
            // Text("검색결과", style: TextStyle(fontSize: 16),),
            widget.results != null ? SearchView(results: widget.results!) : Text("검색결과 없음")
          ],
        ),
      ),
    );
  }
}