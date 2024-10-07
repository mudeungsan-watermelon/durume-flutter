import 'package:durume_flutter/databases/favorite/favorite.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/kakao_api.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

Future getLocation() async {
  print("현재 위치 찾기");
  try {
    Position? position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.latitude, position.longitude);
  } catch (e) {
    print("현재 위치 찾기 에러 ${e.toString()}");
    return null;
  }
}

Future searchPlace(String query, LatLng latLng, KakaoMapController mapController) async {
  Map<String, dynamic>? results = await kakaoSearch(query, latLng.longitude.toString(), latLng.latitude.toString());
  if (results != null && results["documents"].isEmpty) results = await kakaoSearch(query, null, null);

  if (results != null) {
    if (results["documents"].isNotEmpty) {
      // 마커 생성하기
      Set<Marker> markers = {
        ...results["documents"].map((d) => Marker(
          markerId: "${d['id']}~${d['place_name']}",
          latLng: LatLng(double.parse(d["y"]), double.parse(d["x"])),
          markerImageSrc: redMarkerImgUrl,
          height: 30,
          width: 30,
        ))
      };
      mapController.addMarker(markers: markers.toList());
      mapController.setCenter(
          LatLng(double.parse(results["documents"][0]["y"]), double.parse(results["documents"][0]["x"]))
      );
      mapController.setLevel(3);
      return results;
    } else {  // 검색 관련 내용이 없을 경우
      Fluttertoast.showToast(msg: "검색 결과를 찾을 수 없습니다.");
      return results;
    }
  } else {
    Fluttertoast.showToast(msg: "죄송합니다. 다시 시도해주세요.");
    return null;
  }
}

Future<Map<String, dynamic>?> findPlaceById(String query, String id, LatLng latLng) async {
  Map<String, dynamic>? results = await kakaoSearch(query, latLng.longitude.toString(), latLng.latitude.toString());
  if (results == null || results["documents"].isEmpty) {
    Fluttertoast.showToast(msg: "죄송합니다. 다시 시도해주세요.");
    return null;
  } else {
    Map<String, dynamic> detailInfo = results["documents"].firstWhere((d) => d["id"] == id);
    return detailInfo;
  }
}

Future<void> setFavoriteMarkers(DatabaseModel dbModel, MapModel mapModel) async {
  List<Favorite>? favorites = await dbModel.favoriteProvider!.getFavorite();

  Set<Marker> favoriteMarkers = {
    ...favorites.map((e) => Marker(
      markerId: "${e.placeId}~${e.name}",
      latLng: e.position,
      markerImageSrc: favoriteMarkerImgUrl,
      width: 30,
      height: 30,
    ))
  };
  mapModel.setFavoriteMarkers(favoriteMarkers);
}