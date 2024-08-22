import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_view.dart';
import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultModal extends StatefulWidget {
  // final Map<String, dynamic>? results;

  const SearchResultModal({
    super.key,
    // this.results,
  });

  @override
  State<SearchResultModal> createState() => _SearchResultModalState();
}

class _SearchResultModalState extends State<SearchResultModal> {

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    return Container(
      width: double.infinity,
      decoration: basicBoxStyle(borderRadius: 30, borderDirectional: true),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            _CustomDragHandle,
            mapModel.results != null ? SearchView(results: mapModel.results!) : Text("검색결과 없음")
          ],
        ),
      ),
    );
  }
}

Widget _CustomDragHandle = Padding(
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
);
