import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/widgets/custom_btns.dart';
import 'package:durume_flutter/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

Widget ReviewContent(BuildContext context, {
  String imgPath = "" , String title = "", String rate = "", String content = "", String date = ""
}) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: Image.asset(
                  imgPath,
                  fit: BoxFit.fitWidth,
                  width: 48,
                  height: 48,
                ),
              ),
              const SizedBox(width: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  Row(
                    children: [
                      Icon(Symbols.kid_star, fill: 1, color: primaryColor, size: 18,),
                      const SizedBox(width: 2,),
                      Text(rate, style: const TextStyle(fontSize: 16),)
                    ],
                  )
                ],
              )
            ],
          ),
          _ReviewMenu(false, context, "무등산 워터멜론")
        ],
      ),
      const SizedBox(height: 16,),
      Text(content, style: const TextStyle(fontSize: 18),),
      const SizedBox(height: 8,),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(date, style: TextStyle(fontSize: 16, color: softGrey),),
        ],
      ),
      const Padding(
        padding: EdgeInsets.only(top: 20, bottom: 24),
        child: Divider(),
      ),
    ],
  );
}

Widget _ReviewMenu(bool isMe, BuildContext context, String nickname) {
  TextStyle textStyle = const TextStyle(color: Color(0xff1d1b20), fontSize: 16,);
  TextEditingController controller = TextEditingController();
  return MenuAnchor(
    // childFocusNode: buttonFocusNode,
    style: MenuStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
    alignmentOffset: const Offset(-85, -85),
    crossAxisUnconstrained: true,
    menuChildren: [
      Column(
        children: <Widget>[
          isMe ? MenuItemButton(
            child: Text("삭제하기", style: textStyle,),
            // style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
            onPressed: (){
              Fluttertoast.showToast(msg: "리뷰가 삭제되었습니다.");
            },
          ) :
          MenuItemButton(
            child: Text("신고하기", style: textStyle,),
            onPressed: (){
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext context) {
                  return CustomDialog(
                    controller: controller,
                    title: "리뷰 신고",
                    name: nickname,
                    content: "님의 리뷰를 신고합니다.",
                    hintText: "신고 이유를 입력해주세요.",
                    maxLength: 200,
                    onSubmitted: () {
                      print(controller.text.toString());
                      Navigator.pop(context);
                      Fluttertoast.showToast(msg: "리뷰가 신고되었습니다.");
                    },
                  );
                }
              );
            },
          ),
        ],
      ),
    ],
    builder: (BuildContext context, MenuController controller, Widget? child) {
      return IconButton(
          visualDensity: VisualDensity.compact,
          onPressed: (){
            if (controller.isOpen) {
              controller.close();
            } else {
              controller.open();
            }
          },
          icon: const Icon(Symbols.more_vert, size: 24,)
      );
    },
  );
}
