import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

// radius 추가!!!!!!!

Future<dynamic> kakaoSearch(String query, String x, String y) async {
  print("################## $query 검색");
  print("########################### $x $y");
  var dio = Dio();
  try {
    dio.options.baseUrl = dotenv.env["KAKAO_SEARCH_URL"]!;
    String? kakaoKey = dotenv.env['KAKAO_RA_KEY'];
    dio.options.headers = {
      "Authorization": "KakaoAK $kakaoKey"
    };
    // var response = await dio.get("?query=$query");
    var response = await dio.get("?query=$query&x=$x&y=$y&radius=10000");
    print("카카오 검색 결과 ${response.data}");
    return response.data;
  } on DioException catch (e) {
    if (e.response != null) {
      print('카카오 검색 에러 데이터 ${e.response?.data}');
      print(e.response?.headers);
      print(e.response?.requestOptions);
    } else {
      print("카카오 검색 에러");
      print(e.requestOptions);
      print(e.message);
    }
    return null;
  }
}

Future<dynamic> kakaoCategorySearch(String code, String x, String y) async {
  print("################### $code 카테고리 검색");
  var dio = Dio();
  try {
    dio.options.baseUrl = dotenv.env["KAKAO_CATEGORY_SEARCH_URL"]!;
    String? kakaoKey = dotenv.env['KAKAO_RA_KEY'];
    dio.options.headers = {
      "Authorization": "KakaoAK $kakaoKey"
    };
    // var response = await dio.get("?category_group_code=$code");
    var response = await dio.get("?category_group_code=$code&x=$x&y=$y&radius=10000");
    print("카카오 카테고리 검색 결과 ${response.data}");
    return response.data;
  } on DioException catch (e) {
    if (e.response != null) {
      print('카카오 카테고리 검색 에러 데이터 ${e.response?.data}');
      print(e.response?.headers);
      print(e.response?.requestOptions);
    } else {
      print("카카오 카테고리 검색 에러");
      print(e.requestOptions);
      print(e.message);
    }
    return null;
  }
}