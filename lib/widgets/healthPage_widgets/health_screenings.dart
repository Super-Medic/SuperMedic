import 'package:flutter/material.dart';

import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/pages/selectAuth.dart';
import 'package:super_medic/function/model.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';

class HealthScreenings extends StatefulWidget {
  const HealthScreenings({Key? key}) : super(key: key);

  @override
  State<HealthScreenings> createState() => _HealthScreenings();
}

class _HealthScreenings extends State<HealthScreenings> {
  late HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    if (_homeProvider.screeningValue != null) {
      return ExData(_homeProvider.screeningValue!);
    } else {
      return NotData('나의 건강검진내역을 불러오세요');
    }
  }

  // ignore: non_constant_identifier_names
  Widget State_normal() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const NanumBodyText(text: '정상', color: Colors.white),
    );
  }

  // ignore: non_constant_identifier_names
  Widget State_caution() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const NanumBodyText(text: '주의', color: Colors.white),
    );
  }

  // ignore: non_constant_identifier_names
  Widget State_danger() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const NanumBodyText(text: '위험', color: Colors.white),
    );
  }

  dynamic Get_health_Grade(String type, dynamic screenings) {
    // double score = double.parse(value as String);

    switch (type) {
      case "BMI":
        var bmi = double.parse(screenings.BMI as String);
        if (bmi >= 30) {
          return State_danger();
        } else if (bmi >= 25 && bmi <= 29.8) {
          return State_caution();
        } else if (bmi >= 18.5 && bmi <= 24.9) {
          return State_normal();
        }
        break;
      case "FBG":
        var fbg = double.parse(screenings.FBG as String);
        if (fbg >= 126) {
          return State_danger();
        } else if (fbg >= 100 && fbg <= 125) {
          return State_caution();
        } else if (fbg < 100) {
          return State_normal();
        }
        break;
      case "GFR":
        var gfr = double.parse(screenings.GFR as String);
        if (gfr < 60) {
          return State_caution();
        } else if (gfr >= 60) {
          return State_normal();
        }
        break;
      case "hemoglobin":
        var hemoglobin = double.parse(screenings.hemoglobin as String);
        if (hemoglobin < 12) {
          return State_danger();
        } else if (hemoglobin >= 12 && hemoglobin <= 12.9) {
          return State_caution();
        } else if (hemoglobin >= 13) {
          return State_normal();
        }
        break;

      case "SGOT":
        var sgot = double.parse(screenings.SGOT as String);
        if (sgot >= 51) {
          return State_danger();
        } else if (sgot >= 41 && sgot <= 50) {
          return State_caution();
        } else if (sgot <= 40) {
          return State_normal();
        }
        break;
      case "bloodPressure":
        var bloodpressureMin =
            double.parse(screenings.bloodPressure.split("/")[0] as String);
        var bloodpressureMax =
            double.parse(screenings.bloodPressure.split("/")[1] as String);

        if (bloodpressureMin >= 140 || bloodpressureMax >= 90) {
          return State_danger();
        } else if ((bloodpressureMin >= 120 && bloodpressureMin < 140) ||
            (bloodpressureMax >= 80 && bloodpressureMax < 90)) {
          return State_caution();
        } else if (bloodpressureMin < 120 && bloodpressureMax < 80) {
          return State_normal();
        }
        break;
    }
  }

  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  Widget ExData(ScreeningModel screenings) {
    if (screenings.screeningList!.isEmpty == false) {
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  TextButton.icon(
                      onPressed: () {},
                      label: const NanumBodyText(
                        text: '',
                      ),
                      icon: const Row(
                        children: [
                          NanumTitleText(text: '건강검진', fontSize: 20),
                          // Icon(
                          //   Icons.chevron_right,
                          //   weight: 900,
                          //   color: Colors.black,
                          // ),
                        ],
                      ),
                      style: TextButton.styleFrom(
                          iconColor: Colors.green,
                          foregroundColor: Colors.black)),
                  NanumBodyText(
                      text:
                          "최근 건강검진 연도: ${screenings.screeningList![screenings.screeningList!.length - 1].year as String}년"),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          const NanumBodyText(text: '종합판정'),
                          const NanumBodyText(text: '   '),
                          NanumTitleText(
                              text: screenings.screeningList![screenings.screeningList!.length - 1].result as String,
                              color: Colors.red)
                        ],
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          const NanumBodyText(text: '비만'),
                          const NanumBodyText(text: '   '),
                          Get_health_Grade(
                              "BMI",
                              screenings.screeningList![
                                  screenings.screeningList!.length - 1])
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          const NanumBodyText(text: '당뇨'),
                          const NanumBodyText(text: '   '),
                          Get_health_Grade(
                              "FBG",
                              screenings.screeningList![
                                  screenings.screeningList!.length - 1])
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          const NanumBodyText(text: '신장'),
                          const NanumBodyText(text: '   '),
                          Get_health_Grade(
                              "GFR",
                              screenings.screeningList![
                                  screenings.screeningList!.length - 1])
                        ],
                      )),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Row(
                        children: [
                          const NanumBodyText(
                            text: '혈압',
                          ),
                          const NanumBodyText(text: '   '),
                          Get_health_Grade(
                              "bloodPressure",
                              screenings.screeningList![
                                  screenings.screeningList!.length - 1])
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Row(
                        children: [
                          const NanumBodyText(text: '빈혈'),
                          const NanumBodyText(text: '   '),
                          Get_health_Grade(
                              "hemoglobin",
                              screenings.screeningList![
                                  screenings.screeningList!.length - 1])
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Row(
                        children: [
                          const NanumBodyText(text: '간'),
                          const NanumBodyText(text: '     '),
                          Get_health_Grade(
                              "SGOT",
                              screenings.screeningList![
                                  screenings.screeningList!.length - 1])
                        ],
                      )),
                ],
              ),
            ],
          ));
    } else {
      return NotData('건강검진 데이터가 존재하지 않습니다.');
    }
  }

  Widget NotData(String noScreeningDataText) {
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
                  child: const NanumTitleText(text: '건강검진', fontSize: 20),
                ),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AuthPage(
                                      healthDataType: "Screenings")));
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                          weight: 900,
                        ),
                        label: NanumBodyText(
                          text: noScreeningDataText,
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
}
