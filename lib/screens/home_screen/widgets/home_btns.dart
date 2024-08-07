import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_search_bar.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/widgets/filter_bar.dart';
import 'package:durume_flutter/widgets/floating_btn.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeBtns extends StatelessWidget {

  const HomeBtns({super.key,});

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
                        HomeSearchBar(),
                      ],
                    ),
                  ),
                  mapModel.results == null ? FilterBar() : SizedBox(height: 12*heightRatio(context),),
                ],
              ),
              Container(
                width: double.infinity,
                child: Column(  // 즐겨찾기, 거리뷰 버튼
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    FloatingBtn(
                      tag: "star",
                      icon: Symbols.favorite,
                      onPressed: () {
                        Fluttertoast.showToast(msg: "개발예정입니다☺️");
                      },
                    ),
                    SizedBox(height: 12*heightRatio(context),),
                    FloatingBtn(
                      tag: "view",
                      icon: Symbols.nest_cam_indoor,
                      onPressed: () {
                        Fluttertoast.showToast(msg: "개발예정입니다☺️");
                      },
                    ),
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
                    FloatingBtn(
                      tag: "weather",
                      icon: Symbols.clear_day,
                      onPressed: () {
                        Fluttertoast.showToast(msg: "개발예정입니다☺️");
                      },
                    ),
                    SizedBox(height: 12*heightRatio(context),),
                    FloatingBtn(
                      tag: "place",
                      icon: Symbols.my_location,
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FloatingBtn(
                      tag: "AI",
                      text: "AI",
                      deepPurple: true,
                      onPressed: () {
                        Fluttertoast.showToast(msg: "개발예정입니다☺️");
                      },
                    )
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
