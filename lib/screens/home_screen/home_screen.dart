import 'package:durume_flutter/databases/favorite/favorite_provider.dart';
import 'package:durume_flutter/databases/search_history/search_history_provider.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_btns.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/place_scrollable_sheet.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_result_sheet/search_result_scrollable_sheet.dart';
import 'package:durume_flutter/screens/search_screen/search_screen.dart';
import 'package:durume_flutter/utils/gemini_model_utils.dart';
import 'package:durume_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
  final GlobalKey customScrollViewKey = GlobalKey();

  @override
  void initState() {
    AuthRepository.initialize(appKey: dotenv.env["KAKAO_JS_KEY"]!);

    final dbModel = Provider.of<DatabaseModel>(context, listen: false);
    dbModel.setSearchHistoryProvider(SearchHistoryProvider());
    dbModel.setFavoriteProvider(FavoriteProvider());

    final mapModel = Provider.of<MapModel>(context, listen: false);
    Map<String, dynamic>? gemini = getGeminiChatSession(dotenv.env["GOOGLE_API_KEY"]);
    if (gemini != null) {
      mapModel.setGeminiChatSession(gemini["chatSession"]);
      mapModel.setGeminiModel(gemini["geminiModel"]);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    DatabaseModel dbModel = Provider.of<DatabaseModel>(context);
    return PopScope(
      canPop: mapModel.results == null && mapModel.detailInfo == null ? true : false,
      onPopInvoked: (didPop) {
        if (!didPop) {  // canPop이 false인 상태
          if (mapModel.detailInfo != null) {  // 장소 세부 -> 장소 리스트
            mapModel.resetDetailInfo();
          } else {
            mapModel.resetSearchResults();  // 장소 리스트 -> 홈 화면
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
          }
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
                    controller.setCenter(location);
                    controller.setLevel(3);
                  }
                } else {
                  // 지도 켰을 때 한국장애인재단
                  controller.setCenter(LatLng(37.56315965738672, 126.96955322879208));
                }
                // 즐겨찾기 목록 가져와서 저장해놓기
                setFavoriteMarkers(dbModel, mapModel);
                FlutterNativeSplash.remove();
              }),
              onMarkerTap: (markerId, latLng, zoomLevel) async {
                // 장소 디테일 시트 보이게 하기
                String id = markerId.split("~")[0];
                String query = markerId.split("~").skip(1).join('');
                Map<String, dynamic>? detailInfo = await findPlaceById(query, id, latLng);
                if (detailInfo != null) mapModel.setDetailInfo(detailInfo);
                mapModel.mapController!.setCenter(latLng);
              },
            ),
            const HomeBtns(),
            // 검색 결과
            mapModel.detailInfo != null ? const PlaceScrollableSheet() :
              mapModel.results == null ? Container() :
                SearchResultScrollableSheet(),
          ]
        ),
      ),
    );
  }
}
