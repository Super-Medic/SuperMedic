import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'dart:convert';
import 'package:timelines/timelines.dart';
import 'package:super_medic/pages/selectAuth.dart';
import 'package:super_medic/function/model.dart';

import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';

class RecentMedicationHistory extends StatefulWidget {
  const RecentMedicationHistory({Key? key}) : super(key: key);

  @override
  State<RecentMedicationHistory> createState() => _RecentMedicationHistory();
}

class _RecentMedicationHistory extends State<RecentMedicationHistory> {
  late HomeProvider _homeProvider;
  dynamic user;
  dynamic key;
  var count = 0;
  // ignore: prefer_typing_uninitialized_variables
  var screenWidth;
  // ignore: prefer_typing_uninitialized_variables
  var screenHeight;
  late dynamic medicine;

  @override
  void initState() {
    super.initState();
  }

  Widget item(date, text2, text3) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return Column(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: screenWidth * 0.03),
        const Icon(Icons.circle, color: Colors.green, size: 12),
        SizedBox(width: screenWidth * 0.05),
        NanumText(
            text: date.substring(0, 4) +
                "년 " +
                date.substring(4, 6) +
                "월 " +
                date.substring(6, 8) +
                "일 "),
        SizedBox(width: screenWidth * 0.02),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              NanumTitleText(text: text2.split("_")[0].split("(")[0]),
              const NanumTitleText(text: " "),
              // NanumTitleText(text: '(${text3})')
            ],
          ),
          const SizedBox(
            height: 5,
          )
        ]),
      ]),
    ]);
  }

  Widget ExData(MedicineModel medicine) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    if (medicine.medicineList!.isEmpty == false) {
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
                    NanumTitleText(text: '최근 투약내역'),
                    // Icon(
                    //   Icons.chevron_right,
                    //   weight: 900,
                    //   color: Colors.black,
                    // ),
                  ],
                ),
                style: TextButton.styleFrom(
                    iconColor: Colors.green, foregroundColor: Colors.black)),
            ////////////////////class로 빼기/////////////////////////
            MedicationTimeline(timeLineValue: medicine.medicineList),
          ],
        ),
      );
    } else {
      return NotData('최근 투약내역이 존재하지 않습니다.');
    }
  }

  Widget NotData(String noMedicineDataText) {
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
                    text: '최근 투약내역',
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
                                      healthDataType: "Medicine")));
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                          weight: 900,
                        ),
                        label: NanumBodyText(
                          text: noMedicineDataText,
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

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    if (_homeProvider.medicineValue != null) {
      return ExData(_homeProvider.medicineValue!);
    } else {
      return NotData('나의 최근 투약내역을 불러오세요');
    }
  }
}

// ignore: must_be_immutable
class MedicationTimeline extends StatelessWidget {
  const MedicationTimeline({super.key, required this.timeLineValue});
  final timeLineValue;

  @override
  Widget build(BuildContext context) {
    final data = _medicationdata(timeLineValue);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: CommonColor.widgetbackgroud),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _DeliveryProcesses(processes: data.deliveryProcesses),
          ],
        ),
      ),
    );
  }
}

class _DeliveryProcesses extends StatelessWidget {
  const _DeliveryProcesses({Key? key, required this.processes})
      : super(key: key);

  final List<_DeliveryProcess> processes;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Colors.green,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0), //timeline padding
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0.0,
            color: Colors.green,
            //원 디자인
            indicatorTheme: const IndicatorThemeData(
              // position: 0, //원 포지션
              size: 12.0, //원 사이즈
            ),
            //선 디자인
            // connectorTheme: const ConnectorThemeData(
            //   thickness: 2.5, //선 두께
            // ),
          ),
          builder: TimelineTileBuilder.connected(
            itemCount: processes.length,

            //원 옆에 글씨 생성
            contentsBuilder: (_, index) {
              if (processes[index].isCompleted) return null;

              return Padding(
                padding: const EdgeInsets.only(left: 10.0), // 선과 Content 사이 간격
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NanumBodyText(
                          text:
                              '${processes[index].time.substring(0, 4)}년 ${processes[index].time.substring(4, 6)}월 ${processes[index].time.substring(6, 8)}일',
                          //style: DefaultTextStyle.of(context).style.copyWith(
                          fontSize: 10.0,
                          color: const Color.fromARGB(163, 0, 0, 0),
                        ),
                        NanumBodyText(
                          text: processes[index].name.split("[")[0],
                          //style: DefaultTextStyle.of(context).style.copyWith(
                          fontSize: 12.0,
                          color: Colors.black,
                        ),
                      ],
                    ),

                    //),
                    _InnerTimeline(messages: processes[index].messages),
                  ],
                ),
              );
            },

            //원 생성
            indicatorBuilder: (_, index) {
              if (processes[index].isCompleted) return null;
              return const DotIndicator(position: 0);
            },

            //선 생성
            connectorBuilder: (_, index, ___) => const SolidLineConnector(
              color: Colors.green,
            ),
          ),
        ),
      ),
    );
  }
}

//Timeline 사이 글작성
class _InnerTimeline extends StatelessWidget {
  const _InnerTimeline({
    required this.messages,
  });

  final List<MedList> messages;

  @override
  Widget build(BuildContext context) {
    bool isEdgeIndex(int index) {
      return index == 0 || index == messages.length + 1;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                size: 0.0,
                position: 0.5,
              ),
        ),
        builder: TimelineTileBuilder(
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }
            return Column(children: [
              messages[index - 1].towidget()
            ]); //Row(children: [Text(messages[index - 1].toString())]);
          },
          itemExtentBuilder: (_, index) =>
              isEdgeIndex(index) ? 5.0 : 30.0, //아이템 유무에 따라 선 길이 설정
          itemCount: messages.length + 1,
        ),
      ),
    );
  }
}

// ignore: prefer_const_constructors
_medicationdata(final timeLineValue) {
  final List<_DeliveryProcess> deliveryProcesses = [];
  // print(timeLineValue is List<BloodSugarModel>);
  for (int i = 0; i < timeLineValue.length; i++) {
    if (timeLineValue[i].medList.isNotEmpty) {
      deliveryProcesses.add(_DeliveryProcess(
          timeLineValue[i].medDate, timeLineValue[i].pharmNm,
          messages: timeLineValue[i].medList));
    }
  }
  deliveryProcesses.add(const _DeliveryProcess.complete());

  return _OrderInfo(deliveryProcesses: deliveryProcesses);
}

class _OrderInfo {
  const _OrderInfo({
    required this.deliveryProcesses,
  });

  final List<_DeliveryProcess> deliveryProcesses;
}

class _DeliveryProcess {
  const _DeliveryProcess(
    this.time,
    this.name, {
    this.messages = const [],
  });

  const _DeliveryProcess.complete()
      : time = 'Done',
        name = 'Done',
        messages = const [];

  final String time;
  final String name;
  final List<MedList> messages;

  bool get isCompleted => name == 'Done';
}
