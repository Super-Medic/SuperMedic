import 'package:flutter/material.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/pages/blood_sugar_recordPage.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
//스타일 파일
import 'package:super_medic/themes/common_color.dart';

class AverageBloodSugar extends StatefulWidget {
  const AverageBloodSugar({super.key, required this.averageValue});
  // ignore: prefer_typing_uninitialized_variables
  final averageValue;

  @override
  createState() {
    return AverageBloodSugarState();
  }
}

// ignore: must_be_immutable
class AverageBloodSugarState extends State<AverageBloodSugar> {
  final _average = ['최근 혈당', '공복 평균 혈당', '식후 평균 혈당'];
  String selectedAverage = '';
  List<String> _averagecountBefore = ['최근 5회 이하', '최근 5회', '최근 10회', '최근 15회'];
  List<String> _averagecountAfter = ['최근 5회 이하', '최근 5회', '최근 10회', '최근 15회'];
  String selectedAverageCountBefore = '';
  String selectedAverageCountAfter = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      selectedAverage = _average[0];
      selectedAverageCountBefore = _averagecountBefore[0];
      selectedAverageCountAfter = _averagecountAfter[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    String? aver;
    String? ttime;
    final averageValue = widget.averageValue;
    List<BloodSugarModel> averageValueBefore = [];
    List<BloodSugarModel> averageValueAfter = [];
    for (int i = 0; i < averageValue.length; i++) {
      if (averageValue[i].checkbutton == '공복') {
        averageValueBefore.add(averageValue[i]);
      } else {
        averageValueAfter.add(averageValue[i]);
      }
    }
    if (averageValueBefore.length / 5 < 1) {
      _averagecountBefore = ['최근 5회 이하'];
    } else if (averageValueBefore.length / 5 >= 1 &&
        averageValueBefore.length / 5 < 2) {
      _averagecountBefore = ['최근 5회 이하', '최근 5회'];
    } else if (averageValueBefore.length / 5 >= 2 &&
        averageValueBefore.length / 5 < 3) {
      _averagecountBefore = ['최근 5회 이하', '최근 5회', '최근 10회'];
    } else {
      _averagecountBefore = ['최근 5회 이하', '최근 5회', '최근 10회', '최근 15회'];
    }

    if (averageValueAfter.length / 5 < 1) {
      _averagecountAfter = ['최근 5회 이하'];
    } else if (averageValueAfter.length / 5 >= 1 &&
        averageValueAfter.length / 5 < 2) {
      _averagecountAfter = ['최근 5회 이하', '최근 5회'];
    } else if (averageValueAfter.length / 5 >= 2 &&
        averageValueAfter.length / 5 < 3) {
      _averagecountAfter = ['최근 5회 이하', '최근 5회', '최근 10회'];
    } else {
      _averagecountAfter = ['최근 5회 이하', '최근 5회', '최근 10회', '최근 15회'];
    }

    if (averageValue.isNotEmpty) {
      List<String> dataBefore = [];
      List<String> dataAfter = [];
      if (averageValueBefore.isNotEmpty) {
        dataBefore = _getData(averageValueBefore);
      }
      if (averageValueAfter.isNotEmpty) {
        dataAfter = _getData(averageValueAfter);
      }
      if (selectedAverage == "최근 혈당") {
        aver = averageValue[averageValue.length - 1].bloodsugar;
        ttime = averageValue[averageValue.length - 1].checkbutton;
      } else if (selectedAverageCountBefore == "최근 5회 이하" &&
          selectedAverage == "공복 평균 혈당") {
        if (dataBefore.isNotEmpty) {
          aver = dataBefore[0];
        } else {
          aver = null;
        }
      } else if (selectedAverageCountBefore == "최근 5회" &&
          selectedAverage == "공복 평균 혈당") {
        aver = dataBefore[0];
      } else if (selectedAverageCountBefore == "최근 10회" &&
          selectedAverage == "공복 평균 혈당") {
        aver = dataBefore[1];
      } else if (selectedAverageCountBefore == "최근 15회" &&
          selectedAverage == "공복 평균 혈당") {
        aver = dataBefore[2];
      } else if (selectedAverageCountAfter == "최근 5회 이하" &&
          selectedAverage == "식후 평균 혈당") {
        if (dataAfter.isNotEmpty) {
          aver = dataAfter[0];
        } else {
          aver = null;
        }
      } else if (selectedAverageCountAfter == "최근 5회" &&
          selectedAverage == "식후 평균 혈당") {
        aver = dataAfter[0];
      } else if (selectedAverageCountAfter == "최근 10회" &&
          selectedAverage == "식후 평균 혈당") {
        aver = dataAfter[1];
      } else if (selectedAverageCountAfter == "최근 15회" &&
          selectedAverage == "식후 평균 혈당") {
        aver = dataAfter[2];
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
                                    child: Text(e, style:TextStyle(fontFamily: "NotoSansKRr")),
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
                    if (selectedAverage == '공복 평균 혈당')
                      DropdownButton(
                        value: selectedAverageCountBefore,
                        underline: const SizedBox.shrink(),
                        items: _averagecountBefore
                            .map((e) => DropdownMenuItem(
                                  value: e, // 선택 시 onChanged 를 통해 반환할 value
                                  child: NanumText(text: e),
                                ))
                            .toList(),
                        onChanged: (value) {
                          // items 의 DropdownMenuItem 의 value 반환
                          setState(() {
                            selectedAverageCountBefore = value!;
                          });
                        },
                      ),
                    if (selectedAverage == '식후 평균 혈당')
                      DropdownButton(
                        value: selectedAverageCountAfter,
                        underline: const SizedBox.shrink(),
                        items: _averagecountAfter
                            .map((e) => DropdownMenuItem(
                                  value: e, // 선택 시 onChanged 를 통해 반환할 value
                                  child: NanumText(text: e),
                                ))
                            .toList(),
                        onChanged: (value) {
                          // items 의 DropdownMenuItem 의 value 반환
                          setState(() {
                            selectedAverageCountAfter = value!;
                          });
                        },
                      ),
                  ]),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                averageValue.length != 0
                    ? aver == null
                        ? const SizedBox(
                            child: NanumTitleText(text: '데이터가 존재하지 않아요.'))
                        : SizedBox(
                            child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ttime != null
                                  ? Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.baseline,
                                      textBaseline: TextBaseline.alphabetic,
                                      children: [
                                          NanumBodyText(text: ttime),
                                          NanumTitleText(
                                            text: ' $aver',
                                            fontSize: 20,
                                          ),
                                          const NanumBodyText(text: 'mg/dL')
                                        ])
                                  : selectedAverage == '공복 평균 혈당'
                                      ? Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                              const NanumBodyText(
                                                  text: '공복 혈당'),
                                              NanumTitleText(
                                                text: ' $aver',
                                                fontSize: 20,
                                              ),
                                              const NanumBodyText(text: 'mg/dL')
                                            ])
                                      : Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.baseline,
                                          textBaseline: TextBaseline.alphabetic,
                                          children: [
                                              const NanumBodyText(
                                                  text: '식후 혈당'),
                                              NanumTitleText(
                                                text: ' $aver',
                                                fontSize: 20,
                                              ),
                                              const NanumBodyText(text: 'mg/dL')
                                            ]),
                              const SizedBox(height: 10),
                              // const NanumText(
                              //   text: '혈당 수치가 높아지고 있어요 주의해주세요.',
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
                                        const BloodSugarRecordPage()))
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

List<String> _getData(averageValue) {
  int aver = 0;
  List<String> listAver = [];

  if (averageValue.length / 5 < 1) {
    aver = 0;
    for (int i = averageValue.length - 1; i >= 0; i--) {
      aver += int.parse(averageValue[i].bloodsugar);
    }
    listAver.add((aver / averageValue.length).floor().toString());
  }
  if (averageValue.length / 5 >= 1) {
    aver = 0;
    for (int i = averageValue.length - 1; i >= averageValue.length - 5; i--) {
      aver += int.parse(averageValue[i].bloodsugar);
    }
    listAver.add((aver / 5).floor().toString());
  }
  if (averageValue.length / 5 >= 2) {
    aver = 0;
    for (int i = averageValue.length - 1; i >= averageValue.length - 10; i--) {
      aver += int.parse(averageValue[i].bloodsugar);
    }
    listAver.add((aver / 10).floor().toString());
  }
  if (averageValue.length / 5 >= 3) {
    aver = 0;
    for (int i = averageValue.length - 1; i >= averageValue.length - 15; i--) {
      aver += int.parse(averageValue[i].bloodsugar);
    }
    listAver.add((aver / 15).floor().toString());
  }

  return listAver;
}
