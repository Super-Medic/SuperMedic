import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일

class AddLinkPage extends StatefulWidget {
  const AddLinkPage({Key? key}) : super(key: key);
  @override
  State<AddLinkPage> createState() => _AddLinkPage();
}

class _AddLinkPage extends State<AddLinkPage> {
  @override
  Widget build(BuildContext context) {
    final imageSize = MediaQuery.of(context).size.width / 4;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        top: false,
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: screenHeight * 0.025,
              ),
              const Center(
                child: NanumTitleText(
                  text: '연동 요청하기',
                  fontSize: 25.0,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 25, left: 20),
                      child: const NanumTitleText(
                        text: '요청 방법을 선택해주세요',
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 30),
                    child: Column(
                      children: [
                        FloatingActionButton.large(
                          backgroundColor: Colors.green,
                          onPressed: () {
                            // 스크롤 위치 맨위로 이동
                          },
                          child: const Icon(
                            Icons.expand_less,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        const NanumTitleText(text: '메시지')
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 30),
                    child: Column(
                      children: [
                        FloatingActionButton.large(
                          backgroundColor: Colors.green,
                          onPressed: () {
                            // 스크롤 위치 맨위로 이동
                          },
                          child: const Icon(
                            Icons.expand_less,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        const NanumTitleText(text: '카카오톡')
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 30),
                    child: Column(
                      children: [
                        FloatingActionButton.large(
                          backgroundColor: Colors.green,
                          onPressed: () {
                            // 스크롤 위치 맨위로 이동
                          },
                          child: const Icon(
                            Icons.expand_less,
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        const NanumTitleText(text: '링크복사')
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
