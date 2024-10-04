import 'package:durume_flutter/databases/favorite/favorite.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MapModel with ChangeNotifier {
  KakaoMapController? _mapController;
  // Set<Marker> _markers = {};

  String? _searchQuery;
  Map<String, dynamic>? _results;
  Map<String, dynamic>? _detailInfo;

  List<Favorite>? _favoriteList;
  Set<Marker>? _favoriteMarkers;
  Set<CustomOverlay>? _favoriteOverlays;
  bool _showFavorites = false;
  bool? _isFavorite;

  GenerativeModel? _geminiModel;

  KakaoMapController? get mapController => _mapController;
  // Set<Marker> get markers => _markers;

  String? get searchQuery => _searchQuery;
  Map<String, dynamic>? get results => _results;
  Map<String, dynamic>? get detailInfo => _detailInfo;

  List<Favorite>? get favoriteList => _favoriteList;
  Set<Marker>? get favoriteMarkers => _favoriteMarkers;
  Set<CustomOverlay>? get favoriteOverlays => _favoriteOverlays;
  bool get showFavorites => _showFavorites;
  bool? get isFavorite => _isFavorite;

  GenerativeModel? get geminiModel => _geminiModel;

  void setMapController(KakaoMapController? mapController) {
    _mapController = mapController;
    print("맵 컨트롤러 세팅");
    notifyListeners();
  }

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
    _detailInfo = null;
    if (showFavorites) {
      _mapController!.addMarker(markers: _favoriteMarkers!.toList());
      _mapController!.addCustomOverlay(customOverlays: _favoriteOverlays!.toList());
    } else {
      _mapController!.clearMarker();
      _mapController!.clearCustomOverlay();
    }
    print("검색 리셋");
    notifyListeners();
  }

  void setGoDetail(Map<String, dynamic> detailInfo) {
    _detailInfo = detailInfo;
    notifyListeners();
  }

  void resetGoDetail() {
    _detailInfo = null;
    _isFavorite = null;
    notifyListeners();
  }

  void setFavoriteMarkers(Set<Marker> favoriteMarkers, Set<CustomOverlay> favoriteOverlays) {
    _favoriteMarkers = favoriteMarkers;
    _favoriteOverlays = favoriteOverlays;
    notifyListeners();
  }

  void setShowFavorites(bool showFavorites) {
    _showFavorites = showFavorites;
    notifyListeners();
  }

  void setIsFavorite(bool isFavorite) {
    _isFavorite = isFavorite;
  }

  void setGeminiModel(GenerativeModel? geminiModel) {
    _geminiModel = geminiModel;
  }
}