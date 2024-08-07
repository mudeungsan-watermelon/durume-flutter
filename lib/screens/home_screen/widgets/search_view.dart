import 'package:durume_flutter/models/map_model.dart';
import 'package:flutter/material.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
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
              child: Consumer<MapModel>(
                builder: (context, provider, child) {
                  return Column(
                    children: [
                      ...results['documents'].map((data) => Column(
                        children: [
                          GestureDetector(
                            onTap: (){
                              provider.mapController!.setCenter(
                                  LatLng(double.parse(data["y"]), double.parse(data["x"]))
                              );
                              provider.mapController!.setLevel(3);
                            },
                            child: _SearchRecord(data['place_name'], data['road_address_name'], data['category_name']),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Divider(),
                          )
                        ],
                      ))
                    ],
                  );
                },
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
        // color: Colors.grey
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(Icons.location_on_outlined),
            SizedBox(width: 12,),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 16), maxLines: 1,),
                Text(address, overflow: TextOverflow.ellipsis, style: TextStyle(fontSize: 14), maxLines: 1,),
                // Row(
                //   children: [
                //     Text(category, overflow: TextOverflow.ellipsis),
                //   ],
                // )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
