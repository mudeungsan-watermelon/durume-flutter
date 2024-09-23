import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:kakao_map_plugin/kakao_map_plugin.dart';

class MapModel with ChangeNotifier {
  KakaoMapController? _mapController;
  // NaverMapController? _mapController;
  Set<Marker> _markers = {};
  LatLng? _center;
  int _zoomLevel = 3;

  String? _searchQuery;
  Map<String, dynamic>? _results;
  // Map<String, dynamic>? _results = {
  //   "documents": [
  //     {
  //       "address_name": "부산 부산진구 전포동 692-3",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 일식",
  //       "distance": "",
  //       "id": "1588146512",
  //       "phone": "051-802-9206",
  //       "place_name": "소코아",
  //       "place_url": "http://place.map.kakao.com/1588146512",
  //       "road_address_name": "부산 부산진구 동천로 56",
  //       "x": "129.062644532665",
  //       "y": "35.15355658298"
  //     },
  //     {
  //       "address_name": "서울 마포구 서교동 411-12",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 일식",
  //       "distance": "",
  //       "id": "1426286680",
  //       "phone": "070-8867-2510",
  //       "place_name": "소코아 홍대점",
  //       "place_url": "http://place.map.kakao.com/1426286680",
  //       "road_address_name": "서울 마포구 와우산로15길 49",
  //       "x": "126.920962389879",
  //       "y": "37.5486445850724"
  //     },
  //     {
  //       "address_name": "광주 서구 치평동 1216-2",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 일식",
  //       "distance": "",
  //       "id": "251024408",
  //       "phone": "070-4413-5955",
  //       "place_name": "소코아 상무점",
  //       "place_url": "http://place.map.kakao.com/251024408",
  //       "road_address_name": "광주 서구 상무중앙로 86",
  //       "x": "126.848916144858",
  //       "y": "35.1544975614608"
  //     },
  //     {
  //       "address_name": "광주 광산구 수완동 1759",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 일식 > 일식집",
  //       "distance": "",
  //       "id": "320296058",
  //       "phone": "",
  //       "place_name": "소코아 수완점",
  //       "place_url": "http://place.map.kakao.com/320296058",
  //       "road_address_name": "광주 광산구 수완로14번길 19",
  //       "x": "126.829341950009",
  //       "y": "35.1867004826303"
  //     },
  //     {
  //       "address_name": "서울 서대문구 창천동 72-22",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 일식",
  //       "distance": "",
  //       "id": "1433588298",
  //       "phone": "02-6954-2007",
  //       "place_name": "소코아 신촌점",
  //       "place_url": "http://place.map.kakao.com/1433588298",
  //       "road_address_name": "서울 서대문구 신촌로 63",
  //       "x": "126.933756344131",
  //       "y": "37.5566100693151"
  //     },
  //     {
  //       "address_name": "경기 의왕시 내손동 667-13",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 일식",
  //       "distance": "",
  //       "id": "556737022",
  //       "phone": "070-8803-2276",
  //       "place_name": "소코아 경기내손점",
  //       "place_url": "http://place.map.kakao.com/556737022",
  //       "road_address_name": "경기 의왕시 복지로 118",
  //       "x": "126.982723094285",
  //       "y": "37.3878501280214"
  //     },
  //     {
  //       "address_name": "서울 송파구 송파동 42",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 일식",
  //       "distance": "",
  //       "id": "2137050250",
  //       "phone": "0507-1491-7884",
  //       "place_name": "소코아 잠실점",
  //       "place_url": "http://place.map.kakao.com/2137050250",
  //       "road_address_name": "서울 송파구 백제고분로45길 15",
  //       "x": "127.10968831190233",
  //       "y": "37.50957970673231"
  //     },
  //     {
  //       "address_name": "광주 남구 봉선동 115-1",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 한식",
  //       "distance": "",
  //       "id": "694342683",
  //       "phone": "062-716-8364",
  //       "place_name": "소코아 봉선점",
  //       "place_url": "http://place.map.kakao.com/694342683",
  //       "road_address_name": "광주 남구 봉선로 173",
  //       "x": "126.914086498501",
  //       "y": "35.1233453151659"
  //     },
  //     {
  //       "address_name": "경기 성남시 수정구 창곡동 524-9",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 일식 > 일식집",
  //       "distance": "",
  //       "id": "221938372",
  //       "phone": "031-8023-9773",
  //       "place_name": "소코아 위례점",
  //       "place_url": "http://place.map.kakao.com/221938372",
  //       "road_address_name": "경기 성남시 수정구 위례순환로4길 19",
  //       "x": "127.149343793078",
  //       "y": "37.4692990581133"
  //     },
  //     {
  //       "address_name": "서울 영등포구 문래동3가 55-20",
  //       "category_group_code": "",
  //       "category_group_name": "",
  //       "category_name": "서비스,산업 > 기업",
  //       "distance": "",
  //       "id": "1891934524",
  //       "phone": "",
  //       "place_name": "소코아",
  //       "place_url": "http://place.map.kakao.com/1891934524",
  //       "road_address_name": "서울 영등포구 경인로 775",
  //       "x": "126.897538760103",
  //       "y": "37.5147453449764"
  //     },
  //     {
  //       "address_name": "인천 부평구 갈산동 377-6",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 일식",
  //       "distance": "",
  //       "id": "1589029292",
  //       "phone": "",
  //       "place_name": "소코아 부평점",
  //       "place_url": "http://place.map.kakao.com/1589029292",
  //       "road_address_name": "인천 부평구 주부토로151번길 31",
  //       "x": "126.724045461102",
  //       "y": "37.5083802628727"
  //     },
  //     {
  //       "address_name": "광주 북구 중흥동 360-4",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 일식",
  //       "distance": "",
  //       "id": "1716729568",
  //       "phone": "070-7580-2588",
  //       "place_name": "소코아 전대점",
  //       "place_url": "http://place.map.kakao.com/1716729568",
  //       "road_address_name": "광주 북구 서방로 3",
  //       "x": "126.913528633392",
  //       "y": "35.1736597912006"
  //     },
  //     {
  //       "address_name": "경기 안산시 단원구 고잔동 709-4",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 퓨전요리 > 퓨전일식",
  //       "distance": "",
  //       "id": "1480712779",
  //       "phone": "070-4178-3355",
  //       "place_name": "소코아 고잔점",
  //       "place_url": "http://place.map.kakao.com/1480712779",
  //       "road_address_name": "경기 안산시 단원구 광덕2로 163-5",
  //       "x": "126.828401140311",
  //       "y": "37.3103718228455"
  //     },
  //     {
  //       "address_name": "서울 강남구 삼성동 140-2",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 일식",
  //       "distance": "",
  //       "id": "2012390497",
  //       "phone": "",
  //       "place_name": "소코아 선릉점",
  //       "place_url": "http://place.map.kakao.com/2012390497",
  //       "road_address_name": "서울 강남구 선릉로100길 8",
  //       "x": "127.047773479624",
  //       "y": "37.506944990047"
  //     },
  //     {
  //       "address_name": "경기 수원시 팔달구 매산로1가 42-6",
  //       "category_group_code": "FD6",
  //       "category_group_name": "음식점",
  //       "category_name": "음식점 > 일식",
  //       "distance": "",
  //       "id": "1574609752",
  //       "phone": "031-251-7773",
  //       "place_name": "소코아 수원점",
  //       "place_url": "http://place.map.kakao.com/1574609752",
  //       "road_address_name": "경기 수원시 팔달구 매산로 21-3",
  //       "x": "127.003596455131",
  //       "y": "37.2678680556322"
  //     }
  //   ],
  //   "meta": {
  //     "is_end": false,
  //     "pageable_count": 45,
  //     "same_name": {
  //       "keyword": "소코아",
  //       "region": [],
  //       "selected_region": ""
  //     },
  //     "total_count": 53
  //   }
  // };

