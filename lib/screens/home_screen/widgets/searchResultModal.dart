import 'package:dio/dio.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class SearchResultModal extends StatefulWidget {
  final String query;

  const SearchResultModal({
    super.key,
    required this.query
  });

  @override
  State<SearchResultModal> createState() => _SearchResultModalState();
}

class _SearchResultModalState extends State<SearchResultModal> {
  Map<String, dynamic>? results;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _naverSearch(widget.query);
  }

  Future<dynamic> _naverSearch(String query) async {
    print("############################## 네이버 검색");
    var dio = Dio();
    try {
      dio.options.baseUrl = dotenv.env['NAVER_SEARCH_URL']!;
      dio.options.headers = {
        'X-Naver-Client-Id': dotenv.env['NAVER_SEARCH_ID'],
        'X-Naver-Client-Secret': dotenv.env['NAVER_SEARCH_SECRET']
      };
      var response = await dio.get('?query=$query&display=5');
      print("#################### 검색결과 $response.data");
      setState(() {
        results = response.data;
      });
    } on DioException catch (e) {
      if (e.response != null) {
        print('에러 데이터 ${e.response?.data}');
        print(e.response?.headers);
        print(e.response?.requestOptions);
      } else {
        print(e.requestOptions);
        print(e.message);
      }
      setState(() {
        results = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Text("검색결과"),
            results != null ? SearchView(results: results!) : Text("검색결과 없음")
          ],
        ),
      ),
    );
  }
}