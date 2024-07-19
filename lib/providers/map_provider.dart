import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MapProvider with ChangeNotifier {
  KakaoMapController? _mapController;

  KakaoMapController? get mapController => _mapController;

  void setMapController(KakaoMapController? mapController) {
    _mapController = mapController;
    print("맵 컨트롤러 세팅");
    notifyListeners();
  }
}