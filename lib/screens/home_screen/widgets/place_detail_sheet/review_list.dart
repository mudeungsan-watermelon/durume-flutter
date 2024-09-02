import 'dart:convert';

import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

Widget ReviewList() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text("리뷰", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
              SizedBox(width: 12,),
              Text("12개", style: TextStyle(fontSize: 18),),
            ],
          ),
          TextButton(
            onPressed: (){},
            style: TextButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap
            ),
            child: Text("리뷰 작성하기", style: TextStyle(fontSize: 18),)
          )
        ],
      ),
      SizedBox(height: 12,),
      Row(
        children: [
          _ArrayBtn(text: "• 최신순"),
          SizedBox(width: 12,),
          _ArrayBtn(text: "• 평점 높은순"),
          SizedBox(width: 12,),
          _ArrayBtn(text: "• 평점 낮은순"),
        ],
      ),
      SizedBox(height: 24,),
      Column(
        children: [
          _ReviewContent(
            imgPath: 'assets/images/temp_profile.jpg',
            title: "반짝이는 워터멜론",
            rate: "4",
            content: "무료로 체험전시 경험할수 있는 메가부푸 전시 너무 좋아요 아이가 놀기 좋고 재밌어요 매각 정시 진행되니 시간 참고해서 가시면 좋을것 같아요",
            date: "2024년 8월 7일"
          ),
          _ReviewContent(
              imgPath: 'assets/images/temp_profile.jpg',
              title: "반짝이는 워터멜론",
              rate: "4",
              content: "무료로 체험전시 경험할수 있는 메가부푸 전시 너무 좋아요 아이가 놀기 좋고 재밌어요 매각 정시 진행되니 시간 참고해서 가시면 좋을것 같아요",
              date: "2024년 8월 7일"
          ),
          _ReviewContent(
              imgPath: 'assets/images/temp_profile.jpg',
              title: "반짝이는 워터멜론",
              rate: "4",
              content: "무료로 체험전시 경험할수 있는 메가부푸 전시 너무 좋아요 아이가 놀기 좋고 재밌어요 매각 정시 진행되니 시간 참고해서 가시면 좋을것 같아요",
              date: "2024년 8월 7일"
          ),
        ],
      )
    ],
  );
}

Widget _ArrayBtn({String text = "", bool isSelected = false}) {
  return TextButton(
      onPressed: (){},
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Text(text, style: TextStyle(fontSize: 16, color: isSelected ? primaryColor : softGrey),)
  );
}

Widget _ReviewContent({
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
              SizedBox(width: 12,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),),
                  Row(
                    children: [
                      Icon(Symbols.kid_star),
                      Text(rate, style: TextStyle(fontSize: 16),)
                    ],
                  )
                ],
              )
            ],
          ),
          IconButton(
            onPressed: (){},
            visualDensity: VisualDensity.compact,
            icon: Icon(Symbols.more_vert, size: 24,)
          )
        ],
      ),
      SizedBox(height: 16,),
      Text(content, style: TextStyle(fontSize: 18),),
      SizedBox(height: 8,),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(date, style: TextStyle(fontSize: 16, color: softGrey),),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(top: 20, bottom: 24),
        child: Divider(),
      ),
    ],
  );
}