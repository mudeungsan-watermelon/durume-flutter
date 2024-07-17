import 'package:dio/dio.dart';
import 'package:durume_flutter/screens/home_screen/widgets/searchResultModal.dart';
import 'package:durume_flutter/screens/search_result_screen/search_result_screen.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {

  CustomSearchBar({
    super.key,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController _queryController = TextEditingController();

  String _input = "";

  void _setInput(value) {
    setState(() {
      _input = value;
    });
  }

  void _resetInput() {
    setState(() {
      _input = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      controller: _queryController,
      leading: _goBackBtn(context),
      trailing: _input.isEmpty ? null : [_resetInputBtn(_queryController, _resetInput)],
      backgroundColor: const MaterialStatePropertyAll(Colors.grey),
      elevation: const MaterialStatePropertyAll(0),
      constraints: const BoxConstraints(minHeight: 48),
      shape: MaterialStateProperty.all(
        ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(0)
        )
      ),
      hintText: "검색어를 입력하세요.",
      onChanged: (input) {
        if (input.isEmpty) {
          _resetInput();
        } else {
          _setInput(input);
        }
      },
      onSubmitted: (query) {
        // // 검색어 입력 -> 레이아웃 off / 바텀시트 on -> API 호출 -> 값 보여주기
        // Navigator.pop(context);
        // showModalBottomSheet(
        //   context: context,
        //   builder: (context) => SearchResultModal(query: value),
        //   enableDrag: true,
        //   isScrollControlled: true,
        //   // isDismissible: true,  // 바텀시트 아닌 부분 클릭시 닫음
        //   showDragHandle: true,
        //   backgroundColor: Colors.white,
        //   barrierColor: Colors.transparent,
        //   constraints: const BoxConstraints(
        //     maxHeight: 200,
        //     minWidth: double.infinity,
        //   )
        // );
        Navigator.push(context, MaterialPageRoute(builder: (_) => SearchResultScreen(query: query)));
      },
    );
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

Widget _resetInputBtn(TextEditingController controller, VoidCallback resetInput) {
  return GestureDetector(
    onTap: () {
      controller.clear();
      resetInput();
    },
    child: const Icon(Icons.close),
  );
}