import 'dart:convert';

import 'package:google_generative_ai/google_generative_ai.dart';

Future<Map<String, dynamic>?> getBarrierFreeInfo(
    ChatSession? geminiChatSession, {String placeName = "", String addressName = ""}
) async {
  if (geminiChatSession == null) {
    return null;
    // Fluttertoast.showToast(msg: "잠시후 다시 시도해주세요.");
  } else {
    final response = await geminiChatSession!.sendMessage(
        Content.text("장소명: $placeName\n주소: $addressName"),
    );
    // final response = await geminiModel!.generateContent(
    //     [Content.text("장소명: $placeName\n주소: $addressName")],
    //     generationConfig: GenerationConfig(temperature: 0, topP: 1, topK: 4)
    // );
    if (response.text != null) {
      try {
        return jsonDecode(response.text!.substring(
            response.text!.indexOf("{"), response.text!.lastIndexOf("}")+1
        ));
      } catch(e) {
        return null;
      }
    }
  }
  return null;
}

ChatSession? getGeminiChatSession(String? apiKey) {
  if (apiKey == null) return null;
  GenerativeModel geminiModel = GenerativeModel(
    model: "gemini-1.5-pro",
    apiKey: apiKey,
    generationConfig: GenerationConfig(temperature: 0, topP: 1, topK: 4)
  );

  final chat = geminiModel.startChat();
  chat.sendMessage(Content.text(initialPrompt));

  return chat;
}

// GenerativeModel? getGeminiModel(String? apiKey) {
//   if (apiKey == null) return null;
//   GenerativeModel? geminiModel = GenerativeModel(
//     model: "gemini-1.5-pro",
//     apiKey: apiKey,
//   );
//   if (geminiModel == null) null;
//
//   final chat = geminiModel.startChat();
//   chat.sendMessage(Content.text(initialPrompt));
//
//   return geminiModel;
// }

String initialPrompt = "$rolePrompt\n\n$requestPrompt\n\n$responsePrompt\n\n$emphasisPrompt";

