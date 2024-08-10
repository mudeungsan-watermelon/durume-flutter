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