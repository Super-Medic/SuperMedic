import 'package:flutter/material.dart';
import 'package:super_medic/pages/blood_pressure_recordPage.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
//스타일 파일
import 'package:super_medic/themes/common_color.dart';

class AverageBloodPressure extends StatefulWidget {
  const AverageBloodPressure({super.key, required this.averageValue});
  // ignore: prefer_typing_uninitialized_variables
  final averageValue;

  @override
  createState() {
    return AverageBloodPressureState();
  }
}

// ignore: must_be_immutable
class AverageBloodPressureState extends State<AverageBloodPressure> {
  final _average = ['최근 혈압', '평균 혈압'];
  String selectedAverage = '';
  List<String> _averagecount = ['최근 5회 이하', '최근 5회', '최근 10회', '최근 15회'];
  String selectedAverageCount = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedAverage = _average[0];
      selectedAverageCount = _averagecount[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    String? maxBlood = '0';
    String? minBlood = '0';
    final averageValue = widget.averageValue;

    if (averageValue.length / 5 < 1) {
      _averagecount = ['최근 5회 이하'];
    } else if (averageValue.length / 5 >= 1 && averageValue.length / 5 < 2) {
      _averagecount = ['최근 5회 이하', '최근 5회'];
    } else if (averageValue.length / 5 >= 2 && averageValue.length / 5 < 3) {
      _averagecount = ['최근 5회 이하', '최근 5회', '최근 10회'];
    } else {
      _averagecount = ['최근 5회 이하', '최근 5회', '최근 10회', '최근 15회'];
    }
    if (averageValue.isNotEmpty) {
      List<BloodPressureTotal> data = _getData(averageValue);
      if (selectedAverage == "최근 혈압") {
        maxBlood = data[0].maxbloodPressure;
        minBlood = data[0].minbloodPressure;
      } else if (selectedAverageCount == "최근 5회 이하" &&
          selectedAverage == "평균 혈압") {
        maxBlood = data[1].maxbloodPressure;
        minBlood = data[1].minbloodPressure;
      } else if (selectedAverageCount == "최근 5회" &&
          selectedAverage == "평균 혈압") {
        maxBlood = data[1].maxbloodPressure;
        minBlood = data[1].minbloodPressure;
      } else if (selectedAverageCount == "최근 10회" &&
          selectedAverage == "평균 혈압") {
        maxBlood = data[2].maxbloodPressure;
        minBlood = data[2].minbloodPressure;
      } else if (selectedAverageCount == "최근 15회" &&
          selectedAverage == "평균 혈압") {
        maxBlood = data[3].maxbloodPressure;
        minBlood = data[3].minbloodPressure;
      }
    }

    return Container(
        padding: const EdgeInsets.all(25), // AppTheme.detailpadding,
        width: double.infinity,
        decoration: const BoxDecoration(color: CommonColor.widgetbackgroud),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(children: [
                        DropdownButton(
                          value: selectedAverage,
                          underline: const SizedBox.shrink(),
                          items: _average
                              .map((e) => DropdownMenuItem(
                                    value: e, // 선택 시 onChanged 를 통해 반환할 value
                                    child: Text(e,
                                        style: const TextStyle(
                                            fontFamily: "NotoSansKRr")),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            // items 의 DropdownMenuItem 의 value 반환
                            setState(() {
                              selectedAverage = value!;
                            });
                          },
                        ),
                      ]),
                    ),
                    if (selectedAverage == '평균 혈압')
                      DropdownButton(
                        value: selectedAverageCount,
                        underline: const SizedBox.shrink(),
                        items: _averagecount
                            .map((e) => DropdownMenuItem(
                                  value: e, // 선택 시 onChanged 를 통해 반환할 value
                                  child: NanumText(text: e),
                                ))
                            .toList(),
                        onChanged: (value) {
                          // items 의 DropdownMenuItem 의 value 반환
                          setState(() {
                            selectedAverageCount = value!;
                          });
                        },
                      ),
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                averageValue.length != 0
                    ? SizedBox(
                        child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            const NanumBodyText(text: '최고'),
                            NanumTitleText(
                              text: ' $maxBlood',
                              fontSize: 20,
                            ),
                            const NanumBodyText(text: 'mmHg')
                          ]),
                          const SizedBox(height: 10),
                          Row(children: [
                            const NanumBodyText(text: '최저'),
                            NanumTitleText(
                              text: ' $minBlood',
                              fontSize: 20,
                            ),
                            const NanumBodyText(text: 'mmHg')
                          ]),
                          const SizedBox(height: 10),
                          // const NanumText(
                          //   text: '최근 혈압이 높아지고 있어요 고혈압이 의심돼요.',
                          //   fontSize: 9,
                          // ),
                        ],
                      ))
                    : const SizedBox(
                        child: NanumTitleText(text: '데이터가 존재하지 않아요.'),
                      ),
                Center(
                  child: TextButton(
                      onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const BloodPressureRecordPage()))
                          },
                      style: TextButton.styleFrom(
                        backgroundColor: CommonColor.buttoncolor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                      ),
                      child: const NanumTitleText(
                        text: '기록하기',
                        fontSize: 15,
                        color: Colors.white,
                      )),
                )
              ],
            )
          ],
        ));
  }
}

List<BloodPressureTotal> _getData(averageValue) {
  int max = 0;
  int min = 0;
  List<BloodPressureTotal> listAver = [];
  //최근 혈당

  if (averageValue.isNotEmpty) {
    listAver.add(BloodPressureTotal(
        averageValue[averageValue.length - 1].maxbloodPressure,
        averageValue[averageValue.length - 1].minbloodPressure));
  }
  if (averageValue.length / 5 < 1) {
    max = 0;
    min = 0;
    for (int i = averageValue.length - 1; i >= 0; i--) {
      max += int.parse(averageValue[i].maxbloodPressure);
      min += int.parse(averageValue[i].minbloodPressure);
    }
    listAver.add(BloodPressureTotal(
        (max / averageValue.length).floor().toString(),
        (min / averageValue.length).floor().toString()));
  }
  if (averageValue.length / 5 >= 1) {
    max = 0;
    min = 0;
    for (int i = averageValue.length - 1; i >= averageValue.length - 5; i--) {
      max += int.parse(averageValue[i].maxbloodPressure);
      min += int.parse(averageValue[i].minbloodPressure);
    }
    listAver.add(BloodPressureTotal(
        (max / 5).floor().toString(), (min / 5).floor().toString()));
  }
  if (averageValue.length / 5 >= 2) {
    max = 0;
    min = 0;
    for (int i = averageValue.length - 1; i >= averageValue.length - 10; i--) {
      max += int.parse(averageValue[i].maxbloodPressure);
      min += int.parse(averageValue[i].minbloodPressure);
    }
    listAver.add(BloodPressureTotal(
        (max / 10).floor().toString(), (min / 10).floor().toString()));
  }
  if (averageValue.length / 5 >= 3) {
    max = 0;
    min = 0;
    for (int i = averageValue.length - 1; i >= averageValue.length - 15; i--) {
      max += int.parse(averageValue[i].maxbloodPressure);
      min += int.parse(averageValue[i].minbloodPressure);
    }
    listAver.add(BloodPressureTotal(
        (max / 15).floor().toString(), (min / 15).floor().toString()));
  }

  return listAver;
}

class BloodPressureTotal {
  final String maxbloodPressure;
  final String minbloodPressure;

  BloodPressureTotal(this.maxbloodPressure, this.minbloodPressure);
}
