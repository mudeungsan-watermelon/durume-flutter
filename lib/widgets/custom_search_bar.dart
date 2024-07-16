import 'package:dio/dio.dart';
import 'package:durume_flutter/screens/home_screen/widgets/searchResultModal.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {

  CustomSearchBar({
    super.key,
    required this.setResults,
    required this.resetResults,
    required this.scaffoldKey,
  });

  final Function setResults;
  final Function resetResults;
  final TextEditingController _queryController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey;

  final dio = Dio();

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _queryController,
      leading: _goBackBtn(context, resetResults),
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
      onSubmitted: (value) {
        // 검색어 입력 -> 레이아웃 off / 바텀시트 on -> API 호출 -> 값 보여주기
        Navigator.pop(context);
        showModalBottomSheet(
          context: context,
          builder: (context) => SearchResultModal(query: value),
          enableDrag: true,
          isScrollControlled: true,
          isDismissible: true,  // 바텀시트 아닌 부분 클릭시 닫음
          backgroundColor: Colors.white,
          barrierColor: Colors.transparent,
          constraints: const BoxConstraints(
            maxHeight: 200,
            minWidth: double.infinity,
          )
        );
      },
    );
  }
}

Widget _searchResultSheet() {

  return Container(
    child: Text("검색결과"),
  );
}

Widget _goBackBtn(context, resetResults) {
  return GestureDetector(
    onTap: (){
      resetResults();
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
