import 'package:durume_flutter/screens/home_screen/widgets/search_result_sheet/search_result_sheet.dart';
import 'package:flutter/material.dart';

class SearchResultScrollableSheet extends StatelessWidget {
  SearchResultScrollableSheet({super.key});

  final DraggableScrollableController controller = DraggableScrollableController();

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      controller: controller,
      builder: (BuildContext context, scrollController) {
        return SearchResultSheet(scrollController: scrollController);
      }
    );
  }
}
