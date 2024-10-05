import 'package:durume_flutter/styles.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

class MyScreen extends StatefulWidget {
  const MyScreen({super.key});

  @override
  State<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends State<MyScreen> {
  bool isModalOpen = false;

  void setIsModalOpen() {
    setState(() {
      if (isModalOpen) {
        isModalOpen = false;
      } else {
        isModalOpen = true;
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Stack(
            alignment: AlignmentDirectional.topCenter,
            children: [
              Positioned(
                child: GestureDetector(
                  onTap: () {
                    // 안내팝업
                    // "해당 무장애 정보는 인공지능 LLM 모델인 Google Gemini 1.5를 통해 제공됩니다. 정보 정확성에 일부 한계가 있을 수 있으니, 참고용으로만 사용해 주시기 바랍니다."
                    setIsModalOpen();
                  },
                  child: Icon(Symbols.info, size: 18,),
                ),
              ),
              isModalOpen ? Positioned(
                width: 220,
                top: 10,
                child: Container(
                  decoration: BoxDecoration(
                    color: softGrey
                  ),
                  child: Text("해당 무장애 정보는 인공지능 LLM 모델인 Google Gemini 1.5를 통해 제공됩니다. 정보 정확성에 일부 한계가 있을 수 있으니, 참고용으로만 사용해 주시기 바랍니다."),
                )
              ) : Container()
            ],
          ),

          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),
          Text("안녕", style: TextStyle(fontSize: 40),),

        ],
      ),
    );
  }
}


// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

final List<Map<String, String>> productHelpu = [
  {
    'img': 'assets/images/biki.png',
    'title': '[헬퓨] D데이팩',
    'delivery': '무료배송',
    'price': '62,400',
  },
];

final List<Map<String, String>> productHelpuTwo = [
  {
    'img': 'assets/images/biki.png',
    'title': '[헬퓨] D데이팩2',
    'delivery': '무료배송',
    'price': '52,400',
  },
  {
    'img': 'assets/images/biki.png',
    'title': '[헬퓨] D데이팩3',
    'delivery': '무료배송',
    'price': '12,400',
  },
];

class HelpuScreen extends StatefulWidget {
  const HelpuScreen({super.key});

  @override
  State<HelpuScreen> createState() => _HelpuScreenState();
}

class _HelpuScreenState extends State<HelpuScreen> {
  List<bool> isCheckedListOne = List.filled(productHelpu.length, false);
  List<bool> isCheckedListTwo = List.filled(productHelpuTwo.length, false);

  bool isModalOne = false;
  bool isModalTwo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 20,
          ),
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                '맞춤 멀티팩',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isModalOne = !isModalOne;
                                  });
                                },
                                child: const Icon(
                                  Icons.error_outline_sharp,
                                  color: Color(0xFF6a6d6c),
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                              // shrinkWrap: true,
                              itemCount: productHelpu.length,
                              itemBuilder: (context, index) {
                                final productHelpuItem = productHelpu[index];
                                return Stack(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            border: Border.all(
                                              width: 1,
                                              color: const Color(0xFFd9d9d9),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CheckboxListTile(
                                            value: isCheckedListOne[
                                            index], // 체크박스의 상태를 관리하는 변수
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isCheckedListOne[index] =
                                                value!;
                                              });
                                            },
                                            title: SizedBox(
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration:
                                                    const BoxDecoration(
                                                      color: Color(0xFFd9d9d9),
                                                    ),
                                                    child: Image.asset(
                                                      productHelpuItem['img']!,
                                                      fit: BoxFit.cover,
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(productHelpuItem[
                                                        'title']!),
                                                        Text(productHelpuItem[
                                                        'delivery']!)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            secondary: Text(
                                                '${productHelpuItem['price']!} 원'),
                                            controlAffinity:
                                            ListTileControlAffinity.leading,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isModalOne == true)
                      Positioned(
                        top: 55,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 3, 0, 5),
                          child: Container(
                            width: 340,
                            height: 75,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '맞춤 멀티팩',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text('구매할 멀티팩을 선택해보세요.'),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isModalOne = !isModalOne;
                                      });
                                    },
                                    child: const Icon(Icons.close),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    Positioned(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                '단일 멀티팩',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isModalTwo = !isModalTwo;
                                  });
                                },
                                child: const Icon(
                                  Icons.error_outline_sharp,
                                  color: Color(0xFF6a6d6c),
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                            child: ListView.builder(
                              // shrinkWrap: true,
                              itemCount: productHelpuTwo.length,
                              itemBuilder: (context, index) {
                                final productHelpuItemTwo =
                                productHelpuTwo[index];
                                return Stack(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(bottom: 10),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(8),
                                            border: Border.all(
                                              width: 1,
                                              color: const Color(0xFFd9d9d9),
                                            )),
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: CheckboxListTile(
                                            value: isCheckedListTwo[
                                            index], // 체크박스의 상태를 관리하는 변수
                                            onChanged: (bool? value) {
                                              setState(() {
                                                isCheckedListTwo[index] =
                                                value!;
                                              });
                                            },
                                            title: SizedBox(
                                              width: double.infinity,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration:
                                                    const BoxDecoration(
                                                      color: Color(0xFFd9d9d9),
                                                    ),
                                                    child: Image.asset(
                                                      productHelpuItemTwo[
                                                      'img']!,
                                                      fit: BoxFit.cover,
                                                      width: 50,
                                                      height: 50,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Text(
                                                            productHelpuItemTwo[
                                                            'title']!),
                                                        Text(
                                                            productHelpuItemTwo[
                                                            'delivery']!)
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),

                                            secondary: Text(
                                                '${productHelpuItemTwo['price']!} 원'),
                                            controlAffinity:
                                            ListTileControlAffinity.leading,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isModalTwo == true)
                      Positioned(
                        top: 55,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 3, 0, 5),
                          child: Container(
                            width: 340,
                            height: 120,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.black,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '맞춤 영양제',
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w800),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text('멀티팩과 함께 섭취할 제품을 선택해보세요.'),
                                      Text('혹은 단품만 선택하여 구매가 가능합니다.'),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isModalTwo = !isModalTwo;
                                      });
                                    },
                                    child: const Icon(Icons.close),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}