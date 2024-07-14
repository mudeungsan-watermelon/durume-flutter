import 'package:durume_flutter/screens/search_screen/widgets/search_history.dart';
import 'package:durume_flutter/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? query;

  void setQuery(val) {
    if (val.isNotEmpty)  {
      setState(() {
        query = val;
      });
    }
  }

  final TextEditingController queryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 24,),
          CustomSearchBar(),
          // SearchHistory()
        ],
      ),
    );
  }
}
