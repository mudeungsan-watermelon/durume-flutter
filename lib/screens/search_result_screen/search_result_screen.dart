import 'package:durume_flutter/screens/home_screen/widgets/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      bottomSheet: CustomBottomSheet(),
    );
  }
}

// Future _showSearchResultsBottomModal(
//     BuildContext context,
//     Map<String, dynamic>? results,
//     KakaoMapController? mapController
//   ) {
//   return showModalBottomSheet(
//       context: context,
//       builder: (context) => SearchResultModal(
//           results: results,
//         // mapController: mapController,
//       ),
//       enableDrag: true,
//       isScrollControlled: true,
//       isDismissible: false,  // 바텀시트 아닌 부분 클릭시 닫을지
//       showDragHandle: true,
//       backgroundColor: Colors.white,
//       barrierColor: Colors.transparent,
//       constraints: const BoxConstraints(
//         maxHeight: 200,
//         minWidth: double.infinity,
//       )
//   );
// }
