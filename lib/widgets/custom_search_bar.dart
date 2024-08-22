import 'package:durume_flutter/databases/search_history/search_history.dart';
import 'package:durume_flutter/databases/search_history/search_history_provider.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/kakao_api.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
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
  bool _isNoResults = false;

  @override
  void initState() {
    super.initState();
    _input = "";
    _isNoResults = false;
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
  
  // void _insertQuery(value) {
  //   widget.searchHistoryProvider.insertSearchHistory(SearchHistory(query: value));
  // }

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    DatabaseModel dbModel = Provider.of<DatabaseModel>(context);
    return SearchBar(
      controller: _queryController,
      leading: _goBackBtn(context),
      trailing: _input.isEmpty ? null : [_resetInputBtn(_queryController, _resetInput)],
      backgroundColor: const MaterialStatePropertyAll(Colors.white),
      elevation: const MaterialStatePropertyAll(2),
      constraints: BoxConstraints(minHeight: 70),
      shape: MaterialStateProperty.all(
        ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        )
      ),
      hintText: "검색어를 입력하세요.",
      onChanged: (input) {
        if (input.isEmpty) {
          _resetInput();
        } else {
          _setInput(input);
        }
      },
      onSubmitted: (query) async {
        // search_history db에 저장
        // _insertQuery(query);
        dbModel.searchHistoryProvider!.insertSearchHistory(SearchHistory(query: query));
        // 검색어 입력 -> API 호출 -> 응답 O -> 레이아웃 off / 바텀시트 on -> 값 보여주기
        LatLng center = await mapModel.mapController!.getCenter();
        Map<String, dynamic>? results = await kakaoSearch(query, center.longitude.toString(), center.latitude.toString());
        if (results != null) {
          if (results["documents"].isNotEmpty) {
            if (!mounted) return;
            mapModel.setSearchResults(query, results);
            // 마커 생성하기
            Set<Marker> markers = {
              ...results["documents"].map((d) => Marker(
                markerId: d["id"],
                latLng: LatLng(double.parse(d["y"]), double.parse(d["x"])),
                markerImageSrc: redMarkerImgUrl,
                height: 46,
                width: 42,
                // offsetX: 15,
                // offsetY: 44,
              ))
            };
            mapModel.mapController!.addMarker(markers: markers.toList());
            mapModel.mapController!.setCenter(
                LatLng(double.parse(results["documents"][0]["y"]), double.parse(results["documents"][0]["x"]))
            );
            mapModel.setZoomLevel(3);
            // Navigator.of(context).pushNamed('/search_result');
            Navigator.pop(context);
          } else {  // 검색 관련 내용이 없을 경우
            // 검색 결과를 찾을 수 없습니다.
            setState(() {
              _isNoResults = true;
            });
          }
        } else {
          // 죄송합니다. 다시 한 번 시도해주세요.
          setState(() {
            _isNoResults = true;
          });
        }
      },
    );
  }
}

Widget _goBackBtn(context) {
  return GestureDetector(
    onTap: (){
      Navigator.pop(context);
    },
    child: const Icon(Icons.chevron_left),
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