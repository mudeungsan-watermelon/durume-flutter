import 'package:durume_flutter/databases/favorite/favorite.dart';
import 'package:durume_flutter/databases/favorite/favorite_provider.dart';
import 'package:durume_flutter/databases/search_history/search_history_provider.dart';
import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/bottom_sheet_widgets.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/place_sheet.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/review_list.dart';
import 'package:durume_flutter/utils/bottom_sheet.dart';
import 'package:durume_flutter/screens/home_screen/widgets/home_btns.dart';
import 'package:durume_flutter/screens/search_screen/search_screen.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/utils.dart';
import 'package:durume_flutter/widgets/custom_bottom_sheet.dart';
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

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isDragged = false;  // 지도가 드래그 되었는지 refreshSearchBtn

  final DraggableScrollableController searchResultSheetController = DraggableScrollableController();
  final DraggableScrollableController placeDetailSheetController = DraggableScrollableController();
  final GlobalKey customScrollViewKey = GlobalKey();
  // const Key centerKey = ValueKey<String>('bottom-sliver-list');

  @override
  void initState() {
    AuthRepository.initialize(appKey: dotenv.env["KAKAO_JS_KEY"]!);

    final dbModel = Provider.of<DatabaseModel>(context, listen: false);
    dbModel.setSearchHistoryProvider(SearchHistoryProvider());
    dbModel.setFavoriteProvider(FavoriteProvider());

    placeDetailSheetController.addListener(() {
      if (placeDetailSheetController.size > 0.8) {
        showPlaceDetailDialog(context);
        placeDetailSheetController.animateTo(0.32, duration: Duration(milliseconds: 500), curve: Curves.linear);
      }
    });
    super.initState();
  }

  void setIsDragged(bool value) {
    setState(() {
      isDragged = value;
    });
  }

  @override
  void dispose() {
    placeDetailSheetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    DatabaseModel dbModel = Provider.of<DatabaseModel>(context);
    return PopScope(
      canPop: mapModel.results == null ? true : false,
      onPopInvoked: (didPop) {
        if (!didPop && mapModel.results == null) {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
        }
        if (mapModel.detailInfo != null) {  // 장소 세부 -> 장소 리스트
          mapModel.resetGoDetail();
        } else {
          mapModel.resetSearchResults();  // 장소 리스트 -> 홈 화면
          setIsDragged(false);
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
                // 즐겨찾기 목록 가져와서 저장해놓기
                setFavoriteMarkers(dbModel, mapModel);
                // List<Favorite>? favorites = await dbModel.favoriteProvider!.getFavorite();
                // mapModel.setFavoriteMarkers({
                //   ...favorites.map((e) => Marker(
                //       markerId: e.placeId,
                //       latLng: e.position,
                //       markerImageSrc: favoriteMarkerImgUrl,
                //       width: 38,
                //       height: 38,
                //   ))
                // });
              }),
              onDragChangeCallback: (latlng, zoomLevel, dragType) {
                if (mapModel.results != null && mapModel.detailInfo == null) {
                  setIsDragged(true);
                }
              },
            ),
            // 현재 위치에서 검색 버튼 활성화
            isDragged ? Container() : Container(),
            // 검색 결과
            mapModel.results == null ?
              Padding(
                padding: EdgeInsets.fromLTRB(12, MediaQuery.of(context).padding.top+8, 12, 12),
                child: HomeBtns(),) :
              mapModel.goDetail ? PlaceScrollableSheet(placeDetailSheetController) :
                SearchResultScrollableSheet(searchResultSheetController),
          ]
        ),
      ),
    );
  }
}
