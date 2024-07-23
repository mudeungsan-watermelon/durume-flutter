import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MapModel with ChangeNotifier {
  KakaoMapController? _mapController;
  Set<Marker> _markers = {};
  LatLng? _center;
  int _zoomLevel = 3;

  KakaoMapController? get mapController => _mapController;
  Set<Marker> get markers => _markers;
  LatLng? get center => _center;
  int get zoomLevel => _zoomLevel;

  void setMapController(KakaoMapController? mapController) {
    _mapController = mapController;
    print("맵 컨트롤러 세팅");
    notifyListeners();
  }

  void setMarkers(Set<Marker> markers) {
    _markers = markers;
    print("마커 세팅");
    notifyListeners();
  }

  void resetMarkers() {
    _markers = {};
    print("마커 리셋");
    notifyListeners();
  }

  void setCenter(LatLng center) {
    _center = center;
    print("지도 중심 세팅");
    notifyListeners();
  }

  void resetCenter() {
    _center = null;
    print("지도 중심 리셋");
    notifyListeners();
  }

  void setZoomLevel(int zoomLevel) {
    _zoomLevel = zoomLevel;
    print("줌 정도 세팅");
    notifyListeners();
  }

  void resetZoomLevel() {
    _zoomLevel = 3;
    print("줌 정도 초기화");
    notifyListeners();
  }
}