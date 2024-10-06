import 'package:durume_flutter/screens/home_screen/widgets/place_detail_sheet/barrier_free_info_widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class BarrierFreeInfo extends StatefulWidget {
  BarrierFreeInfo({
    super.key,
    this.barrierFreeInfo,
    this.isLoading = false
  });

  Map<String, dynamic>? barrierFreeInfo;
  bool isLoading;

  @override
  State<BarrierFreeInfo> createState() => _BarrierFreeInfoState();
}

class _BarrierFreeInfoState extends State<BarrierFreeInfo> {
  bool isModalOpen = false;
  void setIsModalOpen() {
    setState(() {
      isModalOpen = true;
    });
  }

  void resetIsModalOpen() {
    setState(() {
      isModalOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Row(
              children: [
                const Text("무장애 정보", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
                const SizedBox(width: 4,),
                GestureDetector(
                  onTap: () {
                    if (isModalOpen) {
                      resetIsModalOpen();
                    } else {
                      setIsModalOpen();
                    }
                  },
                  child: const Icon(Symbols.info, size: 18,),
                )
              ],
            ),
            const SizedBox(height: 14,),
            widget.isLoading ? NoBarrierFreeDetailInfo(true) :
            widget.barrierFreeInfo == null ? NoBarrierFreeDetailInfo(false) :
            BarrierFreeDetailInfo(widget.barrierFreeInfo!),
          ],
        ),
        isModalOpen ? BarrierFreeInfoModal(resetIsModalOpen) : Container()
      ],
    );
  }
}


// Widget BarrierFreeInfo({
//   Map<String, dynamic>? barrierFreeInfo, bool isLoading = false, bool isModalOpen = false, void Function()? onTap
// }) {
//   return Stack(
//     children: [
//       Column(
//         children: [
//           Row(
//             children: [
//               const Text("무장애 정보", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),),
//               SizedBox(width: 4,),
//               GestureDetector(
//                 onTap: onTap,
//                 child: Icon(Symbols.info, size: 18,),
//               )
//             ],
//           ),
//           const SizedBox(height: 14,),
//           isLoading ? NoBarrierFreeDetailInfo(true) :
//           barrierFreeInfo == null ? NoBarrierFreeDetailInfo(false) :
//           BarrierFreeDetailInfo(barrierFreeInfo),
//         ],
//       ),
//       isModalOpen ? BarrierFreeInfoModal(onTap) : Container()
//     ],
//   );
// }

Widget BarrierFreeDetailInfo(Map<String, dynamic> info) {
  return Column(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarrierFreeMainCategory(text: "장애인 시설", icon: Symbols.accessibility_new, isFirst: true),
          BarrierFreeSubCategory("장애인 주차장", info["parking"]),
          BarrierFreeSubCategory("장애인 화장실", info["restroom"]),
          BarrierFreeSubCategory("장애인 관람석", info["auditorium"]),
          BarrierFreeSubCategory("장애인 전용실", info["room"]),
          BarrierFreeSubCategory("장애인 시설 기타", info["handicapetc"]),
          hasNoValue(info["parking"]) && hasNoValue(info["restroom"]) && hasNoValue(info["auditorium"]) && hasNoValue(info["room"]) && hasNoValue(info["handicapetc"]) ?
          BarrierFreeContent() : Container()
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarrierFreeMainCategory(text: "휠체어 사용자", icon: Symbols.accessible_forward),
          BarrierFreeSubCategory("휠체어 대여", info["wheelchair"]),
          BarrierFreeSubCategory("주출입구 경사로", info["exit"]),
          BarrierFreeSubCategory("이동경로 경사로", info["publictransport"]),
          BarrierFreeSubCategory("엘리베이터", info["elevator"]),
          BarrierFreeSubCategory("휠체어 사용자 기타", info["wheelchairetc"]),
          hasNoValue(info["wheelchair"]) && hasNoValue(info["exit"]) && hasNoValue(info["publictransport"]) && hasNoValue(info["elevator"]) && hasNoValue(info["wheelchairetc"]) ?
          BarrierFreeContent() : Container()
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarrierFreeMainCategory(text: "영유아", icon: Symbols.child_care),
          BarrierFreeSubCategory("유모차 대여", info["stroller"]),
          BarrierFreeSubCategory("수유실", info["lactationroom"]),
          BarrierFreeSubCategory("유아용 의자 대여", info["babysparechair"]),
          BarrierFreeSubCategory("유아 시설 기타", info["infantsfamilyetc"]),
          hasNoValue(info["stroller"]) && hasNoValue(info["lactationroom"]) && hasNoValue(info["babysparechair"]) && hasNoValue(info["infantsfamilyetc"]) ?
          BarrierFreeContent() : Container()
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarrierFreeMainCategory(text: "시각장애인", icon: Symbols.blind),
          BarrierFreeSubCategory("점자블록", info["braileblock"]),
          BarrierFreeSubCategory("안내견 동반", info["helpdog"]),
          BarrierFreeSubCategory("음성안내 가이드", info["audioguide"]),
          BarrierFreeSubCategory("점자안내판", info["brailepromotion"]),
          BarrierFreeSubCategory("시각장애인 시설 기타", info["blindhandicapetc"]),
          hasNoValue(info["braileblock"]) && hasNoValue(info["helpdog"]) && hasNoValue(info["audioguide"]) && hasNoValue(info["brailepromotion"]) && hasNoValue(info["blindhandicapetc"]) ?
          BarrierFreeContent() : Container()
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarrierFreeMainCategory(text: "청각장애인", icon: Symbols.hearing_aid),
          BarrierFreeSubCategory("수화안내", info["signguide"]),
          BarrierFreeSubCategory("비디오 가이드", info["videoguide"]),
          BarrierFreeSubCategory("청각장애인 시설 기타", info["hearinghandicapetc"]),
          hasNoValue(info["signguide"]) && hasNoValue(info["videoguide"]) && hasNoValue(info["hearinghandicapetc"]) ?
          BarrierFreeContent() : Container()
        ],
      ),
      const SizedBox(height: 16,)
    ],
  );
}

Widget NoBarrierFreeDetailInfo(bool isLoading) {
  return Column(
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarrierFreeMainCategory(text: "장애인 시설", icon: Symbols.accessibility_new, isFirst: true),
          BarrierFreeContent(isLoading: isLoading)
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarrierFreeMainCategory(text: "휠체어 사용자", icon: Symbols.accessible_forward),
          BarrierFreeContent(isLoading: isLoading)
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarrierFreeMainCategory(text: "영유아", icon: Symbols.child_care),
          BarrierFreeContent(isLoading: isLoading)
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarrierFreeMainCategory(text: "시각장애인", icon: Symbols.blind),
          BarrierFreeContent(isLoading: isLoading)
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BarrierFreeMainCategory(text: "청각장애인", icon: Symbols.hearing_aid),
          BarrierFreeContent(isLoading: isLoading)
        ],
      ),
      const SizedBox(height: 8,)
    ],
  );
}
