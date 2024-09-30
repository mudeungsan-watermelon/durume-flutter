import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/kakao_api.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

Future getLocation() async {
  print("현재 위치 찾기");
  try {
    Position? position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
    // return NLatLng(position.latitude, position.longitude)
  } catch (e) {
    print("현재 위치 찾기 에러 ${e.toString()}");
    return null;
  }
}

Future searchPlace(String query, LatLng latLng, KakaoMapController mapController) async {
  Map<String, dynamic>? results = await kakaoSearch(query, latLng.longitude.toString(), latLng.latitude.toString());
  if (results != null) {
    if (results["documents"].isNotEmpty) {
      // mapModel.setSearchResults(query, results);
      // 마커 생성하기
      Set<Marker> markers = {
        ...results["documents"].map((d) => Marker(
          markerId: d["id"],
          latLng: LatLng(double.parse(d["y"]), double.parse(d["x"])),
          markerImageSrc: redMarkerImgUrl,
          height: 38,
          width: 38,
          // offsetX: 15,
          // offsetY: 44,
        ))
      };
      mapController.addMarker(markers: markers.toList());
      mapController.setCenter(
          LatLng(double.parse(results["documents"][0]["y"]), double.parse(results["documents"][0]["x"]))
      );
      mapController.setLevel(3);
      return results;
    } else {  // 검색 관련 내용이 없을 경우
      // 검색 결과를 찾을 수 없습니다.
      Fluttertoast.showToast(msg: "검색 결과를 찾을 수 없습니다.");
      return results;
    }
  } else {
    // 죄송합니다. 다시 한 번 시도해주세요.
    Fluttertoast.showToast(msg: "죄송합니다. 다시 시도해주세요.");
    return null;
  }
}