import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/custom_bottom_sheet.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_btns.dart';
import 'package:durume_flutter/screens/search_screen/search_screen.dart';
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
              }),
              customOverlays: mapModel.results != null ? [
                ...mapModel.results!["documents"].map((d) => CustomOverlay(
                customOverlayId: d["id"],
                latLng: LatLng(double.parse(d["y"]), double.parse(d["x"])),
                content: '<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,400,0,0" />'
                ))
              ] : null,
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
