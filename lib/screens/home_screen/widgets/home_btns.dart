import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_search_bar.dart';
import 'package:durume_flutter/widgets/filter_bar.dart';
import 'package:durume_flutter/widgets/floating_btn.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';

class HomeBtns extends StatelessWidget {
  final VoidCallback openDrawer;

  const HomeBtns({
    super.key,
    required this.openDrawer,
  });

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Column(  // 상단 요소
                  children: [
                    const SizedBox(height: 24,),
                    SizedBox(
                      height: 52,
                      child: Row(  // 검색창, AI 버튼
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          HomeSearchBar(openDrawer: openDrawer),
                          _AIBtn()
                        ],
                      ),
                    ),
                    FilterBar(),
                  ],
                ),
                Container(
                  width: double.infinity,
                  child: const Column(  // 즐겨찾기, 거리뷰 버튼
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FloatingBtn(tag: "star", icon: Icons.star,),
                      FloatingBtn(tag: "view", icon: Icons.place),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              child: Column(  // 하단 요소
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  FloatingBtn(tag: "weather", icon: Icons.sunny,),
                  FloatingBtn(
                    tag: "place",
                    icon: Icons.my_location,
                    onPressed: (controller) async {
                      LatLng? location = await _getLocation();
                      if (location == null) {
                        // 표시 불가 토스트
                      } else {
                        // mapModel.setCenter(location);
                      }
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget _AIBtn() {
  return ElevatedButton(
      onPressed: (){},
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          minimumSize: Size(35, double.infinity),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0)
          )
      ),
      child: Text("AI")
  );
}

void _pressMyLocationBtn() async {
  LatLng? location = await _getLocation();
  if (location == null) {
    // 표시 불가 토스트
  } else {
    // mapModel.setCenter(location);
  }
}

Future _getLocation() async {
  print("현재 위치 찾기");
  try {
    Position? position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return LatLng(position.altitude, position.longitude);
  } catch (e) {
    print("현재 위치 찾기 에러 ${e.toString()}");
    return null;
  }
}
