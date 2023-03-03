import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/pages/selectAuth.dart';

class ImmunizationHistory extends StatefulWidget {
  const ImmunizationHistory({Key? key}) : super(key: key);

  @override
  State<ImmunizationHistory> createState() => _ImmunizationHistory();
}

class _ImmunizationHistory extends State<ImmunizationHistory> {
  dynamic user;
  bool loading = false;
  dynamic key;
  var count = 0;
  // ignore: prefer_typing_uninitialized_variables
  var screenWidth;
  // ignore: prefer_typing_uninitialized_variables
  var screenHeight;
  Size? size;
  final GlobalKey _containerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        size = getSize();
      });
    });
  }

  Size? getSize() {
    print(_containerKey.currentContext);
    if (_containerKey.currentContext != null) {
      final RenderBox renderBox =
          _containerKey.currentContext!.findRenderObject() as RenderBox;
      Size size = renderBox.size;
      return size;
    }
    return null;
  }

  Widget item(text1, text2) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Column(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: screenWidth * 0.03),
        const Icon(Icons.circle, color: Colors.green, size: 12),
        SizedBox(width: screenWidth * 0.05),
        NanumText(
            text: text1.substring(0, 4) +
                "년 " +
                text1.substring(4, 6) +
                "월 " +
                text1.substring(6, 8) +
                "일 "),
        SizedBox(width: screenWidth * 0.02),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          for (int i = 0; i < text2.split("(")[0].split(",").length; i++)
            NanumTitleText(
                text: text2.split("(")[0].split(",")[i].split(" ")[
                    text2.split("(")[0].split(",")[i].split(" ").length - 1]),
          SizedBox(
            height: screenHeight * 0.01,
          )
        ]),
      ]),
    ]);
  }

  // ignore: non_constant_identifier_names
  Widget NotData() {
    return Column(
      children: [
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: CommonColor.widgetbackgroud,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: CommonColor.boxshadowcolor.withOpacity(0.02),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 15),
                  margin: AppTheme.totalpadding,
                  child: const NanumTitleText(
                    text: '예방접종 내역',
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const AuthPage(
                                        healthDataType: "immunization",
                                      )));
                        },
                        icon: const Icon(
                          Icons.hourglass_top_rounded,
                          size: 30,
                          weight: 900,
                        ),
                        label: const NanumBodyText(
                          text: '서비스 준비 중입니다.',
                        ),
                        style: TextButton.styleFrom(
                            iconColor: Colors.green,
                            foregroundColor: Colors.black)),
                  ),
                ),
              ],
            )),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget ExData() {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: AppTheme.widgetpadding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: CommonColor.widgetbackgroud,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: CommonColor.boxshadowcolor.withOpacity(0.02),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton.icon(
              onPressed: () {
                print("성공");
              },
              label: const NanumBodyText(
                text: '',
              ),
              icon: const Row(
                children: [
                  NanumTitleText(text: '예방접종 내역'),
                  Icon(
                    Icons.chevron_right,
                    weight: 900,
                    color: Colors.black,
                  ),
                ],
              ),
              style: TextButton.styleFrom(
                  iconColor: Colors.green, foregroundColor: Colors.black)),
          Stack(children: [
            Container(
              key: _containerKey,
              child: Column(
                children: [
                  for (int i = 0; i < count; i++)
                    item(
                        user["entry"][key - i]["entry"][0]["id"],
                        user["entry"][key - i]["entry"][0]["vaccineCode"]
                            ["text"]),
                ],
              ),
            ),
            Container(
              //height: size?.height,
              margin: const EdgeInsets.only(left: 18, top: 4),
              // ignore: prefer_const_constructors
              decoration: BoxDecoration(
                  border: const Border(
                      left: BorderSide(color: Colors.green, width: 2.3))),
              child: Text("\n\n" * count),
            ),
          ])
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (loading == false) {
      return NotData();
    } else {
      return ExData();
    }
  }
}
