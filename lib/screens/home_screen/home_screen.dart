import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_search_bar.dart';
import 'package:durume_flutter/screens/home_screen/widgets/custom_drawer.dart';
import 'package:durume_flutter/widgets/filter_bar.dart';
import 'package:durume_flutter/widgets/floating_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    AuthRepository.initialize(appKey: dotenv.env["KAKAO_JS_KEY"]!);
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
            }),
          ),
          _HomeBtns(_openDrawer),
        ]
      ),
      drawer: CustomDrawer(closeDrawer: _closeDrawer),
    );
  }
}

Widget _HomeBtns(VoidCallback openDrawer) {
  return Padding(
    padding: EdgeInsets.all(8.0),
    child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Column(  // 상단 요소
                children: [
                  const SizedBox(height: 24,),
                  SizedBox(
                    height: 52,
                    child: Row(  // 검색창, AI 버튼
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        HomeSearchBar(openDrawer: openDrawer),
                        _AIBtn()
                      ],
                    ),
                  ),
                  FilterBar(),
                ],
              ),
              Container(
                width: double.infinity,
                child: const Column(  // 즐겨찾기, 거리뷰 버튼
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FloatingBtn(tag: "star", icon: Icons.star,),
                    FloatingBtn(tag: "view", icon: Icons.place),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            child: const Column(  // 하단 요소
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                FloatingBtn(tag: "weather", icon: Icons.sunny,),
                FloatingBtn(tag: "place", icon: Icons.my_location,)
              ],
            ),
          )
        ],
      ),
    ),
  );
}

Widget _AIBtn() {
  return ElevatedButton(
      onPressed: (){},
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          minimumSize: Size(35, double.infinity),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(0)
          )
      ),
      child: Text("AI")
  );
}
