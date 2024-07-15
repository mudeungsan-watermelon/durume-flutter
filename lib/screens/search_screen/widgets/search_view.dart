import 'package:flutter/material.dart';

class SearchView extends StatelessWidget {
  Map response;

  SearchView({
    super.key,
    required this.response
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
                  ...response['items'].map((data) => GestureDetector(
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
    child: GestureDetector(
      onTap: (){},
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(address),
              Row(
                children: [
                  Text(category),
                ],
              )
            ],
          ),
        ),
      ),
    ),
  );
}
