import 'package:durume_flutter/databases/search_history/search_history.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/kakao_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 56,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _Filter(text: "🍚 음식점", category: "음식점", code: "FD6"),
            _Filter(text: "☕️ 카페", category: "카페", code: "CE7"),
            _Filter(text: "📸 관광명소", category: "관광명소", code: "AT4"),
            _Filter(text: "🎨 문화", category: "문화", code: "CT1"),
            _Filter(text: "🏪 편의점", category: "편의점", code: "CS2"),
            _Filter(text: "🛏️ 숙소", category: "숙소", code: "AD5"),
            _Filter(text: "🚗 주차장", category: "주차장", code: "PK6"),
            _Filter(text: "⛽️ 주유소", category: "주유소", code: "OL7"),
          ],
        ),
      ),
    );
  }
}

class _Filter extends StatelessWidget {
  final String text;
  final String category;
  final String code;

  const _Filter({
    super.key,
    required this.text,
    required this.category,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    DatabaseModel dbModel = Provider.of<DatabaseModel>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: GestureDetector(
        onTap: () async {
          LatLng center = await mapModel.mapController!.getCenter();
          Map<String, dynamic>? results = await kakaoCategorySearch(code, center.longitude.toString(), center.latitude.toString());
          if (results != null) {
            dbModel.searchHistoryProvider!.insertSearchHistory(SearchHistory(query: category));
            if (results["documents"].isNotEmpty) {
              mapModel.setSearchResults(category, results);
              // 마커 생성하기
              Set<Marker> markers = {
                ...results["documents"].map((d) => Marker(
                  markerId: d["id"],
                  latLng: LatLng(double.parse(d["y"]), double.parse(d["x"])),
                  markerImageSrc: redMarkerImgUrl,
                  height: 46,
                  width: 42,
                ))
              };
              mapModel.mapController!.clearMarker();
              mapModel.mapController!.addMarker(markers: markers.toList());
              mapModel.mapController!.setCenter(
                  LatLng(double.parse(results["documents"][0]["y"]), double.parse(results["documents"][0]["x"]))
              );
              mapModel.setZoomLevel(3);
            } else {  // 검색 관련 내용이 없을 경우
              Fluttertoast.showToast(msg: "잠시 후 다시 시도해주세요.");
            }
          } else {
            Fluttertoast.showToast(msg: "잠시 후 다시 시도해주세요.");
          }
        },
        child: Container(
          decoration: basicBoxStyle(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 7*widthRatio(context), horizontal: 12*heightRatio(context)),
            child: Text(
                text,
                style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16
                )
            ),
          ),
        ),
      ),
    );
  }
}
