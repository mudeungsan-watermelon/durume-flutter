import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_menu.dart';
import 'package:durume_flutter/screens/search_screen/search_screen.dart';
import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeSearchBar extends StatefulWidget {

  const HomeSearchBar({super.key,});

  @override
  State<HomeSearchBar> createState() => _HomeSearchBarState();
}

class _HomeSearchBarState extends State<HomeSearchBar> {

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    return Expanded(
      child: Container(
        decoration: basicBoxStyle(),
        height: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 19*widthRatio(context)),
                  child: mapModel.results == null ? GestureDetector(
                      onTap: () {
                        showHomeMenu(context);
                      },
                      child: Icon(Icons.menu, color: softBlack,)) :
                    GestureDetector(
                      onTap: (){
                        mapModel.resetSearchResults();
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                      },
                      child: Icon(Icons.chevron_left, color: softBlack),
                    ),
                ),
                Container(
                  child: mapModel.results == null ?
                    TextButton(
                      onPressed: (){
                        // 다른 페이지에서
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                      },
                      child: Text(
                        "어디로 떠나볼까요?",
                        style: TextStyle(color: softBlack, fontSize: 16),
                    ),) :
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Text(
                        mapModel.searchQuery!,
                        style: TextStyle(color: softBlack, fontSize: 16),
                      ),
                    ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(right: 19*widthRatio(context)),
              child: mapModel.results == null ? null :
                GestureDetector(
                  onTap: (){
                    mapModel.resetSearchResults();
                    mapModel.mapController!.clearMarker();
                  },
                  child: Icon(Icons.close, color: softBlack),
                ),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget _goBackBtn(context) {
//   return GestureDetector(
//     onTap: (){
//       mapModel.resetSearchResults();
//       Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
//     },
//     child: Icon(Icons.chevron_left, color: softBlack),
//   );
// }

// Widget _resetInputBtn(TextEditingController controller, VoidCallback resetInput) {
//   return GestureDetector(
//     onTap: () {
//       controller.clear();
//       resetInput();
//     },
//     child: const Icon(Icons.close),
//   );
// }