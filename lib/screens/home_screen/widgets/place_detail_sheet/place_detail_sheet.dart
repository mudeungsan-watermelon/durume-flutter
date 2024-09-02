import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/bottom_sheet_widgets.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/barrier_free_info_list.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/place_overview.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/review_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlaceDetailSheet extends StatelessWidget {
  PlaceDetailSheet({
    super.key,
    required this.isDragging,
  });

  bool isDragging;

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          CustomDragHandle,  // 드래그 정도에 따라 바꾸기
          SingleChildScrollView(  // 드래그 정도에 따라 내용 다르게
            child: Column(
              children: [
                PlaceOverview(),
                isDragging ? Container() : Column(
                  children: [
                    _DividerWithPadding(top: 7, bottom: 12),
                    BarrierFreeInfoList(),
                    _DividerWithPadding(top: 7, bottom: 12),
                    ReviewList()
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget _DividerWithPadding({double top = 0, double left = 0, double bottom = 0, double right = 0}) {
  return Padding(
    padding: EdgeInsets.only(top: top, left: left, bottom: bottom, right: right),
    child: Divider(),
  );
}


