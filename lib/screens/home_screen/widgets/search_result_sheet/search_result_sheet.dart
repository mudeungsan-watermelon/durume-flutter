import 'package:durume_flutter/screens/home_screen/widgets/bottom_sheet_widgets.dart';
import 'package:durume_flutter/screens/home_screen/widgets/search_result_sheet/search_result_list.dart';
import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';

class SearchResultSheet extends StatelessWidget {
  final ScrollController scrollController;

  const SearchResultSheet({
    super.key,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: basicBoxStyle(borderRadius: 28, borderDirectional: true),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: CustomScrollView(
          controller: scrollController,
          slivers: [
            SliverToBoxAdapter(
              child: CustomDragHandle,
            ),
            const SearchResultList(),
          ],
        ),
      ),
    );
  }
}

