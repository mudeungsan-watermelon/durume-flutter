import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/bottom_sheet_widgets.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class SearchResultList extends StatelessWidget {
  // Map<String, dynamic> results;
  // KakaoMapController mapController;

  const SearchResultList({
    super.key,
    // required this.results,
    // required this.mapController
  });

  // Future _centerSearch(KakaoMapController mapController, String query) async {
  //   LatLng latLng = await mapController.getCenter();
  //   Map<String, dynamic>? values = await searchPlace(query, latLng, mapController);
  //   if (results != null) {
  //     if (results["documents"] != []) {
  //
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // MapModel mapModel = Provider.of<MapModel>(context);
    //
    // Future _centerSearch(String query) async {
    //   LatLng latLng = await mapModel.mapController!.getCenter();
    //   Map<String, dynamic>? values = await searchPlace(query, latLng, mapModel.mapController!);
    //   if (values != null) {
    //     if (values["documents"] != []) {
    //       mapModel.setSearchResults(query, values);
    //       Navigator.pop(context);
    //     }
    //   }
    // }
    return SliverList.list(
      children: [
        Consumer<MapModel>(
          builder: (context, provider, child) {
            return Column(
              children: [
                ...provider.results!['documents'].map((data) => Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        provider.mapController!.setCenter(
                            LatLng(double.parse(data["y"]), double.parse(data["x"]))
                        );
                        provider.mapController!.setLevel(3);
                        // 장소 디테일 바텀시트 띄우기
                        provider.setGoDetail(data);
                      },
                      child: _SearchRecord(data['place_name'], data['road_address_name'], data['category_name']),
                    ),
                    Divider()
                  ],
                ))
              ],
            );
          },
        )
      ]
    );
  }
}

Widget _SearchRecord(String title, String address, String category) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0),
    child: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        // color: Colors.grey
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 18, color: primaryColor),
                  maxLines: 1,
                ),
                const SizedBox(width: 8,),
                Text(
                  "카테고리",
                  style: TextStyle(fontSize: 14, color: softGrey),
                )
              ],
            ),
            Text(
              address,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16, color: softGrey),
              maxLines: 1,
            ),
            ReviewOverView(),
            // Row(
            //   children: [
            //     Text(category, overflow: TextOverflow.ellipsis),
            //   ],
            // )
          ],
        ),
      ),
    ),
  );
}
