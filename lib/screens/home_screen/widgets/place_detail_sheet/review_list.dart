import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/review_content.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/widgets/custom_dialog.dart';
import 'package:flutter/material.dart';

class ReviewList extends StatelessWidget {
  ReviewList ({super.key});

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              children: [
                Text("리뷰", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                SizedBox(width: 12,),
                Text("12개", style: TextStyle(fontSize: 18),),
              ],
            ),
            TextButton(
              onPressed: (){
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (BuildContext context) {
                    return CustomDialog(
                      controller: controller,
                      title: "리뷰 작성",
                      name: "카카오프렌즈 코엑스점",
                      content: "의 리뷰를 작성합니다.",
                      hintText: "리뷰를 입력해주세요.",
                      maxLength: 1000,
                      hasRating: true,
                    );
                  }
                );
              },
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
            ReviewContent(
              context,
              imgPath: 'assets/images/temp_profile.jpg',
              title: "반짝이는 워터멜론",
              rate: "4",
              content: "무료로 체험전시 경험할수 있는 메가부푸 전시 너무 좋아요 아이가 놀기 좋고 재밌어요 매각 정시 진행되니 시간 참고해서 가시면 좋을것 같아요",
              date: "2024년 8월 7일"
            ),
            ReviewContent(
              context,
              imgPath: 'assets/images/temp_profile.jpg',
              title: "반짝이는 워터멜론",
              rate: "4",
              content: "무료로 체험전시 경험할수 있는 메가부푸 전시 너무 좋아요 아이가 놀기 좋고 재밌어요 매각 정시 진행되니 시간 참고해서 가시면 좋을것 같아요",
              date: "2024년 8월 7일"
            ),
            ReviewContent(
              context,
              imgPath: 'assets/images/temp_profile.jpg',
              title: "반짝이는 워터멜론",
              rate: "4",
              content: "무료로 체험전시 경험할수 있는 메가부푸 전시 너무 좋아요 아이가 놀기 좋고 재밌어요 매각 정시 진행되니 시간 참고해서 가시면 좋을것 같아요",
              date: "2024년 8월 7일"
            ),
            ReviewContent(
              context,
              imgPath: 'assets/images/temp_profile.jpg',
              title: "반짝이는 워터멜론",
              rate: "4",
              content: "무료로 체험전시 경험할수 있는 메가부푸 전시 너무 좋아요 아이가 놀기 좋고 재밌어요 매각 정시 진행되니 시간 참고해서 가시면 좋을것 같아요",
              date: "2024년 8월 7일"
            ),
            ReviewContent(
              context,
              imgPath: 'assets/images/temp_profile.jpg',
              title: "반짝이는 워터멜론",
              rate: "4",
              content: "무료로 체험전시 경험할수 있는 메가부푸 전시 너무 좋아요 아이가 놀기 좋고 재밌어요 매각 정시 진행되니 시간 참고해서 가시면 좋을것 같아요",
              date: "2024년 8월 7일"
            ),
            ReviewContent(
              context,
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

