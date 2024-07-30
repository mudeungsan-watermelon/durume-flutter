import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/custom_bottom_sheet.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_btns.dart';
import 'package:durume_flutter/screens/home_screen/widgets/custom_drawer.dart';
import 'package:durume_flutter/screens/search_result_screen/search_result_screen.dart';
import 'package:durume_flutter/screens/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    AuthRepository.initialize(appKey: dotenv.env["KAKAO_JS_KEY"]!);
    // _bottomSheetController = AnimationController(
    //     vsync: this, duration: Duration(seconds: 2)
    // );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // late AnimationController _bottomSheetController;
  late MapModel mapModel;

  // 햄버거바 여닫기
  void _openDrawer() {
    _scaffoldKey.currentState!.openDrawer();
  }

  void _closeDrawer() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          KakaoMap(
            onMapCreated: ((controller) async {
              controller.clear();
              mapModel.setMapController(controller);
              // mapModel.setHomeMap();
              print("맵 생성*********************************************************************************************");
            }),
          ),
          // Navigator(
          //   onGenerateRoute: (settings) {
          //     WidgetBuilder builder;
          //     switch (settings.name) {
          //       case '/':
          //         builder = (BuildContext context) => HomeBtns(openDrawer: _openDrawer);
          //         break;
          //       case '/search':
          //         builder = (BuildContext context) => SearchScreen();
          //         break;
          //       case '/search_result':
          //         builder = (BuildContext context) => SearchResultScreen();
          //         break;
          //       default:
          //         throw Exception('유효하지 않은 루트 ${settings.name}');
          //     }
          //     return MaterialPageRoute(builder: (context) => builder(context));
          //     // return PageRouteBuilder(
          //     //   pageBuilder: (context, animation, secondaryAnimation) => builder(context),
          //     // );
          //   },
          // ),

          // mapModel.hasResults ?
          //   Text("검색결과 없음")
          //   : _HomeBtns(_openDrawer),
          // HomeBtns(openDrawer: _openDrawer),
        ]
      ),
      drawer: CustomDrawer(closeDrawer: _closeDrawer),
      // bottomSheet: mapModel.results != null ? CustomBottomSheet() : null
        // BottomSheet(
        //   builder: (context) => SearchResultModal(results: mapModel.results,),
        //   onClosing: () {
        //     mapModel.resetResults();
        //     mapModel.resetHasResults();
        //   },
        //   animationController: _bottomSheetController,
        //   showDragHandle: true,
        // ) : null,
    );
  }
}

// Widget _BottomSheet(BuildContext context, AnimationController controller) {
//   MapModel mapModel = Provider.of<MapModel>(context);
//
//   return BottomSheet(
//     onClosing: () {
//       mapModel.resetResults();
//       mapModel.resetHasResults();
//     },
//     builder: (context) => SearchResultModal(results: mapModel.results),
//     animationController: controller,
//     showDragHandle: true,
//   );
// }