import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';

class LinkedHealthData extends StatefulWidget {
  const LinkedHealthData({Key? key}) : super(key: key);

  @override
  State<LinkedHealthData> createState() => _LinkedHealthData();
}

class _LinkedHealthData extends State<LinkedHealthData> {
  dynamic user;
  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  Widget NotData() {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.only(left: 15, top: 8),
            width: double.infinity,
            decoration: BoxDecoration(
              color: CommonColor.widgetbackgroud,
              borderRadius: BorderRadius.circular(25),
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
                  child: const NanumTitleText(text: '연동 건강데이터', fontSize: 20),
                ),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                        onPressed: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => const AuthPage(
                          //               healthDataType: "linked_health",
                          //             )));
                        },
                        icon: const Icon(
                          Icons.hourglass_top_rounded,
                          size: 23,
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

  Widget ExData() {
    return Container(
      padding: AppTheme.widgetpadding,
      width: double.infinity,
      decoration: BoxDecoration(
        color: CommonColor.widgetbackgroud,
        borderRadius: BorderRadius.circular(25),
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
                  NanumTitleText(text: '연동 건강데이터', fontSize: 20),
                  Icon(
                    Icons.chevron_right,
                    weight: 900,
                    color: Colors.black,
                  ),
                ],
              ),
              style: TextButton.styleFrom(
                  iconColor: Colors.green, foregroundColor: Colors.black)),
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