String rolePrompt = "너는 무장애 정보 전문가야. 너의 주요 목표는 내가 전달할 장소의 장애인 시설에 관한 정보를 전달하는 것이야.";
String requestPrompt = '''
  내가 전달할 장소는 장소명, 주소로 전달할거야. 예를 들면 다음과 같아.
  장소명 : 국립중앙박물관
  주소 : 서울 용산구 서빙고로 137 국립중앙박물관
''';
String responsePrompt = '''
  너는 입력한 장소에 대해서 아래 항목들에 대해 탐색해야 해. 정확한 정보만 탐색하고 정보가 부족한 경우엔 빈값으로 결과를 주어야 해.
  parking : 장애인 주차장
  restroom : 장애인 화장실
  auditorium : 장애인 관람석
  room : 장애인 전용실
  handicapetc : 기타 장애인 시설
  wheelchair : 휠체어 대여
  exit : 주출입구 경사로
  publictransport : 이동경로 경사로
  elevator : 엘레베이터
  wheelchairetc : 기타 휠체어 사용자 관련 시설
  stroller : 유모차 대여
  lactationroom : 수유실
  babysparechair : 유아용 의자
  infantsfamilyetc : 기타 유아 시설
  braileblock : 점자블록
  helpdog : 안내견 동반
  audioguide : 음성안내 가이드
  brailepromotion : 점자 안내판, 촉지도식 안내판
  blindhandicapetc : 기타 시각장애인 시설
  signguide : 수어 안내
  videoguide : 비디오 가이드
  hearinghandicapetc : 기타 청각장애인 시설
  
  응답값은 아래 예시와 같이 json 형태로 제공해. 다른 말은 덧붙이지마. ```이나 json이라는 말도 절대 덧붙이지마.
  {
     "parking": "장애인전용 주차구역 있음(지하1층 총 24개가 설치되어 있으며 엘리베이터 이용 가능함)\n장애인주차요금 무료",
     "route": "",
     "publictransport": "경사로 이용 가능",
     "ticketoffice": "",
     "promotion": "있음(편의시설 안내 리플렛/안내데스크)",
     "wheelchair": "대여 가능(상설전시관 1층)",
     "exit": "주 출입구는 턱이 없어 휠체어 접근 가능함",
     "elevator": "엘리베이터 있음",
     "restroom": "장애인 화장실 있음(긴급통보장치 있음)_무장애 편의시설",
     "auditorium": "장애인 관람석 있음(대강당 장애인석은 강단 바로 앞에 위치)\n경사로 있음\n극장 용의 장애인석은 출입문 바로 앞에 설치되어 있으며 수평접근이 가능함",
     "room": "",
     "handicapetc": "",
     "braileblock": "점자블록 및 점형블록 있음",
     "helpdog": "동반 가능",
     "guidehuman": "",
     "audioguide": "음성안내 가이드 있음\n기획전시관 안내데스크와 상설전시관 안네데스크에서 오디오 가이드 대여 가능하며 대여료 3천원",
     "bigprint": "",
     "brailepromotion": "전시관별로 촉지도식 안내판이 설치되어 있으며 전시물 전면에 점자안내판과 모형이 설치되어 있음\n계단 손잡이에 점자표지판이 설치되어 있음",
     "guidesystem": "",
     "blindhandicapetc": "",
     "signguide": "",
     "videoguide": "한국수어사전 해설동영상 서비스 운영",
     "hearingroom": "",
     "hearinghandicapetc": "",
     "stroller": "대여 가능(상설전시관 1층)",
     "lactationroom": "수유실 있음(1층 문화상품점 맞은편)\n아기침대, 소파, 정수기 등 구비되어 있음",
     "babysparechair": "",
     "infantsfamilyetc": "아기침대, 소파, 정수기 등 구비되어 있음"
  }
  
''';

