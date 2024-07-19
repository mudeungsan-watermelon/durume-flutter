import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<dynamic> kakaoSearch(String query) async {
  print("################## $query 검색");
  var dio = Dio();
  try{
    dio.options.baseUrl = dotenv.env["KAKAO_SEARCH_URL"]!;
    String? kakaoKey = dotenv.env['KAKAO_RA_KEY'];
    dio.options.headers = {
      "Authorization": "KakaoAK $kakaoKey"
    };
    var response = await dio.get("?query=$query");
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