class SearchHistory {
  int? id;
  String query;

  SearchHistory({this.id, required this.query});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'query': query,
    };
  }
}