String emphasisPrompt = '''
  각 항목들에 대한 정보를 조회할 때 아래 키워드에 주목해.
  parking : 장애인 전용 주차장, 장애인 주차 구역, 장애인 전용 주차 공간, Accessible Parking Space, 휠체어 사용자 주차, Wheelchair Accessible Parking, 장애인 차량 주차장, Handicapped Vehicle Parking, 전용 주차 구역, Reserved Parking Area, 장애인 차량 전용 주차, Accessible Vehicle Parking
  auditorium : 장애인 전용 좌석, Disabled Seating, 휠체어 접근 좌석, Wheelchair Accessible Seating, 장애인 관람 공간, Disabled Viewing Area, 특별 좌석, Special Seating, 장애인용 관람석, Handicapped Seating, 접근 가능한 좌석, Accessible Seats, 이동 편의 좌석, Mobility-Friendly Seating
  restroom : 장애인 화장실, Disabled Restroom, 휠체어 사용자를 위한 화장실, Wheelchair Accessible Restroom, 장애인용 화장실, Handicapped Toilet, 장애인 편의 화장실, Accessible Toilet, 장애인 전용 화장실, Handicapped Restroom, 장애인 욕실, Accessible Bathroom, 이동 편의 화장실, Mobility-Friendly Bathroom
  exit : 출입구 경사로, Entrance Ramp, 주요 경사로, Main Ramp, 휠체어 접근 경사로, Wheelchair Accessible Ramp, 주출입구 경사로, Main Entry Ramp, 접근 가능한 경사로, Accessible Ramp, 주요 출입 경사로, Primary Entrance Ramp, 주 출입구 접근 경사로, Main Entrance Accessibility Ramp
  publictransport : 경로 경사로, Path Ramp, 이동 경사로, Mobility Ramp, 접근 가능한 경로, Accessible Pathway, 휠체어 사용자를 위한 경사로, Wheelchair Accessible, 이동 편의 경로, Mobility-Friendly Path, 주요 경로 경사로, Main Path Ramp, 접근 가능한 이동 경로, Accessible Mobility Path
  elevator : 승강기, Lift, 휠체어 사용자를 위한 엘리베이터, Wheelchair Accessible Elevator, 접근 가능한 승강기, Accessible Lift, 장애인 전용 승강기, Handicapped Lift, 다목적 승강기, Multifunctional Elevator, 대형 엘리베이터, Large Elevator, 장애인 엘리베이터, Disabled Elevator
  stroller : 유모차 대여 서비스, Stroller Rental Service, 유아용 카시트 대여, Infant Car Seat Rental, 아기 유모차 대여, Baby Stroller Rental, 아기 카트 대여, Baby Cart Rental, 유모차 대여점, Stroller Rental Shop, 이동 편의 유모차 대여, Mobility-Friendly Stroller Rental, 유모차 임대, Stroller Hire
  feeding : 모유 수유실, Breastfeeding Room, 유아 수유 공간, Infant Nursing Area, 아기 수유실, Baby Feeding Room, 부모 대기실, Parenting Room, 아기 수유 구역, Baby Nursing Zone, 수유 시설, Nursing Facility, 수유 전용 공간, Feeding Area
  babychair : 아기용 의자 대여, Baby Chair Rental, 유아용 식사 의자, Infant Dining Chair, 유아용 고정 의자 대여, Toddler Booster Seat Rental, 유아 의자 대여, Child Chair Rental, 식사용 의자 대여, Dining Chair Rental, 아기 식사 의자, Baby Dining Chair, 유아 전용 의자, Toddler High Chair
  braileblock : 점자 안내블록, Braille Guidance Block, 점자 경로, Braille Path, 점자 도로, Braille Road, 점자 표지판, Braille Sign, 점자 전용 블록, Braille Specific Block, 점자 안내 바닥, Braille Guidance Surface, 점자 지시 블록, Braille Instruction Block
  helpdog : 안내견 허용, Guide Dog Allowed, 동반견 허용, Assistance Dog Allowed, 서비스견 동반 가능, Service Dog Friendly, 안내견 이용 가능, Guide Dog Accessible, 장애인 보조견 동반, Assistance Dog Accompanied, 동반견 출입 가능, Companion Dog Entry Allowed, 안내견 수용, Guide Dog Accommodated
  audioguide : 음성 안내 시스템, Audio Assistance System, 음성 안내 서비스, Audio Guidance Service, 음성 가이드, Voice Guide, 오디오 가이드, Audio Tour Guide, 음성 해설, Audio Commentary, 청각 안내, Auditory Guidance, 음성 지원 서비스, Voice Assistance Service
  tactile : 촉각 안내판, Tactile Information Board, 촉각 지도, Tactile Map, 촉각 경로 안내판, Tactile Pathway Sign, 촉각 안내 기호, Tactile Guidance Sign, 촉각 정보판, Tactile Info Board, 촉각 안내 지도, Tactile Guidance Map, 감각 안내판, Sensory Information Sign
  sign : 수어 통역, Sign Language Interpretation, 수어 서비스, Sign Language Service, 수어 안내, Sign Language Assistance, 수어 사용 안내, Sign Language Usage Guidance, 수어 지원, Sign Language Support, 수어 통역 서비스, Sign Language Interpreting Service, 수어 커뮤니케이션, Sign Language Communication
  video : 영상 안내, Video Assistance, 비디오 투어, Video Tour, 비디오 해설, Video Commentary, 영상 가이드, Video Guidance, 비디오 안내 시스템, Video Guidance System, 멀티미디어 가이드, Multimedia Guide, 비디오 교육, Video Instruction
  wheelchair : 휠체어 대여, wheelchair rental, wheelchair available, 휠체어 사용 가능, wheelchair access, wheelchair access, 휠체어 접근, wheelchair service, 휠체어 서비스
''';

