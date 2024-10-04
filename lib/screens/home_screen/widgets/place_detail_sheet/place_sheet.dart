import 'package:durume_flutter/screens/home_screen/widgets/bottom_sheet_widgets.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/place_overview.dart';
import 'package:flutter/material.dart';

class PlaceSheet extends StatelessWidget {
  const PlaceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: SizedBox(
        height: 270,
        child: Column(
          children: [
            CustomDragHandle,  // 드래그 정도에 따라 바꾸기
            PlaceOverview(),
          ],
        ),
      ),
    );
  }
}
