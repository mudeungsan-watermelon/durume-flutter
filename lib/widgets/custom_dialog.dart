import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/widgets/custom_btns.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  // TextEditingController controller = TextEditingController();
  TextEditingController controller;
  String title;
  String name;
  String content;
  String hintText;
  int maxLength;
  bool hasRating;
  void Function()? onSubmitted;

  CustomDialog({
    super.key,
    required this.controller,
    required this.title,
    required this.name,
    required this.content,
    required this.hintText,
    required this.maxLength,
    this.hasRating = false,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
                Text(content, style: const TextStyle(fontSize: 14),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 14, bottom: 36),
              child: Container(
                // height: 150,
                decoration: BoxDecoration(
                    color: const Color(0x7fd9d9d9),
                    borderRadius: BorderRadius.circular(8)
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: TextField(
                    controller: controller,
                    onChanged: (text) {
                      if (text.characters.length > maxLength) {
                        controller.text = text.characters.take(maxLength).toString();
                      }
                    },
                    decoration: InputDecoration(
                        hintText: hintText,
                        hintStyle: TextStyle(fontSize: 16, color: softGrey),
                        counterStyle: TextStyle(fontSize: 12, color: softGrey),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide.none
                        ),
                        contentPadding: EdgeInsets.zero
                    ),
                    // autofocus: true,
                    maxLines: 3,
                    maxLength: maxLength,
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SmallRoundedBtn(
                  text: "취소",
                  onTap: () {
                    Navigator.pop(context);
                  }
                ),
                const SizedBox(width: 12,),
                SmallRoundedBtn(
                  text: "확인",
                  isFilled: true,
                  onTap: onSubmitted
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
