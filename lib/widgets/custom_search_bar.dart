import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CustomSearchBar extends StatelessWidget {

  CustomSearchBar({
    super.key,
    required this.setResults
  });

  final Function setResults;
  final TextEditingController _queryController = TextEditingController();

  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _queryController,
      leading: _goBackBtn(context),
      trailing: [_resetInput(_queryController)],
      backgroundColor: MaterialStatePropertyAll(Colors.grey),
      elevation: MaterialStatePropertyAll(0),
      constraints: BoxConstraints(minHeight: 48),
      shape: MaterialStateProperty.all(
        ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        )
      ),
      hintText: "검색어를 입력하세요.",
      onChanged: (value) {
        // _setQuery(value);
      },
      onSubmitted: (value) async {
        var response = await _naverSearch(value);
        print(response.data.runtimeType);
        print(response.data);
        setResults(response.data);
      },
    );
  }
}

Future<dynamic> _naverSearch(String query) async {
  var dio = Dio();
  try {
    dio.options.baseUrl = dotenv.env['NAVER_SEARCH_URL']!;
    dio.options.headers = {
      'X-Naver-Client-Id': dotenv.env['NAVER_SEARCH_ID'],
      'X-Naver-Client-Secret': dotenv.env['NAVER_SEARCH_SECRET']
    };
    var response = await dio.get('?query=$query&display=5');
    return response;
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

Widget _goBackBtn(context) {
  return GestureDetector(
    onTap: (){
      Navigator.pop(context);
    },
    child: const Icon(Icons.chevron_left),
  );
}

Widget _resetInput(TextEditingController controller) {
  return GestureDetector(
    onTap: () {controller.clear();},
    child: const Icon(Icons.close),
  );
}