String barrierFreeInfoModalText = "해당 무장애 정보는 인공지능 LLM 모델인 Google Gemini 1.5를 통해 제공됩니다. 정보 정확성에 일부 한계가 있을 수 있으니, 참고용으로만 사용해 주시기 바랍니다.";

// String prompt(String roadAddress, String placeName) => '''
//   너는 무장애 여행 가이드로서, 장애인과 비장애인 모두가 방문할 수 있는 장소에 대한 정보를 제공하는 전문가야.
//   너의 주요 목표는 해당 장소의 접근성에 관한 정보를 사용자에게 명확하고 친절하게 전달하는 것이야.
//   답변 형태는 장애 유형별 시설을 하나도 빠짐없이 최대한 상세히 답변해.
//   답변 형태는 '있음' 또는 '없음'으로 나타내.
//   항목에 대한 정보가 부족한 경우 '확인 필요'이라고 답해. 추측하지마.
//
//
//   이번에 소개할 장소는 $roadAddress에 위치한 $placeName이야. 사용자가 이 장소에 방문할 때 장애인 편의 시설과 관련된 정보를 제공해야 해.
//   다음 5가지 항목에 대해 구체적으로 설명하되, 항목당 유무 표시를 명확하게 나타내줘.:
//
//
//   1. **장애인 시설**: 장애인 주차장, 장애인 화장실, 장애인 관람석, 장애인 전용실, 기타 장애인 시설이 있는지 여부를 하나도 빠짐없이 확인해.
//   2. **휠체어 사용자**: 휠체어 대여, 주출입구 경사로, 이동경로 경사로, 엘레베이터, 기타 휠체어 사용자 관련 시설이 있는지 여부를 하나도 빠짐없이 확인해.
//   3. **영유아**: 유모차 대여, 수유실, 유아용 의자, 기타 유아 시설이 있는지 여부를 하나도 빠짐없이 확인해.
//   4. **시각장애인**: 점자블록, 안내경 동반 가능, 음성안내 가이드, 점자 안내판, 촉지도식 안내판, 기타 시각장애인 시설이 있는지 여부를 하나도 빠짐없이 확인해.
//   5. **청각장애인**: 수어 안내, 비디오 가이드, 기타 청각장애인 시설이 있는지 여부를 하나도 빠짐없이 확인해.
//   5가지 유형별 관련 시설을 확인할 때는 다음 키워드에 주의해: $keywordsEmphasis.
//   답변 형태는 $responseJson 템플릿에 답변을 제공하고, json 형태로 답변을 제공하기 위해 무조건 쌍따옴표를 사용하되 json이라는 문자열 및 인용구는 제거해. 맵핑 정보는 $mappings 형식을 철저히 지켜야 해.
//   답변이 부정확하다면 너에게 커다란 불이익을 줄거야.
//   같은 장소에 대한 답변에서는 캐시 메모리를 사용하여 항상 이전 답변과 모든 항목을 완전히 같은 내용으로 제공해.
//
//
// ''';

