import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/place_detail_sheet.dart';
import 'package:flutter/material.dart';

// Future showSearchResultDialog(BuildContext context) {
//   return showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return Dialog.fullscreen(
//         backgroundColor: Colors.white,
//         child: Container(),
//       );
//     }
//   );
// }

Future showPlaceDetailDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return const Dialog.fullscreen(
          backgroundColor: Colors.white,
          child: PlaceDetailSheet(),
        );
      }
  );
}