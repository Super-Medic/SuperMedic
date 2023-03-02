import 'package:flutter/material.dart';
import 'package:super_medic/function/service.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/pages/selectAuth.dart';

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
    Services.getInfo().then((value) {
      setState(() {
        user = value;
        if (user != null) {
          for (int i = 0; i < user["entry"].length; i++) {
            if (user["entry"][i]["meta"]["tag"][0]["display"].contains("연동")) {
              loading = true;
            }
          }
        } else {
          loading = false;
        }
      });
    });
  }

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
                    text: '연동 건강데이터',
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
                                  builder: (_) => const AuthPage(healthDataType: "linked_health",)));
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                          weight: 900,
                        ),
                        label: const NanumBodyText(
                          text: '나의 헬스케어기기와 연동하세요',
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
              icon: Row(
                children: const [
                  NanumTitleText(text: '연동 건강데이터'),
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
