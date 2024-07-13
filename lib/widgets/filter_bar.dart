import 'package:flutter/material.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 56,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            Filter(text: "관광"),
            Filter(text: "음식점"),
            Filter(text: "쇼핑"),
            Filter(text: "숙박"),
            Filter(text: "레포츠"),
            Filter(text: "레포츠"),
            Filter(text: "레포츠"),
            Filter(text: "레포츠"),
          ],
        ),
      ),
    );
  }
}

class Filter extends StatelessWidget {
  final String text;

  const Filter({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(text),
        ),
      ),
    );
  }
}
