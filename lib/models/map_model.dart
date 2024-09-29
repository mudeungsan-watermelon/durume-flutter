import 'package:durume_flutter/databases/favorite/favorite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MapModel with ChangeNotifier {
  KakaoMapController? _mapController;
  Set<Marker> _markers = {};

  String? _searchQuery;
  Map<String, dynamic>? _results;

  // bool _hasResults = false;
  Map<String, dynamic>? _detailInfo;
  bool _goDetail = false;

  List<Favorite>? _favoriteList;
  bool? _isFavorite;

  KakaoMapController? get mapController => _mapController;
  Set<Marker> get markers => _markers;

  String? get searchQuery => _searchQuery;
  Map<String, dynamic>? get results => _results;

  // bool get hasResults => _hasResults;
  Map<String, dynamic>? get detailInfo => _detailInfo;
  bool get goDetail => _goDetail;

  List<Favorite>? get favoriteList => _favoriteList;
  bool? get isFavorite => _isFavorite;

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

  // void setSearchQuery(String value) {
  //   _searchQuery = value;
  //   print("검색어 세팅");
  //   notifyListeners();
  // }
  //
  // void setResults(Map<String, dynamic> results) {
  //   _results = results;
  //   print("검색 결과 세팅");
  //   notifyListeners();
  // }

  // void resetResults() {
  //   _results = null;
  //   print("검색 결과 리셋");
  //   notifyListeners();
  // }

  // void setHasResults() {
  //   if (_results != null) {  // 값이 있을 때만 true가 되도록
  //     _hasResults = true;
  //   }
  //   notifyListeners();
  // }

  // void resetHasResults() {
  //   _hasResults = false;
  //   notifyListeners();
  // }

  void setSearchResults(String searchQuery, Map<String, dynamic> results) {
    _searchQuery = searchQuery;
    _results = results;
    // _hasResults = true;
    print("검색 결과 세팅");
    notifyListeners();
  }

  void resetSearchResults() {
    _searchQuery = null;
    _results = null;
    // _hasResults = false;
    _goDetail = false;
    _mapController!.clearMarker();
    print("검색 리셋");
    notifyListeners();
  }

  void setGoDetail(Map<String, dynamic> detailInfo) {
    _goDetail = true;
    _detailInfo = detailInfo;
    notifyListeners();
  }

  void setIsFavorite(bool isFavorite) {
    _isFavorite = isFavorite;
  }

  void resetGoDetail() {
    _goDetail = false;
    _detailInfo = null;
    _isFavorite = null;
    notifyListeners();
  }
}