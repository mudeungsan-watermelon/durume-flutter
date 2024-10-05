import 'package:google_generative_ai/google_generative_ai.dart';

GenerativeModel? getGeminiModel(String? apiKey) {
  if (apiKey == null) return null;
  return GenerativeModel(
    model: "gemini-1.5-pro",
    apiKey: apiKey,
    // generationConfig: GenerationConfig(responseMimeType: 'application/json', responseSchema: schema)
  );
}

String prompt(String roadAddress, String placeName) => '''
  너는 무장애 여행 가이드로서, 장애인과 비장애인 모두가 방문할 수 있는 장소에 대한 정보를 제공하는 전문가야.
  너의 주요 목표는 해당 장소의 접근성에 관한 정보를 사용자에게 명확하고 친절하게 전달하는 것이야.
  답변 형태는 장애 유형별 시설을 하나도 빠짐없이 최대한 상세히 답변해.
  답변 형태는 '있음' 또는 '없음'으로 나타내.
  항목에 대한 정보가 부족한 경우 '확인 필요'이라고 답해. 추측하지마.


  이번에 소개할 장소는 $roadAddress에 위치한 $placeName이야. 사용자가 이 장소에 방문할 때 장애인 편의 시설과 관련된 정보를 제공해야 해.
  다음 5가지 항목에 대해 구체적으로 설명하되, 항목당 유무 표시를 명확하게 나타내줘.:
  
  
  1. **장애인 시설**: 장애인 주차장, 장애인 화장실, 장애인 관람석, 장애인 전용실, 기타 장애인 시설이 있는지 여부를 하나도 빠짐없이 확인해.
  2. **휠체어 사용자**: 휠체어 대여, 주출입구 경사로, 이동경로 경사로, 엘레베이터, 기타 휠체어 사용자 관련 시설이 있는지 여부를 하나도 빠짐없이 확인해.
  3. **영유아**: 유모차 대여, 수유실, 유아용 의자, 기타 유아 시설이 있는지 여부를 하나도 빠짐없이 확인해.
  4. **시각장애인**: 점자블록, 안내경 동반 가능, 음성안내 가이드, 점자 안내판, 촉지도식 안내판, 기타 시각장애인 시설이 있는지 여부를 하나도 빠짐없이 확인해.
  5. **청각장애인**: 수어 안내, 비디오 가이드, 기타 청각장애인 시설이 있는지 여부를 하나도 빠짐없이 확인해.
  5가지 유형별 관련 시설을 확인할 때는 다음 키워드에 주의해: $keywordsEmphasis.
  답변 형태는 $responseJson 템플릿에 답변을 제공하고, json 형태로 답변을 제공하기 위해 무조건 쌍따옴표를 사용하되 json이라는 문자열 및 인용구는 제거해. 맵핑 정보는 $mappings 형식을 철저히 지켜야 해.
  답변이 부정확하다면 너에게 커다란 불이익을 줄거야.
  같은 장소에 대한 답변에서는 캐시 메모리를 사용하여 항상 이전 답변과 모든 항목을 완전히 같은 내용으로 제공해.
  
  
''';

