import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/bottom_sheet_widgets.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/barrier_free_info_list.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/place_overview.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/review_list.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class PlaceDetailSheet extends StatelessWidget {
  const PlaceDetailSheet({super.key,});

  @override
  Widget build(BuildContext context) {
    // MapModel mapModel = Provider.of<MapModel>(context);
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50),
                PlaceOverview(),
                Column(
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
        ),
        Container(
          height: 50,
          color: Colors.white,
          child: Column(
            children: [
              SizedBox(height: 8,),
              Row(
                children: [
                  SizedBox(width: 24,),
                  IconButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      visualDensity: VisualDensity.compact,
                      padding: EdgeInsets.zero,
                      icon: Icon(Symbols.keyboard_arrow_down, size: 36, color: Color(0xff1c1b1f),)
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

Widget _DividerWithPadding({double top = 0, double left = 0, double bottom = 0, double right = 0}) {
  return Padding(
    padding: EdgeInsets.only(top: top, left: left, bottom: bottom, right: right),
    child: Divider(),
  );
}


