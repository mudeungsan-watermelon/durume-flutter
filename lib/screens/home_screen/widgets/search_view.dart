import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  Map<String, dynamic> results;

  SearchView({
    super.key,
    required this.results
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...results['items'].map((data) => GestureDetector(
                    onTap: (){},
                    child: _SearchRecord(data['title'], data['roadAddress'], data['category']),
                  ))
                ],
              ),
            ),
          ),
        )
    );
  }
}

Widget _SearchRecord(String title, String address, String category) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
    child: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.grey
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, overflow: TextOverflow.ellipsis),
            Text(address, overflow: TextOverflow.ellipsis),
            Row(
              children: [
                Text(category, overflow: TextOverflow.ellipsis),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