List<String> parkingKeywords = [ "장애인 전용 주차장", "장애인 주차 구역", "장애인 전용 주차 공간", "Accessible Parking Space", "휠체어 사용자 주차", "Wheelchair Accessible Parking", "장애인 차량 주차장", "Handicapped Vehicle Parking", "전용 주차 구역", "Reserved Parking Area", "장애인 차량 전용 주차", "Accessible Vehicle Parking"];
List<String> auditoriumKeywords = [ "장애인 전용 좌석", "Disabled Seating", "휠체어 접근 좌석", "Wheelchair Accessible Seating", "장애인 관람 공간", "Disabled Viewing Area", "특별 좌석", "Special Seating", "장애인용 관람석", "Handicapped Seating", "접근 가능한 좌석", "Accessible Seats", "이동 편의 좌석", "Mobility-Friendly Seating"];
List<String> restroomKeywords = [ "장애인 화장실", "Disabled Restroom", "휠체어 사용자를 위한 화장실", "Wheelchair Accessible Restroom", "장애인용 화장실", "Handicapped Toilet", "장애인 편의 화장실", "Accessible Toilet", "장애인 전용 화장실", "Handicapped Restroom", "장애인 욕실", "Accessible Bathroom", "이동 편의 화장실", "Mobility-Friendly Bathroom"];
List<String> exitKeywords = [ "출입구 경사로", "Entrance Ramp", "주요 경사로", "Main Ramp", "휠체어 접근 경사로", "Wheelchair Accessible Ramp", "주출입구 경사로", "Main Entry Ramp", "접근 가능한 경사로", "Accessible Ramp", "주요 출입 경사로", "Primary Entrance Ramp", "주 출입구 접근 경사로", "Main Entrance Accessibility Ramp"];
List<String> publicTransportKeywords =[ "경로 경사로", "Path Ramp", "이동 경사로", "Mobility Ramp", "접근 가능한 경로", "Accessible Pathway", "휠체어 사용자를 위한 경사로", "Wheelchair Accessible", "이동 편의 경로", "Mobility-Friendly Path", "주요 경로 경사로", "Main Path Ramp", "접근 가능한 이동 경로", "Accessible Mobility Path"];
List<String> elevatorKeywords = [ "승강기", "Lift", "휠체어 사용자를 위한 엘리베이터", "Wheelchair Accessible Elevator", "접근 가능한 승강기", "Accessible Lift", "장애인 전용 승강기", "Handicapped Lift", "다목적 승강기", "Multifunctional Elevator", "대형 엘리베이터", "Large Elevator", "장애인 엘리베이터", "Disabled Elevator"];
List<String> strollerKeywords = [ "유모차 대여 서비스", "Stroller Rental Service", "유아용 카시트 대여", "Infant Car Seat Rental", "아기 유모차 대여", "Baby Stroller Rental", "아기 카트 대여", "Baby Cart Rental", "유모차 대여점", "Stroller Rental Shop", "이동 편의 유모차 대여", "Mobility-Friendly Stroller Rental", "유모차 임대", "Stroller Hire"];
List<String> feedingKeywords = [ "모유 수유실", "Breastfeeding Room", "유아 수유 공간", "Infant Nursing Area", "아기 수유실", "Baby Feeding Room", "부모 대기실", "Parenting Room", "아기 수유 구역", "Baby Nursing Zone", "수유 시설", "Nursing Facility", "수유 전용 공간", "Feeding Area" ];
List<String> babyChairKeywords = [ "아기용 의자 대여", "Baby Chair Rental", "유아용 식사 의자", "Infant Dining Chair", "유아용 고정 의자 대여", "Toddler Booster Seat Rental", "유아 의자 대여", "Child Chair Rental", "식사용 의자 대여", "Dining Chair Rental", "아기 식사 의자", "Baby Dining Chair", "유아 전용 의자", "Toddler High Chair"];
List<String> brailleBlockKeywords = [ "점자 안내블록", "Braille Guidance Block", "점자 경로", "Braille Path", "점자 도로", "Braille Road", "점자 표지판", "Braille Sign", "점자 전용 블록", "Braille Specific Block", "점자 안내 바닥", "Braille Guidance Surface", "점자 지시 블록", "Braille Instruction Block"];
List<String> helpDogKeywords = [ "안내견 허용", "Guide Dog Allowed", "동반견 허용", "Assistance Dog Allowed", "서비스견 동반 가능", "Service Dog Friendly", "안내견 이용 가능", "Guide Dog Accessible", "장애인 보조견 동반", "Assistance Dog Accompanied", "동반견 출입 가능", "Companion Dog Entry Allowed", "안내견 수용", "Guide Dog Accommodated"];
List<String> audioGuideKeywords = [ "음성 안내 시스템", "Audio Assistance System", "음성 안내 서비스", "Audio Guidance Service", "음성 가이드", "Voice Guide", "오디오 가이드", "Audio Tour Guide", "음성 해설", "Audio Commentary", "청각 안내", "Auditory Guidance", "음성 지원 서비스", "Voice Assistance Service"];
List<String> tactileKeywords = [ "촉각 안내판", "Tactile Information Board", "촉각 지도", "Tactile Map", "촉각 경로 안내판", "Tactile Pathway Sign", "촉각 안내 기호", "Tactile Guidance Sign", "촉각 정보판", "Tactile Info Board", "촉각 안내 지도", "Tactile Guidance Map", "감각 안내판", "Sensory Information Sign"];
List<String> signKeywords =[ "수어 통역", "Sign Language Interpretation", "수어 서비스", "Sign Language Service", "수어 안내", "Sign Language Assistance", "수어 사용 안내", "Sign Language Usage Guidance", "수어 지원", "Sign Language Support", "수어 통역 서비스", "Sign Language Interpreting Service", "수어 커뮤니케이션", "Sign Language Communication"];
List<String> videoKeywords = [ "영상 안내", "Video Assistance", "비디오 투어", "Video Tour", "비디오 해설", "Video Commentary", "영상 가이드", "Video Guidance", "비디오 안내 시스템", "Video Guidance System", "멀티미디어 가이드", "Multimedia Guide", "비디오 교육", "Video Instruction"];
List<String> wheelchairKeywords = ["휠체어 대여", "wheelchair rental", "wheelchair available", "휠체어 사용 가능", "wheelchair access", "wheelchair access", "휠체어 접근", "wheelchair service", "휠체어 서비스"];

