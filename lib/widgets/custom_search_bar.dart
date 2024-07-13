import 'package:flutter/material.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
  });

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  // String? _query;

  final TextEditingController _queryController = TextEditingController();

  // void _setQuery(value) {
  //   setState(() {
  //     // _queryController.text(value);
  //   });
  // }

  void _resetQuery() {
    setState(() {
      _queryController.clear();
    });
  }

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
      onSubmitted: (value) {},
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

Widget _resetInput(TextEditingController controller) {
  return GestureDetector(
    onTap: () {controller.clear();},
    child: const Icon(Icons.close),
  );
}
