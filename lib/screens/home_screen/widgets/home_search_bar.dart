import 'package:durume_flutter/models/map_model.dart';
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
    return Container(
      decoration: basicBoxStyle(),
      height: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 19),
                child: mapModel.results == null ? Image.asset(
                    "assets/images/app_icon_wh.png",
                    fit: BoxFit.fitHeight,
                    height: 22,
                  ) :
                  GestureDetector(
                    onTap: (){
                      mapModel.resetSearchResults();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchScreen()));
                    },
                    child: Icon(Icons.chevron_left, color: softBlack),
                  ),
              ),
              Container(
                child: mapModel.results == null ?
                  TextButton(
                    onPressed: (){
                      // 다른 페이지에서
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (BuildContext context, Animation<double> animation1, Animation<double> animation2){
                            return const SearchScreen();
                          },
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero
                        )
                      );
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
            padding: const EdgeInsets.only(right: 19),
            child: mapModel.results == null ? null :
              GestureDetector(
                onTap: (){
                  mapModel.resetSearchResults();
                },
                child: Icon(Icons.close, color: softBlack),
              ),
          ),
        ],
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
