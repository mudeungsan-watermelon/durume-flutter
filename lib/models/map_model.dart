import 'package:durume_flutter/databases/favorite/favorite.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MapModel with ChangeNotifier {
  KakaoMapController? _mapController;
  // Set<Marker> _markers = {};

  String? _searchQuery;
  Map<String, dynamic>? _results;
  ScrollController? _searchResultController;

  Map<String, dynamic>? _detailInfo;
  bool _goDetail = false;
  Map<String, dynamic>? _barrierFreeInfo;

  List<Favorite>? _favoriteList;
  Set<Marker>? _favoriteMarkers;
  // Set<CustomOverlay>? _favoriteOverlays;
  bool _showFavorites = false;
  bool? _isFavorite;

  // GenerativeModel? _geminiModel;
  ChatSession? _geminiChatSession;

  KakaoMapController? get mapController => _mapController;
  // Set<Marker> get markers => _markers;

  String? get searchQuery => _searchQuery;
  Map<String, dynamic>? get results => _results;
  ScrollController? get searchResultController => _searchResultController;

  Map<String, dynamic>? get detailInfo => _detailInfo;
  bool get goDetail => _goDetail;
  Map<String, dynamic>? get barrierFreeInfo => _barrierFreeInfo;

  List<Favorite>? get favoriteList => _favoriteList;
  Set<Marker>? get favoriteMarkers => _favoriteMarkers;
  // Set<CustomOverlay>? get favoriteOverlays => _favoriteOverlays;
  bool get showFavorites => _showFavorites;
  bool? get isFavorite => _isFavorite;

  // GenerativeModel? get geminiModel => _geminiModel;
  ChatSession? get geminiChatSession => _geminiChatSession;

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

  void setSearchResultController(ScrollController searchResultController) {
    _searchResultController = searchResultController;
    print("컨트롤러 세팅");
    // notifyListeners();
  }

  void resetSearchResults() {
    _searchQuery = null;
    _results = null;
    _detailInfo = null;
    _searchResultController = null;
    if (showFavorites) {
      _mapController!.addMarker(markers: _favoriteMarkers!.toList());
      // _mapController!.addCustomOverlay(customOverlays: _favoriteOverlays!.toList());
    } else {
      _mapController!.clearMarker();
      // _mapController!.clearCustomOverlay();
    }
    print("검색 리셋");
    notifyListeners();
  }

  void setDetailInfo(Map<String, dynamic> detailInfo) {
    _detailInfo = detailInfo;
    notifyListeners();
  }

  void resetDetailInfo() {
    _detailInfo = null;
    _isFavorite = null;
    _barrierFreeInfo = null;
    _goDetail = false;
    notifyListeners();
  }

  void setBarrierFreeInfo(Map<String, dynamic>? barrierFreeInfo) {
    _barrierFreeInfo = barrierFreeInfo;
    notifyListeners();
  }

  void setGoDetail() {
    _goDetail = true;
  }

  void resetGoDetail() {
    _goDetail = false;
  }

  void setFavoriteMarkers(Set<Marker> favoriteMarkers) {
    _favoriteMarkers = favoriteMarkers;
    // _favoriteOverlays = favoriteOverlays;
    notifyListeners();
  }

  void setShowFavorites(bool showFavorites) {
    _showFavorites = showFavorites;
    notifyListeners();
  }

  void setIsFavorite(bool isFavorite) {
    _isFavorite = isFavorite;
  }

  void setGeminiChatSession(ChatSession? geminiChatSession) {
    _geminiChatSession = geminiChatSession;
  }

  // void setGeminiModel(GenerativeModel? geminiModel) {
  //   _geminiModel = geminiModel;
  // }
}