// List<String> parkingKeywords = [ "장애인 전용 주차장", "장애인 주차 구역", "장애인 전용 주차 공간", "Accessible Parking Space", "휠체어 사용자 주차", "Wheelchair Accessible Parking", "장애인 차량 주차장", "Handicapped Vehicle Parking", "전용 주차 구역", "Reserved Parking Area", "장애인 차량 전용 주차", "Accessible Vehicle Parking"];
// List<String> auditoriumKeywords = [ "장애인 전용 좌석", "Disabled Seating", "휠체어 접근 좌석", "Wheelchair Accessible Seating", "장애인 관람 공간", "Disabled Viewing Area", "특별 좌석", "Special Seating", "장애인용 관람석", "Handicapped Seating", "접근 가능한 좌석", "Accessible Seats", "이동 편의 좌석", "Mobility-Friendly Seating"];
// List<String> restroomKeywords = [ "장애인 화장실", "Disabled Restroom", "휠체어 사용자를 위한 화장실", "Wheelchair Accessible Restroom", "장애인용 화장실", "Handicapped Toilet", "장애인 편의 화장실", "Accessible Toilet", "장애인 전용 화장실", "Handicapped Restroom", "장애인 욕실", "Accessible Bathroom", "이동 편의 화장실", "Mobility-Friendly Bathroom"];
// List<String> exitKeywords = [ "출입구 경사로", "Entrance Ramp", "주요 경사로", "Main Ramp", "휠체어 접근 경사로", "Wheelchair Accessible Ramp", "주출입구 경사로", "Main Entry Ramp", "접근 가능한 경사로", "Accessible Ramp", "주요 출입 경사로", "Primary Entrance Ramp", "주 출입구 접근 경사로", "Main Entrance Accessibility Ramp"];
// List<String> publicTransportKeywords =[ "경로 경사로", "Path Ramp", "이동 경사로", "Mobility Ramp", "접근 가능한 경로", "Accessible Pathway", "휠체어 사용자를 위한 경사로", "Wheelchair Accessible", "이동 편의 경로", "Mobility-Friendly Path", "주요 경로 경사로", "Main Path Ramp", "접근 가능한 이동 경로", "Accessible Mobility Path"];
// List<String> elevatorKeywords = [ "승강기", "Lift", "휠체어 사용자를 위한 엘리베이터", "Wheelchair Accessible Elevator", "접근 가능한 승강기", "Accessible Lift", "장애인 전용 승강기", "Handicapped Lift", "다목적 승강기", "Multifunctional Elevator", "대형 엘리베이터", "Large Elevator", "장애인 엘리베이터", "Disabled Elevator"];
// List<String> strollerKeywords = [ "유모차 대여 서비스", "Stroller Rental Service", "유아용 카시트 대여", "Infant Car Seat Rental", "아기 유모차 대여", "Baby Stroller Rental", "아기 카트 대여", "Baby Cart Rental", "유모차 대여점", "Stroller Rental Shop", "이동 편의 유모차 대여", "Mobility-Friendly Stroller Rental", "유모차 임대", "Stroller Hire"];
// List<String> feedingKeywords = [ "모유 수유실", "Breastfeeding Room", "유아 수유 공간", "Infant Nursing Area", "아기 수유실", "Baby Feeding Room", "부모 대기실", "Parenting Room", "아기 수유 구역", "Baby Nursing Zone", "수유 시설", "Nursing Facility", "수유 전용 공간", "Feeding Area" ];
// List<String> babyChairKeywords = [ "아기용 의자 대여", "Baby Chair Rental", "유아용 식사 의자", "Infant Dining Chair", "유아용 고정 의자 대여", "Toddler Booster Seat Rental", "유아 의자 대여", "Child Chair Rental", "식사용 의자 대여", "Dining Chair Rental", "아기 식사 의자", "Baby Dining Chair", "유아 전용 의자", "Toddler High Chair"];
// List<String> brailleBlockKeywords = [ "점자 안내블록", "Braille Guidance Block", "점자 경로", "Braille Path", "점자 도로", "Braille Road", "점자 표지판", "Braille Sign", "점자 전용 블록", "Braille Specific Block", "점자 안내 바닥", "Braille Guidance Surface", "점자 지시 블록", "Braille Instruction Block"];
// List<String> helpDogKeywords = [ "안내견 허용", "Guide Dog Allowed", "동반견 허용", "Assistance Dog Allowed", "서비스견 동반 가능", "Service Dog Friendly", "안내견 이용 가능", "Guide Dog Accessible", "장애인 보조견 동반", "Assistance Dog Accompanied", "동반견 출입 가능", "Companion Dog Entry Allowed", "안내견 수용", "Guide Dog Accommodated"];
// List<String> audioGuideKeywords = [ "음성 안내 시스템", "Audio Assistance System", "음성 안내 서비스", "Audio Guidance Service", "음성 가이드", "Voice Guide", "오디오 가이드", "Audio Tour Guide", "음성 해설", "Audio Commentary", "청각 안내", "Auditory Guidance", "음성 지원 서비스", "Voice Assistance Service"];
// List<String> tactileKeywords = [ "촉각 안내판", "Tactile Information Board", "촉각 지도", "Tactile Map", "촉각 경로 안내판", "Tactile Pathway Sign", "촉각 안내 기호", "Tactile Guidance Sign", "촉각 정보판", "Tactile Info Board", "촉각 안내 지도", "Tactile Guidance Map", "감각 안내판", "Sensory Information Sign"];
// List<String> signKeywords =[ "수어 통역", "Sign Language Interpretation", "수어 서비스", "Sign Language Service", "수어 안내", "Sign Language Assistance", "수어 사용 안내", "Sign Language Usage Guidance", "수어 지원", "Sign Language Support", "수어 통역 서비스", "Sign Language Interpreting Service", "수어 커뮤니케이션", "Sign Language Communication"];
// List<String> videoKeywords = [ "영상 안내", "Video Assistance", "비디오 투어", "Video Tour", "비디오 해설", "Video Commentary", "영상 가이드", "Video Guidance", "비디오 안내 시스템", "Video Guidance System", "멀티미디어 가이드", "Multimedia Guide", "비디오 교육", "Video Instruction"];
// List<String> wheelchairKeywords = ["휠체어 대여", "wheelchair rental", "wheelchair available", "휠체어 사용 가능", "wheelchair access", "wheelchair access", "휠체어 접근", "wheelchair service", "휠체어 서비스"];
//
// String keywordsEmphasis = "${restroomKeywords.join(", ")}, ${parkingKeywords.join(", ")}, ${auditoriumKeywords.join(", ")}, ${exitKeywords.join(", ")}, ${publicTransportKeywords.join(", ")}, ${elevatorKeywords.join(", ")}, ${strollerKeywords.join(", ")}, ${feedingKeywords.join(", ")}, ${babyChairKeywords.join(", ")}, ${brailleBlockKeywords.join(", ")}, ${helpDogKeywords.join(", ")}, ${tactileKeywords.join(", ")}, ${signKeywords.join(", ")}, ${videoKeywords.join(", ")}, ${wheelchairKeywords.join(", ")}";
//
// Object responseJson = {
//   "disabled_facilities": {
//     "parking": "",
//     "restroom": "",
//     "auditorium": "",
//     "room": "",
//     "handicapetc": ""
//   },
//   "wheelchair_user": {
//     "wheelchair": "",
//     "exit": "",
//     "publictransport": "",
//     "elevator": "",
//     "wheelchairetc": ""
//   },
//   "infant": {
//     "stroller": "",
//     "lactationroom": "",
//     "babysparechair": "",
//     "infantsfamilyetc": ""
//   },
//   "visually_impaired": {
//     "braileblock": "",
//     "helpdog": "",
//     "audioguide": "",
//     "brailepromotion": "",
//     "blindhandicapetc": ""
//   },
//   "hearing_impaired": {
//     "signguide": "",
//     "videoguide": "",
//     "hearinghandicapetc": ""
//   }
// };
//
// Object mappings = {
//   "장애인 주차장": ("disabled_facilities", "parking"),
//   "장애인 화장실": ("disabled_facilities", "restroom"),
//   "장애인 관람석": ("disabled_facilities", "auditorium"),
//   "장애인 전용실": ("disabled_facilities", "room"),
//   "기타 장애인 시설": ("disabled_facilities", "handicapetc"),
//   "휠체어 대여": ("wheelchair_user", "wheelchair"),
//   "주출입구 경사로": ("wheelchair_user", "exit"),
//   "이동경로 경사로": ("wheelchair_user", "publictransport"),
//   "엘레베이터": ("wheelchair_user", "elevator"),
//   "기타 휠체어 사용자 관련 시설": ("wheelchair_user", "wheelchairetc"),
//   "유모차 대여": ("infant", "stroller"),
//   "수유실": ("infant", "lactationroom"),
//   "유아용 의자": ("infant", "babysparechair"),
//   "기타 유아 시설": ("infant", "infantsfamilyetc"),
//   "점자블록": ("visually_impaired", "braileblock"),
//   "안내견 동반 가능": ("visually_impaired", "helpdog"),
//   "음성안내 가이드": ("visually_impaired", "audioguide"),
//   "점자 안내판": ("visually_impaired", "brailepromotion"),
//   "촉지도식 안내판": ("visually_impaired", "blindhandicapetc"),
//   "기타 시각장애인 시설": ("visually_impaired", "blindhandicapetc"),
//   "수어 안내": ("hearing_impaired", "signguide"),
//   "비디오 가이드": ("hearing_impaired", "videoguide"),
//   "기타 청각장애인 시설": ("hearing_impaired", "hearinghandicapetc")
// };
//
// String getSubCategory(String category) {
//   // 장애인 시설
//   if (category == "parking") "장애인 주차장";
//   if (category == "restroom") "장애인 화장실";
//   if (category == "auditorium") "장애인 관람석";
//   if (category == "room") "장애인 전용실";
//   if (category == "handicapetc") "장애인 시설 기타";
//   // 휠체어 사용자
//   if (category == "wheelchair") "휠체어 대여";
//   if (category == "exit") "주출입구 경사로";
//   if (category == "publictransport") "이동경로 경사로";
//   if (category == "elevator") "엘레베이터";
//   if (category == "wheelchairetc") "휠체어 사용자 기타";
//   // 영유아
//   if (category == "stroller") "유모차 대여";
//   if (category == "lactationroom") "수유실";
//   if (category == "babysparechair") "유아용 의자 대여";
//   if (category == "infantsfamilyetc") "유아 시설 기타";
//   // 시각장애인
//   if (category == "braileblock") "점자블록";
//   if (category == "helpdog") "안내견 동반";
//   if (category == "audioguide") "음성안내 가이드";
//   if (category == "brailepromotion") "점자안내판";
//   if (category == "blindhandicapetc") "시각장애인 시설 기타";
//   // 청각장애인
//   if (category == "signguide") "수화안내";
//   if (category == "videoguide") "비디오 가이드";
//   if (category == "hearinghandicapetc") "청각장애인 시설 기타";
//
//   return "";
// }

