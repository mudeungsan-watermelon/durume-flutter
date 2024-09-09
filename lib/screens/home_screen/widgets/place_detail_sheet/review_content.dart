import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/widgets/custom_btns.dart';
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
                      const Icon(Symbols.kid_star),
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
                  return _ReviewReportDialog(context, nickname: nickname);
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
          icon: Icon(Symbols.more_vert, size: 24,)
      );
    },
  );
}

Widget _ReviewReportDialog(BuildContext context, {String nickname = ""}) {
  TextEditingController controller = TextEditingController();
  return Dialog(
    backgroundColor: Colors.white,
    elevation: 0,
    insetPadding: EdgeInsets.symmetric(horizontal: 24),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Text("리뷰 신고", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(nickname, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),),
              const Text("님의 리뷰를 신고합니다.", style: TextStyle(fontSize: 14),),
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
                    if (text.characters.length > 200) {
                      controller.text = text.characters.take(200).toString();
                    }
                  },
                  decoration: InputDecoration(
                    hintText: "신고 이유를 입력해주세요.",
                    hintStyle: TextStyle(fontSize: 16, color: softGrey),
                    counterStyle: TextStyle(fontSize: 12, color: softGrey),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide.none
                    ),
                    contentPadding: EdgeInsets.zero
                  ),
                  // autofocus: true,
                  maxLines: 3,
                  maxLength: 200,
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
                onTap: () {
                  print(controller.text.toString());
                }
              ),
            ],
          )
        ],
      ),
    ),
  );
}