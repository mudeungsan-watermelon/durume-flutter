import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_search_bar.dart';
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
    return Column(
      children: [
        Column(  // 상단 요소
          children: [
            const SizedBox(
              height: 56,
              child: HomeSearchBar(),
            ),
            mapModel.results == null ? const FilterBar() : const SizedBox(height: 12,),
          ],
        ),
        mapModel.results == null ? SizedBox(
          width: double.infinity,
          child: Column(  // 즐겨찾기, 거리뷰 버튼
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 8,),
              FloatingBtn(
                tag: "star",
                icon: Symbols.favorite,
                isFilled: mapModel.showFavorites,
                onPressed: () {
                  if (mapModel.showFavorites) {
                    // 마커 가리기
                    mapModel.mapController!.clearMarker();
                    mapModel.mapController!.clearCustomOverlay();
                    mapModel.setShowFavorites(false);
                  } else {
                    if (mapModel.favoriteMarkers == null) {
                      Fluttertoast.showToast(msg: "저장된 즐겨찾기가 없습니다.");
                    } else {
                      // 마커 보여주기
                      mapModel.mapController!.addMarker(markers: mapModel.favoriteMarkers!.toList());
                      // mapModel.mapController!.addCustomOverlay(customOverlays: mapModel.favoriteOverlays!.toList());
                      mapModel.setShowFavorites(true);
                    }
                  }
                },
              ),
              const SizedBox(height: 12,),
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
          ),
        ) : Container(),
      ],
    );
  }
}
