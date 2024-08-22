import 'package:durume_flutter/databases/favorite/favorite_provider.dart';
import 'package:durume_flutter/databases/search_history/search_history_provider.dart';
import 'package:flutter/material.dart';

class DatabaseModel with ChangeNotifier {
  SearchHistoryProvider? _searchHistoryProvider;
  FavoriteProvider? _favoriteProvider;

  SearchHistoryProvider? get searchHistoryProvider => _searchHistoryProvider;
  FavoriteProvider? get favoriteProvider => _favoriteProvider;

  void setSearchHistoryProvider(SearchHistoryProvider? searchHistoryProvider) {
    _searchHistoryProvider ??= searchHistoryProvider;
    notifyListeners();
  }

  // void deleteSearchHistory(int id) {
  //   if (_searchHistoryProvider != null) {
  //     _searchHistoryProvider!.deleteSearchHistory(id);
  //     notifyListeners();
  //   }
  // }
  //
  // void deleteAllSearchHistory() {
  //   if (_searchHistoryProvider != null) {
  //     _searchHistoryProvider!.deleteAllSearchHistory();
  //     notifyListeners();
  //   }
  // }

  void setFavoriteProvider(FavoriteProvider? favoriteProvider) {
    _favoriteProvider ??= favoriteProvider;
    notifyListeners();
  }
}