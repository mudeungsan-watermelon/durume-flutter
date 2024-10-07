import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class RatingBar extends StatefulWidget {
  RatingBar({super.key});

  @override
  State<RatingBar> createState() => _RatingBarState();
}

class _RatingBarState extends State<RatingBar> {
  bool star1 = false;
  bool star2 = false;
  bool star3 = false;
  bool star4 = false;
  bool star5 = false;

  void tapStar1() {
    setState(() {
      if (star1 && !star2) {
        star1 = star2 = star3 = star4 = star5 = false;
      } else {
        star1 = true;
        star2 = star3 = star4 = star5 = false;
      }
    });
    print("$star1 $star2 $star3 $star4 $star5");
  }

  void tapStar2() {
    setState(() {
      star1 = star2 = true;
      star3 = star4 = star5 = false;
      // }
    });
    print("$star1 $star2 $star3 $star4 $star5");
  }

  void tapStar3() {
    setState(() {
      star1 = star2 = star3 = true;
      star4 = star5 = false;
      // }
    });
    print("$star1 $star2 $star3 $star4 $star5");
  }

  void tapStar4() {
    setState(() {
      star1 = star2 = star3 = star4 = true;
      star5 = false;
      // }
    });
    print("$star1 $star2 $star3 $star4 $star5");
  }

  void tapStar5() {
    setState(() {
      if (star5) {
        star1 = star2 = star3 = star4 = star5 = false;
      } else {
        star1 = star2 = star3 = star4 = star5 = true;
      }
    });
    print("$star1 $star2 $star3 $star4 $star5");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _RatingStar(isSelected: star1, onTap: tapStar1),
            _RatingStar(isSelected: star2, onTap: tapStar2),
            _RatingStar(isSelected: star3, onTap: tapStar3),
            _RatingStar(isSelected: star4, onTap: tapStar4),
            _RatingStar(isSelected: star5, onTap: tapStar5),
          ],
        ),
      ],
    );
  }
}

Widget _RatingStar({bool isSelected = false, void Function()? onTap}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 1.5),
    child: GestureDetector(
      onTap: onTap,
      child: isSelected ? Icon(Symbols.kid_star, fill: 1, color: primaryColor, size: 34,)
          : Icon(Symbols.kid_star, color: softGrey, size: 34,),
    ),
  );
}
