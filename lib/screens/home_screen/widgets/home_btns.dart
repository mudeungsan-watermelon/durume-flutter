import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_search_bar.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/widgets/filter_bar.dart';
import 'package:durume_flutter/widgets/floating_btn.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
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
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Column(  // 상단 요소
                children: [
                  SizedBox(
                    height: 56 * heightRatio(context),
                    child: Row(  // 검색창, AI 버튼
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        HomeSearchBar(openDrawer: openDrawer),
                        // _AIBtn()
                      ],
                    ),
                  ),
                  mapModel.results == null ? FilterBar() : Container(),
                ],
              ),
              Container(
                width: double.infinity,
                child: Column(  // 즐겨찾기, 거리뷰 버튼
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingBtn(tag: "star", icon: Icons.star,),
                    SizedBox(height: 12*heightRatio(context),),
                    FloatingBtn(tag: "view", icon: Icons.place),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(  // 하단 요소
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FloatingBtn(tag: "weather", icon: Icons.wb_sunny_outlined,),
                    SizedBox(height: 12*heightRatio(context),),
                    FloatingBtn(
                      tag: "place",
                      icon: Icons.my_location,
                      onPressed: (KakaoMapController controller) async {
                        if (await Permission.location.isGranted) {
                          LatLng? location = await _getLocation();
                          if (location == null) {
                            Fluttertoast.showToast(msg: "위치 정보를 가져올 수 없습니다.");
                          } else {
                            controller.setCenter(location);
                            controller.setLevel(3);
                          }
                        } else {
                          Fluttertoast.showToast(msg: "위치 권한을 허용해주세요.");
                        }
                      },
                      params: mapModel.mapController,
                    )
                  ],
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingBtn(tag: "AI", text: "AI", deepPurple: true,)
                  ],
                )
              ],
            ),
          )
        ],
      ),

    );
  }
}

// Widget _AIBtn(BuildContext context) {
//   return ElevatedButton(
//       onPressed: (){},
//       style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.grey,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(0)
//           )
//       ),
//       child: Container(
//           width: 48*widthRatio(context),
//           height: 48*heightRatio(context),
//           child: Text("AI")
//       )
//   );
// }

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
    return LatLng(position.latitude, position.longitude);
  } catch (e) {
    print("현재 위치 찾기 에러 ${e.toString()}");
    return null;
  }
}
