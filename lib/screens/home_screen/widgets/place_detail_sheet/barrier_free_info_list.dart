import 'package:durume_flutter/models/map_model.dart';
import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/barrier_free_info.dart';
import 'package:durume_flutter/utils/gemini_model_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarrierFreeInfoList extends StatelessWidget {
  const BarrierFreeInfoList({super.key});

  @override
  Widget build(BuildContext context) {
    MapModel mapModel = Provider.of<MapModel>(context);
    // print("${mapModel.detailInfo!["place_name"]}  ${mapModel.detailInfo!["address_name"]}");
    // // 국립중앙박물관
    // Map<String, dynamic> data = {
    //   "parking": "장애인전용 주차구역 있음(지하1층 총 24개가 설치되어 있으며 엘리베이터 이용 가능함)\n장애인주차요금 무료",
    //   "restroom": "장애인 화장실 있음(긴급통보장치 있음)_무장애 편의시설",
    //   "auditorium": "장애인 관람석 있음(대강당 장애인석은 강단 바로 앞에 위치)\n경사로 있음\n극장 용의 장애인석은 출입문 바로 앞에 설치되어 있으며 수평접근이 가능함",
    //   "room": null,
    //   "handicapetc": null,
    //   "wheelchair": "대여 가능(상설전시관 1층)",
    //   "exit": "주 출입구는 턱이 없어 휠체어 접근 가능함",
    //   "elevator": "엘리베이터 있음",
    //   "publictransport": "경사로 이용 가능",
    //   "wheelchairetc": null,
    //   "stroller": "대여 가능(상설전시관 1층)",
    //   "lactationroom": "수유실 있음(1층 문화상품점 맞은편)\n아기침대, 소파, 정수기 등 구비되어 있음",
    //   "babysparechair": null,
    //   "infantsfamilyetc": "아기침대, 소파, 정수기 등 구비되어 있음",
    //   "braileblock": "점자블록 및 점형블록 있음",
    //   "helpdog": "동반 가능",
    //   "audioguide": "음성안내 가이드 있음\n기획전시관 안내데스크와 상설전시관 안네데스크에서 오디오 가이드 대여 가능하며 대여료 3천원",
    //   "brailepromotion": "전시관별로 촉지도식 안내판이 설치되어 있으며 전시물 전면에 점자안내판과 모형이 설치되어 있음\n계단 손잡이에 점자표지판이 설치되어 있음",
    //   "signguide": null,
    //   "videoguide": "한국수어사전 해설동영상 서비스 운영",
    //   "hearinghandicapet": null
    // };
    // // 예술의 전당
    // Map<String, dynamic> data = {
    //   "parking": "지하 주차장에 장애인 전용 주차 구역 있음(주차 요금 할인 없음)",
    //   "restroom": "장애인 화장실 있음(옥상 정원, 지하 2층 전시실, 지하 2층 대극장, 지하 2층 소극장, 지하 1층 콘서트홀, 지하 1층 리사이틀홀, 지하 1층 전시실, 지하 1층 아동극장, 1층 로비, 2층 콘서트홀, 2층 리사이틀홀, 2층 전시실, 2층 소극장)",
    //   "auditorium": "장애인 전용 관람석 있음(콘서트홀, 리사이틀홀, 대극장, 소극장)",
    //   "exit": "주 출입구에 경사로 있음",
    //   "publictransport": "지하철 역에서 지하 통로를 통해 연결",
    //   "elevator": "승강기 있음",
    //   "wheelchair": "대여 가능(지하 1층)",
    //   "stroller": "대여 가능(지하 1층)",
    //   "lactationroom": "수유실 있음(지하 1층)",
    //   "braileblock": "점자 안내 블록 있음",
    //   "helpdog": "동반 가능",
    //   "audioguide": "음성 안내 가이드 있음(콘서트홀, 리사이틀홀, 전시실)",
    //   "brailepromotion": "촉각 안내판 있음(전시실)",
    //   "signguide": "수어 안내 없음",
    //   "videoguide": "영상 안내 없음",
    //   "wheelchairetc": null,
    //   "babysparechair": null,
    //   "infantsfamilyetc": null
    // };
    // // 한국장애인재단
    // Map<String, dynamic> data = {
    //   "parking": "장애인 주차 가능(지하주차장 출입 가능)",
    //   "restroom": "장애인 화장실 있음",
    //   "auditorium": null,
    //   "room": null,
    //   "handicapetc": null,
    //   "wheelchair": null,
    //   "exit": "주 출입구 경사로 있음",
    //   "elevator": "엘리베이터 있음",
    //   "publictransport": null,
    //   "wheelchairetc": null,
    //   "stroller": null,
    //   "lactationroom": null,
    //   "babysparechair": null,
    //   "infantsfamilyetc": null,
    //   "braileblock": null,
    //   "helpdog": "동반 가능",
    //   "audioguide": null,
    //   "brailepromotion": null,
    //   "signguide": null,
    //   "videoguide": null,
    //   "hearinghandicapet": null
    // };
    return FutureBuilder(
      future: getBarrierFreeInfo(
        mapModel.geminiModel,
        mapModel.geminiChatSession,
        placeName: mapModel.detailInfo!["place_name"],
        addressName: mapModel.detailInfo!["address_name"]
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return BarrierFreeInfo(isLoading: true,);
        } else if (snapshot.hasError) {
          print(snapshot.error.toString());
          return BarrierFreeInfo();
        } else {
          Map<String, dynamic> data = snapshot.data as Map<String, dynamic>;
          // print(data.toString());

          if (data.isNotEmpty) {
            return BarrierFreeInfo(barrierFreeInfo: data);
          }
          return BarrierFreeInfo();
        }
      }
    );
    // return BarrierFreeInfo(barrierFreeInfo: data);
  }
}
