import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_search_bar.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/utils.dart';
import 'package:durume_flutter/widgets/filter_bar.dart';
import 'package:durume_flutter/widgets/floating_btn.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
                  const SizedBox(
                    height: 56,
                    child: HomeSearchBar(),
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
          Row(
            children: [
              FloatingBtn(
                tag: "place",
                icon: Symbols.my_location,
                onPressed: (KakaoMapController controller) async {
                  if (await Permission.location.isGranted) {
                    LatLng? location = await getLocation();
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
              ),
            ],
          )
        ],
      ),

    );
  }
}
