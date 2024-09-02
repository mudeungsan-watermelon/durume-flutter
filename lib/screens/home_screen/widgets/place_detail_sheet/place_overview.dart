import 'package:durume_flutter/screens/home_screen/widgets/bottom_sheet_widgets.dart';
import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

Widget PlaceOverview() {
  return Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Text(mapModel.detailInfo!["place_name"]),
          Text(
            "카카오프렌즈 코엑스점",
            style: TextStyle(
                fontSize: 24, color: primaryColor, fontWeight: FontWeight.w700
            ),
          ),
          IconButton(
              visualDensity: VisualDensity.compact,
              onPressed: (){},
              icon: Icon(Symbols.favorite)
          )
        ],
      ),
      // SizedBox(height: 8,),
      // Text(mapModel.detailInfo!["category_name"]),
      Row(
        children: [
          Text(
            "가정,생활 > 문구,사무용품 > 디자인문구 > 카카오프렌즈",
            style: TextStyle(
                fontSize: 14, color: softGrey
            ),
            textAlign: TextAlign.start,
          ),
        ],
      ),
      const SizedBox(height: 12,),
      ReviewOverView(),
      const SizedBox(height: 8,),
      Column(
        children: [
          _TextWithCopyBtn("도로명", "서울 강남구 영동대로 513"),
          _TextWithCopyBtn("지번", "서울 강남구 삼성동 159"),
          _TextWithCopyBtn("전화", "02-6002-1880", isPhone: true)
          // _TextWithCopyBtn("도로명", mapModel.detailInfo!["road_address_name"]),
          // _TextWithCopyBtn("지번", mapModel.detailInfo!["address_name"]),
          // _TextWithCopyBtn("전화", mapModel.detailInfo!["phone"], isPhone: true)
        ],
      ),
    ],
  );
}

Widget _TextWithCopyBtn(String title, String content, {bool isPhone = false}) {
  return Row(
    children: [
      Container(
          color: Color(0xffd9d8d9),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 1),
            child: Text(title, style: TextStyle(fontSize: 14, color: softGrey),),
          )
      ),
      const SizedBox(width: 12,),
      Text(content, style: TextStyle(fontSize: 16),),
      isPhone ? _CallMenuBtn(content) :
      // isPhone ? IconButton(
      //   visualDensity: VisualDensity.compact,
      //   onPressed: (){
      //     // showMenu(context: context, position: position, items: items)
      //   },
      //   icon: Icon(Symbols.call, size: 18, color: primaryColor,)
      // ) :
      Container(
        // width: 20,
        // height: 20,
        child: IconButton(
          // padding: EdgeInsets.zero,
          // constraints: const BoxConstraints(),
            visualDensity: VisualDensity.compact,
            onPressed: (){
              Clipboard.setData(ClipboardData(text: content));
              Fluttertoast.showToast(msg: "주소가 복사되었습니다.");
            },
            icon: Icon(Symbols.content_copy, size: 18, color: primaryColor,)
        ),
      )
    ],
  );
}

Widget _CallMenuBtn(String phone) {
  TextStyle _textStyle = const TextStyle(color: Color(0xff1d1b20), fontSize: 16,);
  return MenuAnchor(
    // childFocusNode: buttonFocusNode,
    style: MenuStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
    alignmentOffset: const Offset(30, 0),
    crossAxisUnconstrained: true,
    menuChildren: [
      Padding(
        padding: const EdgeInsets.only(right: 40),
        child: Column(
          children: <Widget>[
            MenuItemButton(
              child: Text("전화 걸기", style: _textStyle,),
              // style: ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero)),
              onPressed: (){},
            ),
            MenuItemButton(
              child: Text("전화번호 저장", style: _textStyle,),
              onPressed: (){},
            ),
            MenuItemButton(
              child: Text("전화번호 복사", style: _textStyle,),
              onPressed: (){
                Clipboard.setData(ClipboardData(text: phone));
                Fluttertoast.showToast(msg: "전화번호가 복사되었습니다.");
              },
            ),
          ],
        ),
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
          icon: Icon(Symbols.call, size: 18, color: primaryColor,)
      );
    },
  );
}