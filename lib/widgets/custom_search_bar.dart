import 'package:durume_flutter/databases/search_history/search_history.dart';
import 'package:durume_flutter/databases/search_history/search_history_provider.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/kakao_api.dart';
import 'package:durume_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class CustomSearchBar extends StatefulWidget {

  const CustomSearchBar({
    super.key,
    // required this.searchHistoryProvider
  });

  // final SearchHistoryProvider searchHistoryProvider;

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _queryController = TextEditingController();

  String _input = "";

  @override
  void initState() {
    super.initState();
    _input = "";
  }

  void _setInput(value) {
    setState(() {
      _input = value;
    });
  }

  void _resetInput() {
    setState(() {
      _input = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    DatabaseModel dbModel = Provider.of<DatabaseModel>(context);
    return Column(
      children: [
        SearchBar(
          controller: _queryController,
          leading: _goBackBtn(context),
          trailing: _input.isEmpty ? null : [_resetInputBtn(_queryController, _resetInput)],
          backgroundColor: const MaterialStatePropertyAll(Colors.white),
          elevation: const MaterialStatePropertyAll(0),
          constraints: BoxConstraints(minHeight: 60),
          shape: MaterialStateProperty.all(
            ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(0)
            )
          ),
          hintText: "어디로 떠나볼까요?",
          onChanged: (input) {
            if (input.isEmpty) {
              _resetInput();
            } else {
              _setInput(input);
            }
          },
          onSubmitted: (query) async {
            LatLng center = await mapModel.mapController!.getCenter();
            Map<String, dynamic>? results = await searchPlace(query, LatLng(center.latitude, center.longitude), mapModel.mapController!);
            if (results != null) {
              if (results["documents"].isNotEmpty) {
                mapModel.setSearchResults(query, results);
                dbModel.searchHistoryProvider!.searchQuery(SearchHistory(query: query));
                Navigator.pop(context);
              }
            }
          },
        ),
        const Divider(height: 0,),
      ],
    );
  }
}

Widget _goBackBtn(context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: GestureDetector(
      onTap: (){
        Navigator.pop(context);
      },
      child: const Icon(Symbols.arrow_back, size: 20,),
    ),
  );
}

Widget _resetInputBtn(TextEditingController controller, VoidCallback resetInput) {
  return GestureDetector(
    onTap: () {
      controller.clear();
      resetInput();
    },
    child: const Icon(Icons.close),
  );
}

// PersistentBottomSheetController _showSearchResultBottomSheet(
//   BuildContext context,
//   Map<String, dynamic>? results,
// ) {
//   return showBottomSheet(
//     context: context,
//     builder: (context) => SearchResultModal(results: results),
//   );
// }
//
// Future _showSearchResultsBottomModal(
//     BuildContext context,
//     Map<String, dynamic>? results,
//     ) {
//   return showModalBottomSheet(
//       context: context,
//       builder: (context) => SearchResultModal(results: results),
//       enableDrag: true,
//       isScrollControlled: true,
//       isDismissible: false,  // 바텀시트 아닌 부분 클릭시 닫을지
//       showDragHandle: true,
//       backgroundColor: Colors.white,
//       barrierColor: Colors.transparent,
//       constraints: const BoxConstraints(
//         maxHeight: 200,
//         minWidth: double.infinity,
//       )
//   );
// }