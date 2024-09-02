import 'package:durume_flutter/databases/favorite/favorite_provider.dart';
import 'package:durume_flutter/databases/search_history/search_history_provider.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/widgets/custom_bottom_sheet.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_btns.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/place_detail_sheet.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_result_sheet.dart';
import 'package:durume_flutter/screens/search_screen/search_screen.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool openHomeMenu = false;
  late AnimationController _animationController;
  final DraggableScrollableController sheetController = DraggableScrollableController();

  @override
  void initState() {
    AuthRepository.initialize(appKey: dotenv.env["KAKAO_JS_KEY"]!);

    final dbModel = Provider.of<DatabaseModel>(context, listen: false);
    dbModel.setSearchHistoryProvider(SearchHistoryProvider());
    dbModel.setFavoriteProvider(FavoriteProvider());
    // 애니메이션 컨트롤러
    _animationController = BottomSheet.createAnimationController(this);
    _animationController
      ..duration = const Duration(milliseconds: 500)
      ..reverseDuration = const Duration(milliseconds: 500);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    return PopScope(
      canPop: mapModel.results == null ? true : false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
        }
        mapModel.resetSearchResults();
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
            DraggableScrollableSheet(
              controller: sheetController,
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
                    child: PlaceDetailSheet(isDragging: false)
                  ),
                );
              },
            )
          ]
        ),
        // bottomSheet: BottomSheet(
        //   onClosing: (){},
        //   constraints: BoxConstraints(minHeight: 400, maxHeight: 800),
        //   showDragHandle: true,
        //   animationController: _animationController,
        //   enableDrag: true,
        //   onDragStart: (details) {
        //     print(details.globalPosition);
        //   },
        //   builder: (context) => Column(
        //     children: [
        //       Text("안녕")
        //     ],
        //   ),
        // ),
        // bottomSheet: CustomBottomSheet(
        //   lowLimit: 326,
        //   highLimit: 700,
        //   upThresh: 376,
        //   boundary: 500,
        //   downThresh: 650,
        //   childWidget: const PlaceDetailSheet(),
        // ),
        // bottomSheet: mapModel.results != null ?
        //   CustomBottomSheet(
        //     lowLimit: 300,
        //     highLimit: 600,
        //     upThresh: 350,
        //     boundary: 500,
        //     downThresh: 550,
        //     childWidget: const SearchResultSheet(),
        //   ) : mapModel.goDetail ?
        //   CustomBottomSheet(
        //     lowLimit: 326,
        //     highLimit: 800,
        //     upThresh: 376,
        //     boundary: 500,
        //     downThresh: 750,
        //     childWidget: const PlaceDetailSheet(),
        //   ) : null
      ),
    );
  }
}