String keywordsEmphasis = "${restroomKeywords.join(", ")}, ${parkingKeywords.join(", ")}, ${auditoriumKeywords.join(", ")}, ${exitKeywords.join(", ")}, ${publicTransportKeywords.join(", ")}, ${elevatorKeywords.join(", ")}, ${strollerKeywords.join(", ")}, ${feedingKeywords.join(", ")}, ${babyChairKeywords.join(", ")}, ${brailleBlockKeywords.join(", ")}, ${helpDogKeywords.join(", ")}, ${tactileKeywords.join(", ")}, ${signKeywords.join(", ")}, ${videoKeywords.join(", ")}, ${wheelchairKeywords.join(", ")}";

Object responseJson = {
  "disabled_facilities": {
    "parking": "",
    "restroom": "",
    "auditorium": "",
    "room": "",
    "handicapetc": ""
  },
  "wheelchair_user": {
    "wheelchair": "",
    "exit": "",
    "publictransport": "",
    "elevator": "",
    "wheelchairetc": ""
  },
  "infant": {
    "stroller": "",
    "lactationroom": "",
    "babysparechair": "",
    "infantsfamilyetc": ""
  },
  "visually_impaired": {
    "braileblock": "",
    "helpdog": "",
    "audioguide": "",
    "brailepromotion": "",
    "blindhandicapetc": ""
  },
  "hearing_impaired": {
    "signguide": "",
    "videoguide": "",
    "hearinghandicapetc": ""
  }
};

Object mappings = {
  "장애인 주차장": ("disabled_facilities", "parking"),
  "장애인 화장실": ("disabled_facilities", "restroom"),
  "장애인 관람석": ("disabled_facilities", "auditorium"),
  "장애인 전용실": ("disabled_facilities", "room"),
  "기타 장애인 시설": ("disabled_facilities", "handicapetc"),
  "휠체어 대여": ("wheelchair_user", "wheelchair"),
  "주출입구 경사로": ("wheelchair_user", "exit"),
  "이동경로 경사로": ("wheelchair_user", "publictransport"),
  "엘레베이터": ("wheelchair_user", "elevator"),
  "기타 휠체어 사용자 관련 시설": ("wheelchair_user", "wheelchairetc"),
  "유모차 대여": ("infant", "stroller"),
  "수유실": ("infant", "lactationroom"),
  "유아용 의자": ("infant", "babysparechair"),
  "기타 유아 시설": ("infant", "infantsfamilyetc"),
  "점자블록": ("visually_impaired", "braileblock"),
  "안내견 동반 가능": ("visually_impaired", "helpdog"),
  "음성안내 가이드": ("visually_impaired", "audioguide"),
  "점자 안내판": ("visually_impaired", "brailepromotion"),
  "촉지도식 안내판": ("visually_impaired", "blindhandicapetc"),
  "기타 시각장애인 시설": ("visually_impaired", "blindhandicapetc"),
  "수어 안내": ("hearing_impaired", "signguide"),
  "비디오 가이드": ("hearing_impaired", "videoguide"),
  "기타 청각장애인 시설": ("hearing_impaired", "hearinghandicapetc")
};

