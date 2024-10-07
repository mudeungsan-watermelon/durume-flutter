import 'package:durume_flutter/models/database_model.dart';
import 'package:durume_flutter/screens/search_screen/widgets/search_history_list.dart';
import 'package:durume_flutter/widgets/custom_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Map<String, dynamic>? results;

  void setResults(val) {
    if (val != null && val.isNotEmpty) {
      setState(() {
        results = val;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    DatabaseModel dbModel = Provider.of<DatabaseModel>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0, MediaQuery.of(context).padding.top, 0, 0),
            child: const CustomSearchBar(),
          ),
          const SearchHistoryList(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
