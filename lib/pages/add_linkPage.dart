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
              const SizedBox(
                height: 25.0,
              ),
              const Center(
                child: NanumTitleText(
                  text: '연동 요청하기',
                  fontSize: 25.0,
                ),
              ),
              const SizedBox(
                height: 20.0,
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
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: const Column(
                      children: [],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: const Column(
                      children: [],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child: const Column(
                      children: [],
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
