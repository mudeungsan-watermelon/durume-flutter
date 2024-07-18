import 'package:durume_flutter/screens/home_screen/widgets/search_view.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class SearchResultModal extends StatefulWidget {
  final Map<String, dynamic>? results;
  final KakaoMapController? mapController;

  const SearchResultModal({
    super.key,
    this.results,
    this.mapController
  });

  @override
  State<SearchResultModal> createState() => _SearchResultModalState();
}

class _SearchResultModalState extends State<SearchResultModal> {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text("검색결과"),
            widget.results != null ? SearchView(results: widget.results!, mapController: widget.mapController!,) : Text("검색결과 없음")
          ],
        ),
      ),
    );
  }
}