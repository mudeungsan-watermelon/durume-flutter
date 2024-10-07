import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<dynamic> kakaoSearch(String query, String? x, String? y) async {
  print("################## $query 검색");
  var dio = Dio();
  try {
    dio.options.baseUrl = dotenv.env["KAKAO_SEARCH_URL"]!;
    String? kakaoKey = dotenv.env['KAKAO_RA_KEY'];
    dio.options.headers = {
      "Authorization": "KakaoAK $kakaoKey"
    };
    var response = (x != null && y != null) ?
      await dio.get("?query=$query&x=$x&y=$y&radius=10000")
      : await dio.get("?query=$query");
    print("카카오 검색 결과 ${response.data}");
    return response.data;
  } on DioException catch (e) {
    if (e.response != null) {
      print('카카오 검색 에러 데이터 ${e.response?.data}');
    } else {
      print("카카오 검색 에러");
    }
    return null;
  }
}

Future<dynamic> kakaoCategorySearch(String code, String? x, String? y) async {
  print("################### $code 카테고리 검색");
  var dio = Dio();
  try {
    dio.options.baseUrl = dotenv.env["KAKAO_CATEGORY_SEARCH_URL"]!;
    String? kakaoKey = dotenv.env['KAKAO_RA_KEY'];
    dio.options.headers = {
      "Authorization": "KakaoAK $kakaoKey"
    };
    var response = (x != null && y != null) ?
      await dio.get("?category_group_code=$code&x=$x&y=$y&radius=10000")
        : await dio.get("?category_group_code=$code");
    print("카카오 카테고리 검색 결과 ${response.data}");
    return response.data;
  } on DioException catch (e) {
    if (e.response != null) {
      print('카카오 카테고리 검색 에러 데이터 ${e.response?.data}');
    } else {
      print("카카오 카테고리 검색 에러");
    }
    return null;
  }
}