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

  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  Widget ExData(ScreeningModel screenings) {
    if (screenings.screeningList!.isEmpty == false) {
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
                          NanumTitleText(text: '건강검진'),
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
                              text: screenings
                                  .screeningList![
                                      screenings.screeningList!.length - 1]
                                  .result as String,
                              color: Colors.red),
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
                          if (double.parse(screenings
                                  .screeningList![
                                      screenings.screeningList!.length - 1]
                                  .BMI as String) >=
                              30)
                            State_danger(),
                          if (double.parse(screenings
                                      .screeningList![
                                          screenings.screeningList!.length - 1]
                                      .BMI as String) >=
                                  25 &&
                              double.parse(screenings
                                      .screeningList![
                                          screenings.screeningList!.length - 1]
                                      .BMI as String) <=
                                  29.8)
                            State_caution(),
                          if (double.parse(screenings
                                      .screeningList![
                                          screenings.screeningList!.length - 1]
                                      .BMI as String) >=
                                  18.5 &&
                              double.parse(screenings
                                      .screeningList![
                                          screenings.screeningList!.length - 1]
                                      .BMI as String) <=
                                  24.9)
                            State_normal(),
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          const NanumBodyText(text: '당뇨'),
                          const NanumBodyText(text: '   '),
                          if (double.parse(screenings
                                  .screeningList![
                                      screenings.screeningList!.length - 1]
                                  .FBG as String) >=
                              126)
                            State_danger(),
                          if (double.parse(screenings
                                      .screeningList![
                                          screenings.screeningList!.length - 1]
                                      .FBG as String) >=
                                  100 &&
                              double.parse(screenings
                                      .screeningList![
                                          screenings.screeningList!.length - 1]
                                      .FBG as String) <=
                                  125)
                            State_caution(),
                          if (double.parse(screenings
                                  .screeningList![
                                      screenings.screeningList!.length - 1]
                                  .FBG as String) <
                              100)
                            State_normal(),
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        children: [
                          const NanumBodyText(text: '신장'),
                          const NanumBodyText(text: '   '),
                          if (double.parse(screenings
                                  .screeningList![
                                      screenings.screeningList!.length - 1]
                                  .GFR as String) <
                              60)
                            State_caution(),
                          if (double.parse(screenings
                                  .screeningList![
                                      screenings.screeningList!.length - 1]
                                  .GFR as String) >=
                              60)
                            State_normal(),
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
                          const NanumBodyText(text: '혈압'),
                          const NanumBodyText(text: '   '),
                          if (double.parse(screenings
                                      .screeningList?[0].bloodPressure
                                      ?.split("/")[0] as String) >=
                                  140 ||
                              double.parse(screenings
                                      .screeningList?[0].bloodPressure
                                      ?.split("/")[1] as String) >=
                                  90)
                            State_danger(),
                          if ((double.parse(screenings
                                          .screeningList![screenings.screeningList!.length -
                                              1]
                                          .bloodPressure
                                          ?.split("/")[0] as String) >=
                                      120 &&
                                  double.parse(screenings.screeningList?[0].bloodPressure?.split("/")[0] as String) <
                                      140) ||
                              (double.parse(screenings.screeningList![screenings.screeningList!.length - 1].bloodPressure?.split("/")[1] as String) >= 80 &&
                                  double.parse(screenings
                                          .screeningList![screenings.screeningList!.length - 1]
                                          .bloodPressure
                                          ?.split("/")[1] as String) <
                                      90))
                            State_caution(),
                          if (double.parse(screenings
                                      .screeningList?[0].bloodPressure
                                      ?.split("/")[0] as String) <
                                  120 &&
                              double.parse(screenings
                                      .screeningList?[0].bloodPressure
                                      ?.split("/")[1] as String) <
                                  80)
                            State_normal(),
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Row(
                        children: [
                          const NanumBodyText(text: '빈혈'),
                          const NanumBodyText(text: '   '),
                          if (double.parse(screenings
                                  .screeningList![
                                      screenings.screeningList!.length - 1]
                                  .hemoglobin as String) <
                              12)
                            State_danger(),
                          if (double.parse(screenings
                                      .screeningList![
                                          screenings.screeningList!.length - 1]
                                      .hemoglobin as String) >=
                                  12 &&
                              double.parse(screenings
                                      .screeningList![
                                          screenings.screeningList!.length - 1]
                                      .hemoglobin as String) <=
                                  12.9)
                            State_caution(),
                          if (double.parse(screenings
                                  .screeningList![
                                      screenings.screeningList!.length - 1]
                                  .hemoglobin as String) >=
                              13)
                            State_normal(),
                        ],
                      )),
                  Container(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: Row(
                        children: [
                          const NanumBodyText(text: '간'),
                          const NanumBodyText(text: '     '),
                          if (double.parse(screenings
                                  .screeningList![
                                      screenings.screeningList!.length - 1]
                                  .SGOT as String) >=
                              51)
                            State_danger(),
                          if (double.parse(screenings
                                      .screeningList![
                                          screenings.screeningList!.length - 1]
                                      .SGOT as String) >=
                                  41 &&
                              double.parse(screenings
                                      .screeningList![
                                          screenings.screeningList!.length - 1]
                                      .SGOT as String) <=
                                  50)
                            State_caution(),
                          if (double.parse(screenings
                                  .screeningList![
                                      screenings.screeningList!.length - 1]
                                  .SGOT as String) <=
                              40)
                            State_normal(),
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
                    text: '건강검진',
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
