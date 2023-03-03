import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/pages/selectAuth.dart';

import 'package:timelines/timelines.dart';
import 'package:super_medic/function/model.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';

// class Diagnosis {
//   List<DiagnosisTotalList>? diagnosisTotalList;

//   Diagnosis({this.diagnosisTotalList});

//   Diagnosis.fromJson(Map<String, dynamic> json) {
//     if (json['diagnosisTotalList'] != null) {
//       diagnosisTotalList = <DiagnosisTotalList>[];
//       json['diagnosisTotalList'].forEach((v) {
//         diagnosisTotalList!.add(DiagnosisTotalList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (diagnosisTotalList != null) {
//       data['diagnosisTotalList'] =
//           diagnosisTotalList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class DiagnosisTotalList {
//   List<DiagnosisList>? diagnosisList;

//   DiagnosisTotalList({this.diagnosisList});

//   DiagnosisTotalList.fromJson(Map<String, dynamic> json) {
//     if (json['diagnosisList'] != null) {
//       diagnosisList = <DiagnosisList>[];
//       json['diagnosisList'].forEach((v) {
//         diagnosisList!.add(DiagnosisList.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     if (diagnosisList != null) {
//       data['diagnosisList'] = diagnosisList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class DiagnosisList {
//   String? examinee;
//   String? No;
//   String? pharmNm;
//   String? diagType;
//   String? diagSdate;

//   DiagnosisList(
//       {this.examinee, this.No, this.pharmNm, this.diagType, this.diagSdate});

//   DiagnosisList.fromJson(Map<String, dynamic> json) {
//     examinee = json['examinee'];
//     No = json['No'];
//     pharmNm = json['pharmNm'];
//     diagType = json['diagType'];
//     diagSdate = json['diagSdate'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['examinee'] = examinee;
//     data['No'] = No;
//     data['pharmNm'] = pharmNm;
//     data['diagType'] = diagType;
//     data['diagSdate'] = diagSdate;
//     return data;
//   }
// }

class RecentMedicalRecords extends StatefulWidget {
  const RecentMedicalRecords({Key? key}) : super(key: key);

  @override
  State<RecentMedicalRecords> createState() => _RecentMedicalRecords();
}

class _RecentMedicalRecords extends State<RecentMedicalRecords> {
  // late dynamic diagnosis;

  // dynamic _loadSecureStorage() async {
  //   diagnosis = await loadSecureStorage("Diagnosis");
  //   return diagnosis;
  // }
  late HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    // diagnosis = _loadSecureStorage();
  }

  Widget item(text1, text2, text3) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(children: [
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(width: screenWidth * 0.03),
        const Icon(Icons.circle, color: Colors.green, size: 12),
        SizedBox(width: screenWidth * 0.05),
        NanumText(
            text: text1.substring(0, 4) +
                "년 " +
                text1.substring(4, 6) +
                "월 " +
                text1.substring(6, 8) +
                "일 "),
        SizedBox(width: screenWidth * 0.02),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              NanumTitleText(text: text2),
              const NanumBodyText(text: " "),
              NanumText(text: text3)
            ],
          ),
          SizedBox(
            height: screenHeight * 0.01,
          )
        ]),
      ]),
    ]);
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
                    text: '최근 진료내역',
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
                        label: const NanumBodyText(
                          text: '나의 최근 진료내역을 불러오세요',
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
  Widget ExData(BuildContext context, DiagnosisModel diagnosis) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;

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
                  NanumTitleText(text: '최근 진료내역'),
                  // Icon(
                  //   Icons.chevron_right,
                  //   weight: 900,
                  //   color: Colors.black,
                  // ),
                ],
              ),
              style: TextButton.styleFrom(
                  iconColor: Colors.green, foregroundColor: Colors.black)),
          MedicalTimeline(
              timeLineValue: diagnosis.diagnosisTotalList?[0].diagnosisList)
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    if (_homeProvider.diagnosisValue != null) {
      return ExData(context, _homeProvider.diagnosisValue!);
    } else {
      return NotData();
    }

    //   FutureBuilder(
    //       future: _loadSecureStorage(),
    //       builder: (BuildContext context, AsyncSnapshot snapshot) {
    //         // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.

    //         if (snapshot.hasData == true) {
    //           if (snapshot.data == false) {
    //             return NotData();
    //           }
    //           Diagnosis diagnosis = snapshot.data;
    //           return ExData(context, diagnosis);
    //         }
    //         //error가 발생하게 될 경우 반환하게 되는 부분
    //         else if (snapshot.hasError) {
    //           return Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: Text(
    //               'Error: ${snapshot.error}',
    //               style: const TextStyle(fontSize: 15),
    //             ),
    //           );
    //         }
    //         //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
    //         else {
    //           return const CircularProgressIndicator();
    //         }
    //       });
    // }
  }

// deleteSecureStorage() async {
//   const storage = FlutterSecureStorage();
//   await storage.deleteAll();
// }

// Future<dynamic> loadSecureStorage(String key) async {
//   const storage = FlutterSecureStorage();
//   String? screeningData = await storage.read(key: key);
//   if (screeningData == null) {
//     return false;
//   }
//   Diagnosis diagnosis = Diagnosis.fromJson(jsonDecode(screeningData));

//   // Medicine medicine = Medicine.fromJson(jsonDecode(medicineData));
//   return diagnosis;
// }
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
                          fontSize: 12.0,
                          color: const Color.fromARGB(163, 0, 0, 0),
                        ),
                        SizedBox(
                          child: Row(children: [
                            NanumTitleText(
                              text: processes[index].name.split("[")[0],
                              //style: DefaultTextStyle.of(context).style.copyWith(
                              fontSize: 15.0,
                              color: Colors.black,
                            ),
                            NanumBodyText(
                              text: processes[index].type,
                              //style: DefaultTextStyle.of(context).style.copyWith(
                              fontSize: 12.0,
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
