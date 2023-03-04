import 'package:flutter/material.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/pages/authTimer.dart';
import 'package:super_medic/widgets/forAuth_widget/itemClass.dart';
import 'package:super_medic/widgets/forAuth_widget/customCheckBox.dart';
import 'package:super_medic/widgets/forAuth_widget/customCheckBoxTitle.dart';
import 'package:super_medic/widgets/server_widgets/requestHealthData.dart';

class TOSPage extends StatefulWidget {
  final String loginOrgCd;
  final String healthDataType;
  const TOSPage(
      {Key? key, required this.loginOrgCd, required this.healthDataType})
      : super(key: key);

  @override
  State<TOSPage> createState() => _TOSPage();
}

class _TOSPage extends State<TOSPage> {
  List<Item> items = List.empty(growable: true);
  final Item agree =
      Item(data: "전체동의", page: 'assets/images/tos.png', isChecked: false);

  @override
  void initState() {
    super.initState();
    items.add(Item(
        data: "(필수) 서비스 이용약관",
        page:
            'https://ringed-rutabaga-f09.notion.site/55ed2ee6c3914158a2f0b89434d1add9',
        isChecked: false));
    items.add(Item(
        data: "(필수) 개인정보(민감정보) 수집 및 이용 동의",
        page:
            'https://ringed-rutabaga-f09.notion.site/4f6734367bf14be98688c6acccfdd6df',
        isChecked: false));
    // items.add(Item(
    //     data: "(필수) [건강보험공단] 개인정보 이용 동의",
    //     page: 'assets/images/pass.png',
    //     isChecked: false));
    // items.add(Item(
    //     data: "(필수) [건강보험공단] 서비스 이용약관",
    //     page: 'assets/images/kb.png',
    //     isChecked: false));
    // items.add(Item(
    //     data: "(필수) 고유식별번호 처리 동의(본인확인)",
    //     page: 'assets/images/tos.png',
    //     isChecked: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.background,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: CommonColor.background,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: const Color.fromRGBO(0, 0, 0, 1.0),
              icon: const Icon(Icons.arrow_back_ios_new),
              iconSize: 30,
            ),
          )),
      // ignore: prefer_const_constructors
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 25.0,
            ),
            const NanumTitleText(
              text: '약관 내용에 동의해주세요',
              fontSize: 25.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 60.0,
            ),
            CustomCheckBoxTitle(
              item: agree,
              func: itemChange,
            ),
            const SizedBox(
              height: 10.0,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                // shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CustomCheckBox(
                    item: items[index],
                    func: checkAll,
                  );
                },
              ),
            ),
            SafeArea(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () async {
                  //init 호출
                  String stepData = await requestHealthData(
                      key[widget.loginOrgCd]!, widget.healthDataType, 'init');
                  print(stepData);
                  agree.isChecked == false
                      ? null
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => AuthTimer(
                                    loginOrgCd: widget.loginOrgCd,
                                    healthDataType: widget.healthDataType,
                                    step: 'sign',
                                    step_data: stepData,
                                  )));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      agree.isChecked == false ? Colors.grey : Colors.green,
                  minimumSize: Size(MediaQuery.of(context).size.width - 30, 50),
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const NanumTitleText(
                  text: '다음',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
            const Padding(
              padding: EdgeInsets.all(10),
            )
          ],
        ),
      ),
    );
  }

  void itemChange(bool val) {
    setState(() {
      for (var item in items) {
        item.isChecked = val;
      }
    });
  }

  void checkAll(bool val) {
    setState(() {
      var cnt = 0;
      for (var item in items) {
        cnt = item.isChecked ? cnt + 1 : cnt;
      }
      agree.isChecked = (cnt == items.length) ? true : false;
    });
  }

  final key = {
    '카카오톡': 'kakao',
    '네이버': 'naver',
    '통신사패스': 'pass',
    'KB 모바일': 'kb',
    '토스': 'toss',
    '삼성패스': 'kica'
  };
}
