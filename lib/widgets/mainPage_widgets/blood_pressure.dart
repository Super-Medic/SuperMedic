import 'package:flutter/material.dart';
import 'package:super_medic/pages/blood_pressure_detailPage.dart';
import 'package:super_medic/pages/blood_pressure_recordPage.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_pressure_graph.dart';

class BloodPressure extends StatelessWidget {
  const BloodPressure({
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
                  padding: const EdgeInsets.only(top: 5),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: AppTheme.widgetpadding,
                        padding: const EdgeInsets.only(left: 5, top: 8),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BloodPressuredetailPage()),
                            );
                          },
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Image.asset(
                                'assets/images/BloodPressure.png',
                                width: 30,
                                height: 30,
                              ),
                              const SizedBox(width: 7),
                              const NanumTitleText(text: '혈압', fontSize: 20),
                              const Icon(
                                Icons.chevron_right,
                                weight: 900,
                                color: Colors.black,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(right: 20),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BloodPressureRecordPage()),
                            );
                          },
                          style: TextButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(30, 76, 175, 79),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(13)),
                            padding: const EdgeInsets.symmetric(
                                vertical: 7, horizontal: 7),
                          ),
                          child: const Row(
                            //spaceEvenly: 요소들을 균등하게 배치하는 속성
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.green,
                                size: 20,
                              ),
                              NanumTitleText(
                                  text: '오늘기록  ',
                                  fontSize: 12,
                                  color: Colors.green),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: AppTheme.widgetpadding,
                  child: BloodPressureGraph(),
                )
              ],
            )),
      ],
    );
  }
}