Map<String, dynamic> barrierFreeInfoExample = {
  "parking": "덕수궁 내 주차장 없음\n인근 공영주차장 이용(서울시청 주차장, 정동길 노상 공영주차장 등)",
  "restroom": "장애인 화장실 있음(덕수궁 내 2곳 위치)",
  "auditorium": null,
  "room": null,
  "handicapetc": "휠체어, 유모차 대여 가능\n보관함 이용 가능\n화장실 내 비상벨 설치",
  "wheelchair": "대여 가능(정문 매표소 옆)",
  "exit": "경사로 있음(정문, 대한문, 서문)",
  "publictransport": "경사로 있음(일부 구간 제외)",
  "elevator": "없음",
  "wheelchairetc": "휠체어 리프트 있음(중화전, 함녕전)",
  "stroller": "대여 가능(정문 매표소 옆)",
  "lactationroom": "없음",
  "babysparechair": null,
  "infantsfamilyetc": null,
  "braileblock": "점자블록 설치(주요 건물 진입로)",
  "helpdog": "동반 가능",
  "audioguide": "음성안내 가이드 있음(한국어, 영어, 일본어, 중국어)",
  "brailepromotion": "촉지도식 안내판 있음(정문)",
  "blindhandicapetc": null,
  "signguide": "수어 안내 없음",
  "videoguide": "비디오 가이드 없음",
  "hearinghandicapetc": null
};

