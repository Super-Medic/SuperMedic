import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/pages/selectAuth.dart';

import 'package:timelines/timelines.dart';
import 'package:super_medic/function/model.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';

class RecentMedicalRecords extends StatefulWidget {
  const RecentMedicalRecords({Key? key}) : super(key: key);

  @override
  State<RecentMedicalRecords> createState() => _RecentMedicalRecords();
}

class _RecentMedicalRecords extends State<RecentMedicalRecords> {
  late HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
  }

  Widget NotData(String noDiagnosisDataText) {
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
                  child: const NanumTitleText(
                    text: '최근 진료내역',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
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
                                          healthDataType: "Diagnosis")))
                              .then((value) {
                            setState(() {});
                          });
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                          weight: 900,
                        ),
                        label: NanumBodyText(
                          text: noDiagnosisDataText,
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

  Widget ExData(BuildContext context, DiagnosisModel diagnosis) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    if (diagnosis.diagnosisTotalList!.isEmpty == false) {
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
                onPressed: () {},
                label: const NanumBodyText(
                  text: '',
                ),
                icon: const Row(
                  children: [
                    NanumTitleText(
                      text: '최근 진료내역',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                style: TextButton.styleFrom(
                    iconColor: Colors.green, foregroundColor: Colors.black)),
            MedicalTimeline(
                timeLineValue: diagnosis.diagnosisTotalList?[0].diagnosisList)
          ],
        ),
      );
    } else {
      return NotData('최근 진료내역이 존재하지 않습니다.');
    }
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    if (_homeProvider.diagnosisValue != null) {
      return ExData(context, _homeProvider.diagnosisValue!);
    } else {
      return NotData('나의 최근 진료내역을 불러오세요');
    }
  }
}

class MedicalTimeline extends StatelessWidget {
  const MedicalTimeline({super.key, required this.timeLineValue});
  final timeLineValue;

  @override
  Widget build(BuildContext context) {
    final data = _medicaldata(timeLineValue);
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
                        SizedBox(
                          // width: 170,
                          child: Row(children: [
                            NanumTitleText(
                              text: processes[index].name.split("[")[0],
                              //style: DefaultTextStyle.of(context).style.copyWith(
                              fontSize: 12.0,
                              color: Colors.black,
                            ),
                            NanumBodyText(
                              text: processes[index].type,
                              //style: DefaultTextStyle.of(context).style.copyWith(
                              fontSize: 10.0,
                              color: const Color.fromARGB(163, 0, 0, 0),
                            ),
                          ]),
                        ),
                      ],
                    ),

                    //),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 0.0),
                      child: FixedTimeline.tileBuilder(
                        theme: TimelineTheme.of(context).copyWith(
                          indicatorTheme:
                              TimelineTheme.of(context).indicatorTheme.copyWith(
                                    size: 0.0,
                                    position: 0.5,
                                  ),
                        ),
                        builder: TimelineTileBuilder(
                          itemExtentBuilder: (_, index) =>
                              30.0, //아이템 유무에 따라 선 길이 설정
                          itemCount: 1,
                        ),
                      ),
                    ),
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

// ignore: prefer_const_constructors
_medicaldata(final timeLineValue) {
  final List<_DeliveryProcess> deliveryProcesses = [];
  // print(timeLineValue is List<BloodSugarModel>);
  for (int i = 1; i < 6; i++) {
    //timeLineValue.length
    deliveryProcesses.add(_DeliveryProcess(timeLineValue[i].diagSdate,
        timeLineValue[i].pharmNm, timeLineValue[i].diagType));
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
  const _DeliveryProcess(this.time, this.name, this.type);

  const _DeliveryProcess.complete()
      : time = 'Done',
        name = 'Done',
        type = 'Done';

  final String time;
  final String name;
  final String type;

  bool get isCompleted => name == 'Done';
}
