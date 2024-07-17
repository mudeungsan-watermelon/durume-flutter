import 'package:durume_flutter/utils/kakao_api.dart';
import 'package:durume_flutter/utils/naver_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

class SearchResultScreen extends StatelessWidget {
  final String query;

  const SearchResultScreen({
    super.key,
    required this.query
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: kakaoSearch(query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> results = snapshot.data;
              return NaverMap(
                options: const NaverMapViewOptions(),
                onMapReady: (controller) {
                  print("검색 결과 지도");
                  print(results["documents"].isEmpty);
                  if (results["documents"].isEmpty) {  // 검색 결과 없음
                    print("검색 결과 없음");
                  } else {  // 검색 결과 있을 땐 마커 생성
                    print("검색 결과 있을 땐 마커 생성");
                    Set<NAddableOverlay> markers = results["documents"].entries.map((entry) {
                      var key = entry.key;
                      var document = entry.value;
                      return NMarker(id: key, position: NLatLng(document["x"], document["y"]));
                    }).toSet();
                    // Set<NAddableOverlay> markers = {...results["documents"].map((key, document) {
                    //   NMarker(id: key, position: NLatLng(document["x"], document["y"]));
                    // })};
                    print("검색 결과 마커 ${markers.toString()}");
                    controller.addOverlayAll(markers);
                  }
                },
              );
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
