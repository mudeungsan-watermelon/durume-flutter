import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/place_sheet.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/review_list.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_result_sheet/search_result_sheet.dart';
import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

Widget SearchResultScrollableSheet(DraggableScrollableController controller) {
  return DraggableScrollableSheet(
    builder: (BuildContext context, scrollController) {
      return SearchResultSheet(scrollController: scrollController);
    }
  );
}

Widget PlaceScrollableSheet(DraggableScrollableController controller) {
  return DraggableScrollableSheet(
    controller: controller,
    initialChildSize: 0.32,
    minChildSize: 0.32,
    maxChildSize: 1,
    snap: true,
    builder: (BuildContext context, scrollController) {
      // bool isDragging = scrollController.position.isScrollingNotifier.value;
      return SingleChildScrollView(
        controller: scrollController,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: basicBoxStyle(borderDirectional: true),
          child: const PlaceSheet(),
        ),
      );
    },
  );
}

Widget ReviewOverView() {
  return Row(
    children: [
      Row(
        children: [
          Icon(Symbols.kid_star, fill: 1, color: primaryColor, size: 20,),
          const SizedBox(width: 6,),
          Text("4.48", style: TextStyle(fontSize: 16, color: textBlack),),
        ],
      ),
      const SizedBox(width: 8,),
      Text("·", style: TextStyle(fontSize: 16, color: textBlack),),
      const SizedBox(width: 8,),
      Text("리뷰 12개", style: TextStyle(fontSize: 16, color: textBlack),)
    ],
  );
}

Widget CustomDragHandle = Padding(
  padding: const EdgeInsets.symmetric(vertical: 16),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 40,
        height: 5,
        decoration: BoxDecoration(
            color: softGrey,
            borderRadius: BorderRadius.circular(100)
        ),
      )
    ],
  ),
);
