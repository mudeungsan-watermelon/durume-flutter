import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/bottom_sheet_widgets.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_result_sheet/search_result_list.dart';
import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SearchResultSheet extends StatelessWidget {
  // final Map<String, dynamic>? results;
  final ScrollController scrollController;

  const SearchResultSheet({
    super.key,
    required this.scrollController,
    // this.results,
  });

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    return Container(
      decoration: basicBoxStyle(borderRadius: 28, borderDirectional: true),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: CustomDragHandle,
            ),
            SliverAppBar(
              primary: false,
              pinned: true,
              floating: true,
              elevation: 0,
              forceMaterialTransparency: true,
              // centerTitle: false,
              flexibleSpace: Container(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: _SearchResultHeader(),
                ),
              ),
            ),
            SearchResultList(),
          ],
        ),
      ),
    );

    // return Padding(
    //   padding: const EdgeInsets.all(8),
    //   child: Column(
    //     children: [
    //       mapModel.results != null ? SearchView(results: mapModel.results!) : Text("검색결과 없음")
    //     ],
    //   ),
    // );
  }
}

Widget _SearchResultHeader() {
// Widget _ViewHeader(KakaoMapController mapController, String query) {
  return Column(
    children: [
      Row(
        children: [
          TextButton(
            onPressed: () async {
              // 현재 지도의 중심 위치를 가져와 검색
              // LatLng latlng = await mapController.getCenter();
              // Map<String, dynamic>? results = await searchPlace(query, latlng, mapController);
              // if (results != null) {
              //
              //
              // }
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text("• 현재 지도 중심", style: TextStyle(fontSize: 14, color: softGrey),)
          ),
          SizedBox(width: 12,),
          TextButton(
            onPressed: () async {
              // 내 위치를 가져온 후 검색
              // LatLng center = await getLocation();
            },
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: Text("• 내 위치 중심", style: TextStyle(fontSize: 14, color: softGrey),)
          ),
        ],
      ),
      SizedBox(height: 12,),
      Divider(height: 0)
    ],
  );
}
