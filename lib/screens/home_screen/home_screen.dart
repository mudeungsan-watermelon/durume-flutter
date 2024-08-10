import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/custom_bottom_sheet.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_btns.dart';
import 'package:durume_flutter/screens/search_screen/search_screen.dart';
import 'package:durume_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
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
  late MapModel mapModel;
  bool openHomeMenu = false;

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    return PopScope(
      canPop: mapModel.results == null ? true : false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          mapModel.resetSearchResults();
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            KakaoMap(
              onMapCreated: ((controller) async {
                controller.clear();
                mapModel.setMapController(controller);
                print("맵 생성*********************************************************************************************");
                if (await Permission.location.isGranted) {
                  LatLng? location = await getLocation();
                  if (location == null) {
                    // 지도 켰을 때 한국장애인재단
                    controller.setCenter(LatLng(37.56315965738672, 126.96955322879208));
                  } else {
                    // 나중에 바꾸기
                    // controller.setCenter(location);
                    // controller.setLevel(3);
                    controller.setCenter(LatLng(37.56315965738672, 126.96955322879208));
                  }
                } else {
                  // 지도 켰을 때 한국장애인재단
                  controller.setCenter(LatLng(37.56315965738672, 126.96955322879208));
                }
              }),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(12, MediaQuery.of(context).padding.top+8, 12, 12),
              child: HomeBtns(),
            ),
          ]
        ),
        bottomSheet: mapModel.results == null ? null : CustomBottomSheet()
      ),
    );
  }
}
