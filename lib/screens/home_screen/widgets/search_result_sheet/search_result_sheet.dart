import 'package:durume_flutter/screens/home_screen/widgets/bottom_sheet_widgets.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_result_sheet/search_result_list.dart';
import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';

class SearchResultSheet extends StatelessWidget {
  final ScrollController scrollController;

  const SearchResultSheet({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
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
            const SearchResultList(),
          ],
        ),
      ),
    );
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
