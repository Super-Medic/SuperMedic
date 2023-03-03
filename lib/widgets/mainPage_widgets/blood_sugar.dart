import 'package:flutter/material.dart';
import 'package:super_medic/pages/blood_sugar_detailPage.dart';
import 'package:super_medic/pages/blood_sugar_recordPage.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_sugar_graph.dart';

class BloodSugar extends StatelessWidget {
  const BloodSugar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: AppTheme.widgetpadding,
                        child: TextButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BloodSugardetailPage()),
                              );
                            },
                            label: const NanumBodyText(
                              text: '',
                            ),
                            icon: const Row(
                              children: [
                                NanumTitleText(text: '혈당'),
                                Icon(
                                  Icons.chevron_right,
                                  weight: 900,
                                  color: Colors.black,
                                ),
                              ],
                            ),
                            style: TextButton.styleFrom(
                                iconColor: Colors.green,
                                foregroundColor: Colors.black)),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BloodSugarRecordPage()),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: CommonColor.buttoncolor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            padding: const EdgeInsets.symmetric(horizontal: 7),
                          ),
                          child: const Row(
                            //spaceEvenly: 요소들을 균등하게 배치하는 속성
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                              ),
                              NanumTitleText(
                                text: '오늘기록',
                                fontSize: 12,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: AppTheme.widgetpadding,
                  child: BloodSugarGraph(),
                )
              ],
            )),
      ],
    );
  }
}
