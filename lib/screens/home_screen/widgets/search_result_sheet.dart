import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/bottom_sheet_widgets.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_view.dart';
import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultSheet extends StatelessWidget {
  // final Map<String, dynamic>? results;

  const SearchResultSheet({
    super.key,
    // this.results,
  });

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
            CustomDragHandle,
            mapModel.results != null ? SearchView(results: mapModel.results!) : Text("검색결과 없음")
          ],
        ),
      ),
    );
  }
}
