import 'package:durume_flutter/providers/map_provider.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';

class SearchView extends StatelessWidget {
  Map<String, dynamic> results;
  // KakaoMapController mapController;

  SearchView({
    super.key,
    required this.results,
    // required this.mapController
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: SingleChildScrollView(
              child: Consumer<MapProvider>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      ...results['documents'].map((data) => GestureDetector(
                        onTap: (){
                          provider.mapController!.setCenter(
                              LatLng(double.parse(data["y"]), double.parse(data["x"]))
                          );
                        },
                        child: _SearchRecord(data['place_name'], data['road_address_name'], data['category_name']),
                      ))
                    ],
                  );
                },
                // child: Column(
                //   children: [
                //     ...results['documents'].map((data) => GestureDetector(
                //       onTap: (){
                //         mapController.setCenter(
                //             LatLng(double.parse(data["y"]), double.parse(data["x"]))
                //         );
                //       },
                //       child: _SearchRecord(data['place_name'], data['road_address_name'], data['category_name']),
                //     ))
                //   ],
                // ),
              ),
            ),
          ),
        )
    );
  }
}

Widget _SearchRecord(String title, String address, String category) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
    child: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.grey
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, overflow: TextOverflow.ellipsis),
            Text(address, overflow: TextOverflow.ellipsis),
            Row(
              children: [
                Text(category, overflow: TextOverflow.ellipsis),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
