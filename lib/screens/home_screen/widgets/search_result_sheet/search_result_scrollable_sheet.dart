import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_result_sheet/search_result_sheet.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchResultScrollableSheet extends StatelessWidget {
  SearchResultScrollableSheet({super.key});

  final DraggableScrollableController controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    return DraggableScrollableSheet(
      controller: controller,
      builder: (BuildContext context, scrollController) {
        // if (mapModel.searchResultController == null) mapModel.setSearchResultController(scrollController);
        // return SearchResultSheet(scrollController: mapModel.searchResultController ?? scrollController);
        return SearchResultSheet(scrollController: scrollController);
      }
    );
  }
}
