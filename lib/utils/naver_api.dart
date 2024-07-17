import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<dynamic> naverSearch(String query) async {
  print("############################## 네이버 검색");
  var dio = Dio();
  try {
    dio.options.baseUrl = dotenv.env['NAVER_SEARCH_URL']!;
    dio.options.headers = {
      'X-Naver-Client-Id': dotenv.env['NAVER_SEARCH_ID'],
      'X-Naver-Client-Secret': dotenv.env['NAVER_SEARCH_SECRET']
    };
    var response = await dio.get('?query=$query&display=5');
    print(response.data);
    return response.data;
  } on DioException catch (e) {
    if (e.response != null) {
      print('에러 데이터 ${e.response?.data}');
      print(e.response?.headers);
      print(e.response?.requestOptions);
    } else {
      print(e.requestOptions);
      print(e.message);
    }
    return null;
  }
}