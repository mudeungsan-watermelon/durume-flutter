import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/search_screen/search_screen.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_view.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/kakao_api.dart';
import 'package:durume_flutter/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';

class HomeSearchBar extends StatefulWidget {
  final VoidCallback openDrawer;

  const HomeSearchBar({
    super.key,
    required this.openDrawer,
  });

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {

  // final TextEditingController _queryController = TextEditingController();
  //
  // String _input = "";
  // bool _isNoResults = false;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _input = "";
  //   _isNoResults = false;
  // }
  //
  // void _setInput(value) {
  //   setState(() {
  //     _input = value;
  //   });
  // }
  //
  // void _resetInput() {
  //   setState(() {
  //     _input = "";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    // return Expanded(
    //   child: SearchBar(
    //     controller: _queryController,
    //     leading: _goBackBtn(context),
    //     trailing: _input.isEmpty ? null : [_resetInputBtn(_queryController, _resetInput)],
    //     backgroundColor: const MaterialStatePropertyAll(Colors.white),
    //     elevation: const MaterialStatePropertyAll(1),
    //     hintText: "어디로 떠나볼까요?",
    //     onChanged: (input) {
    //       if (input.isEmpty) {
    //         _resetInput();
    //       } else {
    //         _setInput(input);
    //       }
    //     },
    //     onSubmitted: (query) async {
    //       // 검색어 입력 -> API 호출 -> 응답 O -> SearchView에 값 보여주기
    //       Map<String, dynamic>? results = await kakaoSearch(query);
    //       if (results != null) {
    //         if (results["documents"].isNotEmpty) {
    //           if (!mounted) return;
    //           mapModel.setSearchResults(query, results);
    //           // 마커 생성하기
    //           Set<Marker> markers = {
    //             ...results["documents"].map((d) => Marker(
    //                 markerId: d["id"],
    //                 latLng: LatLng(double.parse(d["y"]), double.parse(d["x"]))
    //             ))
    //           };
    //           mapModel.mapController!.addMarker(markers: markers.toList());
    //           mapModel.mapController!.setCenter(
    //               LatLng(double.parse(results["documents"][0]["y"]), double.parse(results["documents"][0]["x"]))
    //           );
    //           mapModel.setZoomLevel(3);
    //           // Navigator.of(context).pushNamed('/search_result');
    //           Navigator.pop(context);
    //         } else {  // 검색 관련 내용이 없을 경우
    //           // 검색 결과를 찾을 수 없습니다.
    //           setState(() {
    //             _isNoResults = true;
    //           });
    //         }
    //       } else {
    //         // 죄송합니다. 다시 한 번 시도해주세요.
    //         setState(() {
    //           _isNoResults = true;
    //         });
    //       }
    //     },
    //   ),
    // );
    return Expanded(
      child: Container(
        decoration: basicBoxStyle,
        height: double.infinity,
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 19*widthRatio(context)),
              child: mapModel.results == null ? GestureDetector(
                  onTap: widget.openDrawer,
                  child: Icon(Icons.menu, color: softBlack,)) :
                GestureDetector(
                  onTap: (){
                    mapModel.resetSearchResults();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                  },
                  child: Icon(Icons.chevron_left, color: softBlack),
                ),
            ),
            Container(
              child: mapModel.results == null ?
                TextButton(
                  onPressed: (){
                    // 다른 페이지에서
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                  },
                  child: Text(
                    "어디로 떠나볼까요?",
                    style: TextStyle(color: softBlack, fontSize: 16),
                ),) :
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    mapModel.searchQuery!,
                    style: TextStyle(color: softBlack, fontSize: 16),
                  ),
                ),
            )
          ],
        ),
      ),
    );
  }
}

// Widget _goBackBtn(context) {
//   return GestureDetector(
//     onTap: (){
//       mapModel.resetSearchResults();
//       Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
//     },
//     child: Icon(Icons.chevron_left, color: softBlack),
//   );
// }

// Widget _resetInputBtn(TextEditingController controller, VoidCallback resetInput) {
//   return GestureDetector(
//     onTap: () {
//       controller.clear();
//       resetInput();
//     },
//     child: const Icon(Icons.close),
//   );
// }