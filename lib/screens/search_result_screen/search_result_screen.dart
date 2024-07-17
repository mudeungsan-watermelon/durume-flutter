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
          future: naverSearch(query),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              Map<String, dynamic> results = snapshot.data;
              if (results["items"].isEmpty) {
                return Text("\"$query\" 검색 결과 없음");  // 나중에 맵 로딩하고, 모달로 내용 옮기기
              } else {
                return NaverMap(
                  options: const NaverMapViewOptions(),
                  onMapReady: (controller) {
                    // 마커 생성하기
                  },
                );
              }
            } else {
              return const Text("검색 문제");
            }
          },
        ),
      ),
    );
  }
}
