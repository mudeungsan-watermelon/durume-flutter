import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class Favorite {
  int? id;
  String placeId;
  String name;
  LatLng position;

  Favorite({this.id, required this.placeId, required this.name, required this.position});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place_id': placeId,
      'name': name,
      'x': position.longitude.toString(),
      'y': position.latitude.toString(),
    };
  }
}