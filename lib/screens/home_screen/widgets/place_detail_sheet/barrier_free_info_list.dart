import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/styles.dart';
import 'package:durume_flutter/utils/gemini_model_utils.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';
import 'package:provider/provider.dart';

class BarrierFreeInfoList extends StatelessWidget {
  const BarrierFreeInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    return FutureBuilder(
      future: getBarrierFreeInfo(
        mapModel.geminiChatSession,
        placeName: mapModel.detailInfo!["place_name"],
        addressName: mapModel.detailInfo!["address_name"]
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _BarrierFreeInfo(isLoading: true);
        } else if (snapshot.hasError) {
          return _BarrierFreeInfo();
        } else {
          Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
          if (data.isNotEmpty) {
            print(data);
            return _BarrierFreeInfo(barrierFreeInfo: data);
          }
          return _BarrierFreeInfo();
        }
      }
    );
  }
}

Widget _BarrierFreeInfo({Map<String, dynamic>? barrierFreeInfo, bool isLoading = false}) {
  return Column(
    children: [
      Row(
        children: [
          const Text("무장애 정보", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
          SizedBox(width: 4,),
          GestureDetector(
            onTap: () {
              // 안내팝업
              // "해당 무장애 정보는 인공지능 LLM 모델인 Google Gemini 1.5를 통해 제공됩니다. 정보 정확성에 일부 한계가 있을 수 있으니, 참고용으로만 사용해 주시기 바랍니다."
            },
            child: Icon(Symbols.info, size: 18,),
          )
        ],
      ),
      const SizedBox(height: 14,),
      isLoading ? _NoBarrierFreeDetailInfo(true) :
        barrierFreeInfo == null ? _NoBarrierFreeDetailInfo(false) :
        _BarrierFreeDetailInfo(barrierFreeInfo),
    ],
  );
}

Widget _BarrierFreeDetailInfo(Map<String, dynamic> info) {
  return Column(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BarrierFreeMainCategory(text: "장애인 시설", icon: Symbols.accessibility_new, isFirst: true),
          _BarrierFreeSubCategory("장애인 주차장", info["parking"]),
          _BarrierFreeSubCategory("장애인 화장실", info["restroom"]),
          _BarrierFreeSubCategory("장애인 관람석", info["auditorium"]),
          _BarrierFreeSubCategory("장애인 전용실", info["room"]),
          _BarrierFreeSubCategory("장애인 시설 기타", info["handicapetc"]),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BarrierFreeMainCategory(text: "휠체어 사용자", icon: Symbols.accessible_forward),
          _BarrierFreeSubCategory("휠체어 대여", info["wheelchair"]),
          _BarrierFreeSubCategory("주출입구 경사로", info["exit"]),
          _BarrierFreeSubCategory("이동경로 경사로", info["publictransport"]),
          _BarrierFreeSubCategory("엘리베이터", info["elevator"]),
          _BarrierFreeSubCategory("휠체어 사용자 기타", info["wheelchairetc"]),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BarrierFreeMainCategory(text: "영유아", icon: Symbols.child_care),
          _BarrierFreeSubCategory("유모차 대여", info["stroller"]),
          _BarrierFreeSubCategory("수유실", info["lactationroom"]),
          _BarrierFreeSubCategory("유아용 의자 대여", info["babysparechair"]),
          _BarrierFreeSubCategory("유아 시설 기타", info["infantsfamilyetc"]),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BarrierFreeMainCategory(text: "시각장애인", icon: Symbols.blind),
          _BarrierFreeSubCategory("점자블록", info["braileblock"]),
          _BarrierFreeSubCategory("안내견 동반", info["helpdog"]),
          _BarrierFreeSubCategory("음성안내 가이드", info["audioguide"]),
          _BarrierFreeSubCategory("점자안내판", info["brailepromotion"]),
          _BarrierFreeSubCategory("시각장애인 시설 기타", info["blindhandicapetc"]),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BarrierFreeMainCategory(text: "청각장애인", icon: Symbols.hearing_aid),
          _BarrierFreeSubCategory("수화안내", info["signguide"]),
          _BarrierFreeSubCategory("비디오 가이드", info["videoguide"]),
          _BarrierFreeSubCategory("청각장애인 시설 기타", info["hearinghandicapetc"]),
        ],
      ),
      const SizedBox(height: 16,)
    ],
  );
}

Widget _BarrierFreeMainCategory({String text = "", IconData icon = Symbols.accessible_forward, bool isFirst = false}) {
  return Padding(
    padding: EdgeInsets.only(top: isFirst ? 4 : 30, bottom: 0),
    child: Row(
      children: [
        Icon(icon, size: 24),
        SizedBox(width: 8,),
        Text(text, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),),
      ],
    ),
  );
}

Widget _BarrierFreeSubCategory(String category, String? content) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category,
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 16, color: softGrey),
        ),
        SizedBox(height: 2,),
        _BarrierFreeContent(content: content)
      ],
    ),
  );
}

Widget _BarrierFreeContent({String? content, bool isLoading = false}) {
  if (isLoading) {
    return Text(
      "정보 불러오는 중",
      textAlign: TextAlign.left,
      style: TextStyle(fontSize: 18, color: softGrey),
    );
  } else {
    if (content == null || content == "") {
      return Text("정보 없음", textAlign: TextAlign.left, style: TextStyle(fontSize: 18, color: softGrey),);
    }
    return Text(content, textAlign: TextAlign.left, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),);
  }
}

Widget _NoBarrierFreeDetailInfo(bool isLoading) {
  return Column(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BarrierFreeMainCategory(text: "장애인 시설", icon: Symbols.accessibility_new, isFirst: true),
          _BarrierFreeContent(isLoading: isLoading)
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BarrierFreeMainCategory(text: "휠체어 사용자", icon: Symbols.accessible_forward),
          _BarrierFreeContent(isLoading: isLoading)
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BarrierFreeMainCategory(text: "영유아", icon: Symbols.child_care),
          _BarrierFreeContent(isLoading: isLoading)
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BarrierFreeMainCategory(text: "시각장애인", icon: Symbols.blind),
          _BarrierFreeContent(isLoading: isLoading)
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _BarrierFreeMainCategory(text: "청각장애인", icon: Symbols.hearing_aid),
          _BarrierFreeContent(isLoading: isLoading)
        ],
      ),
      const SizedBox(height: 8,)
    ],
  );
}