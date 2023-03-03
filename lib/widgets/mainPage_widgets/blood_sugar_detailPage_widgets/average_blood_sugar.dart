import 'package:flutter/material.dart';
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
  final _average = ['최근 혈당', '평균 혈당'];
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
    String? aver;
    String? ttime;
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
      List<String> data = _getData(averageValue);
      if (selectedAverage == "최근 혈당") {
        aver = data[0];
        ttime = averageValue[averageValue.length - 1].checkbutton;
      } else if (selectedAverageCount == "최근 5회 이하" &&
          selectedAverage == "평균 혈당") {
        aver = data[1];
      } else if (selectedAverageCount == "최근 5회" &&
          selectedAverage == "평균 혈당") {
        aver = data[1];
      } else if (selectedAverageCount == "최근 10회" &&
          selectedAverage == "평균 혈당") {
        aver = data[2];
      } else if (selectedAverageCount == "최근 15회" &&
          selectedAverage == "평균 혈당") {
        aver = data[3];
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
                          items: _average
                              .map((e) => DropdownMenuItem(
                                    value: e, // 선택 시 onChanged 를 통해 반환할 value
                                    child: Text(e),
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
                    if (selectedAverage == '평균 혈당')
                      DropdownButton(
                        value: selectedAverageCount,
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
                          ttime != null
                              ? NanumTitleText(text: '$ttime ${aver}mg/dL')
                              : NanumTitleText(text: '${aver}mg/dL'),
                          const SizedBox(height: 10),
                          const NanumText(
                            text: '혈당 수치가 높아지고 있어요 주의해주세요.',
                            fontSize: 9,
                          ),
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
  //최근 혈당
  if (averageValue.isNotEmpty) {
    listAver.add(averageValue[averageValue.length - 1].bloodsugar);
  }
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