  bool _hasResults = false;
  Map<String, dynamic>? _detailInfo;
  bool _goDetail = false;

  KakaoMapController? get mapController => _mapController;
  // NaverMapController? get mapController => _mapController;
  Set<Marker> get markers => _markers;
  LatLng? get center => _center;
  int get zoomLevel => _zoomLevel;

  String? get searchQuery => _searchQuery;
  Map<String, dynamic>? get results => _results;
  bool get hasResults => _hasResults;
  Map<String, dynamic>? get detailInfo => _detailInfo;
  bool get goDetail => _goDetail;

  void setMapController(KakaoMapController? mapController) {
  // void setMapController(NaverMapController? mapController) {
    _mapController = mapController;
    print("맵 컨트롤러 세팅");
    notifyListeners();
  }

  void setMarkers(Set<Marker> markers) {
    _markers = markers;
    print("마커 세팅");
    notifyListeners();
  }

  void resetMarkers() {
    _markers = {};
    print("마커 리셋");
    notifyListeners();
  }

  void setCenter(LatLng center) {
    _center = center;
    print("지도 중심 세팅");
    notifyListeners();
  }

  void resetCenter() {
    _center = null;
    print("지도 중심 리셋");
    notifyListeners();
  }

  void setZoomLevel(int zoomLevel) {
    _zoomLevel = zoomLevel;
    print("줌 정도 세팅");
    notifyListeners();
  }

  void resetZoomLevel() {
    _zoomLevel = 3;
    print("줌 정도 초기화");
    notifyListeners();
  }

  // void setSearchQuery(String value) {
  //   _searchQuery = value;
  //   print("검색어 세팅");
  //   notifyListeners();
  // }
  //
  // void setResults(Map<String, dynamic> results) {
  //   _results = results;
  //   print("검색 결과 세팅");
  //   notifyListeners();
  // }

  // void resetResults() {
  //   _results = null;
  //   print("검색 결과 리셋");
  //   notifyListeners();
  // }

  // void setHasResults() {
  //   if (_results != null) {  // 값이 있을 때만 true가 되도록
  //     _hasResults = true;
  //   }
  //   notifyListeners();
  // }

  // void resetHasResults() {
  //   _hasResults = false;
  //   notifyListeners();
  // }

  void setSearchResults(String searchQuery, Map<String, dynamic> results) {
    _searchQuery = searchQuery;
    _results = results;
    _hasResults = true;
    print("검색 결과 세팅");
    notifyListeners();
  }

  void resetSearchResults() {
    _searchQuery = null;
    _results = null;
    _hasResults = false;
    _goDetail = false;
    print("검색 리셋");
    notifyListeners();
  }

  void setGoDetail(Map<String, dynamic> detailInfo) {
    _goDetail = true;
    _detailInfo = detailInfo;
    notifyListeners();
  }

  void resetGoDetail() {
    _goDetail = false;
    _detailInfo = null;
    notifyListeners();
  }
}