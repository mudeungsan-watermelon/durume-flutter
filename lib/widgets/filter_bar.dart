import 'package:durume_flutter/styles.dart';
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
            Filter(text: "🍚 음식점"),
            Filter(text: "☕️ 카페"),
            Filter(text: "📸 관광명소"),
            Filter(text: "🎨 문화"),
            Filter(text: "🏪 편의점"),
            Filter(text: "🛏️ 숙소"),
            Filter(text: "🚗 주차장"),
            Filter(text: "⛽️ 주유소"),
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
        decoration: basicBoxStyle(),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 7*widthRatio(context), horizontal: 12*heightRatio(context)),
          child: Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16
              )
          ),
        ),
      ),
    );
  }
}
