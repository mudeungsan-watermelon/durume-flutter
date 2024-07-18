import 'package:durume_flutter/screens/home_screen/widgets/search_result_modal.dart';
import 'package:durume_flutter/utils/kakao_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class SearchResultScreen extends StatefulWidget {
  final String query;

  const SearchResultScreen({
    super.key,
    required this.query
  });

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  KakaoMapController? mapController;
  
  @override
  void initState() {
    super.initState();
    AuthRepository.initialize(appKey: dotenv.env["KAKAO_JS_KEY"]!);
  }
  
  void _onMapCreated(KakaoMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: kakaoSearch(widget.query),
          builder: (context, snapshot) {
            mapController?.clear();
            if (snapshot.hasData) {
              Map<String, dynamic> results = snapshot.data;
              if (results["documents"].isEmpty) {
                return KakaoMap(
                  onMapCreated: ((controller) async {
                    controller.clear();
                    _onMapCreated(controller);
                    _showSearchResultsBottomModal(context, null, null);
                  }),
                );
              } else {
                // mapController?.setCenter(LatLng(
                //     double.parse(results["documents"][0]["y"]),
                //     double.parse(results["documents"][0]["x"])
                // ));
                return KakaoMap(
                  onMapCreated: ((controller) async {
                    controller.clear();
                    _onMapCreated(controller);
                    // controller.setCenter(LatLng(
                    //     double.parse(results["documents"][0]["y"]),
                    //     double.parse(results["documents"][0]["x"])
                    // ));
                    _showSearchResultsBottomModal(context, results, controller);
                  }),
                  markers: [
                    ...results["documents"].map((d) => Marker(
                      markerId: d["id"],
                      latLng: LatLng(double.parse(d["y"]), double.parse(d["x"]))
                    ))
                  ],
                  center: LatLng(
                      double.parse(results["documents"][0]["y"]),
                      double.parse(results["documents"][0]["x"])
                  ),
                );
              }


              return KakaoMap(
                markers: results["documents"].isEmpty ? null :
                            [...results["documents"].map((d) => Marker(
                                markerId: d["id"],
                                latLng: LatLng(double.parse(d["x"]), double.parse(d["y"]))
                            ))]
                ,
              );
              // return NaverMap(
              //   options: const NaverMapViewOptions(),
              //   onMapReady: (controller) {
              //     print("검색 결과 지도");
              //     print(results["documents"].isEmpty);
              //     if (results["documents"].isEmpty) {  // 검색 결과 없음
              //       print("검색 결과 없음");
              //     } else {  // 검색 결과 있을 땐 마커 생성
              //       print("검색 결과 있을 땐 마커 생성");
              //       Set<NAddableOverlay> markers = results["documents"].entries.map((entry) {
              //         var key = entry.key;
              //         var document = entry.value;
              //         return NMarker(id: key, position: NLatLng(document["x"], document["y"]));
              //       }).toSet();
              //       // Set<NAddableOverlay> markers = {...results["documents"].map((key, document) {
              //       //   NMarker(id: key, position: NLatLng(document["x"], document["y"]));
              //       // })};
              //       print("검색 결과 마커 ${markers.toString()}");
              //       controller.addOverlayAll(markers);
              //     }
              //   },
              // );
            } else {
              print(snapshot.error.toString());
              return const Text("검색 문제");
            }
          },
        ),
      ),
    );
  }
}

Future _showSearchResultsBottomModal(
    BuildContext context,
    Map<String, dynamic>? results,
    KakaoMapController? mapController
  ) {
  return showModalBottomSheet(
      context: context,
      builder: (context) => SearchResultModal(
          results: results, mapController: mapController,
      ),
      enableDrag: true,
      isScrollControlled: true,
      isDismissible: false,  // 바텀시트 아닌 부분 클릭시 닫을지
      showDragHandle: true,
      backgroundColor: Colors.white,
      barrierColor: Colors.transparent,
      constraints: const BoxConstraints(
        maxHeight: 200,
        minWidth: double.infinity,
      )
  );
}
