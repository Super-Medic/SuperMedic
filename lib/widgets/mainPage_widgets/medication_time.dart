import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//폰트 설정 파일
import 'package:super_medic/provider/check_box_provider.dart';
//스타일 파일
import 'package:super_medic/themes/common_color.dart';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/widgets/calender_widgets/medicineCheck.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MedicationTime extends StatefulWidget {
  const MedicationTime({
    Key? key,
  }) : super(key: key);

  @override
  State<MedicationTime> createState() => _MedicationTimeState();
}

class _MedicationTimeState extends State<MedicationTime> {
  DateTime now = DateTime.now();
  List<List> checkList = List.empty(growable: true);
  String? userEmail;
  bool checkNull = true;
  late String today;

  @override
  void initState() {
    super.initState();
    today = DateFormat.E('ko_KR').format(now);
    fetchGet();
  }

  fetchGet() async {
    const storage = FlutterSecureStorage();
    String? val = await storage.read(key: 'LoginUser');
    if (val != null) {
      userEmail = LoginModel.fromJson(jsonDecode(val)).email;
    }
    final res = await http
        .get(Uri.parse('https://mypd.kr:5000/medicine/parse?email=$userEmail'));
    List<List> temp = List.empty(growable: true);
    if (res.body != 'Empty') {
      checkNull = false;
      for (var data in json.decode(res.body)) {
        if (data['days'].contains(today)) {
          List<Check> checks = List.empty(growable: true);
          for (var time in data['times']) {
            checks.add(Check(
                id: data['id'],
                medicine: data['medicine_name'],
                time: time['time'],
                isChecked: time['check']));
          }
          temp.add(checks);
        }
      }
      if (mounted) {
        setState(() {
          checkList = temp;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    late CheckBoxProvider checkBoxProvider = context.watch<CheckBoxProvider>();
    var screenHeight = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          width: double.infinity,
          height: screenHeight * 0.325,
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
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (checkNull != true)
                    for (var check in checkList)
                      MediCheck(items: check as List<Check>, pad: 20),
                  SizedBox(height: screenHeight * 0.025),

                  // Container(
                  //   margin: AppTheme.widgetpadding,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       const NanumTitleText(
                  //         text: '다이그린',
                  //         color: Colors.green,
                  //       ),
                  //       Container(
                  //         padding: const EdgeInsets.only(top: 15, left: 20),
                  //         child: Row(
                  //           children: [
                  //             Container(
                  //               child: Column(
                  //                 children: [
                  //                   Transform.scale(
                  //                       scale: 2.5,
                  //                       child: Checkbox(
                  //                         side:
                  //                             MaterialStateBorderSide.resolveWith(
                  //                                 (states) => const BorderSide(
                  //                                     width: 1,
                  //                                     color: Colors.grey)),
                  //                         shape: RoundedRectangleBorder(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(15)),
                  //                         value: checkBoxProvider.medicine,
                  //                         onChanged: (value) {
                  //                           checkBoxProvider.set1(value!);
                  //                         },
                  //                         activeColor: Colors.green,
                  //                         checkColor: Colors.white,
                  //                       )),
                  //                   const NanumText(
                  //                     text: '오전8:00',
                  //                     fontSize: 10,
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               width: 50,
                  //             ),
                  //             Container(
                  //               child: Column(
                  //                 children: [
                  //                   Transform.scale(
                  //                       scale: 2.5,
                  //                       child: Checkbox(
                  //                         side:
                  //                             MaterialStateBorderSide.resolveWith(
                  //                                 (states) => const BorderSide(
                  //                                     width: 1,
                  //                                     color: Colors.grey)),
                  //                         shape: RoundedRectangleBorder(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(15)),
                  //                         value: checkBoxProvider.surgery,
                  //                         onChanged: (value) {
                  //                           checkBoxProvider.set2(value!);
                  //                         },
                  //                         activeColor: Colors.green,
                  //                         checkColor: Colors.white,
                  //                       )),
                  //                   const NanumText(
                  //                     text: '오후12:30',
                  //                     fontSize: 10,
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               width: 50,
                  //             ),
                  //             Container(
                  //               child: Column(
                  //                 children: [
                  //                   Transform.scale(
                  //                       scale: 2.5,
                  //                       child: Checkbox(
                  //                         side:
                  //                             MaterialStateBorderSide.resolveWith(
                  //                                 (states) => const BorderSide(
                  //                                     width: 1,
                  //                                     color: Colors.grey)),
                  //                         shape: RoundedRectangleBorder(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(15)),
                  //                         value: checkBoxProvider.obstetrics,
                  //                         onChanged: (value) {
                  //                           checkBoxProvider.set3(value!);
                  //                         },
                  //                         activeColor: Colors.green,
                  //                         checkColor: Colors.white,
                  //                       )),
                  //                   const NanumText(
                  //                     text: '오후5:30',
                  //                     fontSize: 10,
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  // Container(
                  //   margin: AppTheme.widgetpadding,
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.start,
                  //     children: [
                  //       const NanumTitleText(
                  //         text: '다이그린',
                  //         color: Colors.green,
                  //       ),
                  //       Container(
                  //         padding: const EdgeInsets.only(top: 15, left: 20),
                  //         child: Row(
                  //           children: [
                  //             Container(
                  //               child: Column(
                  //                 children: [
                  //                   Transform.scale(
                  //                       scale: 2.5,
                  //                       child: Checkbox(
                  //                         side:
                  //                             MaterialStateBorderSide.resolveWith(
                  //                                 (states) => const BorderSide(
                  //                                     width: 1,
                  //                                     color: Colors.grey)),
                  //                         shape: RoundedRectangleBorder(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(15)),
                  //                         value: checkBoxProvider.medicine,
                  //                         onChanged: (value) {
                  //                           checkBoxProvider.set1(value!);
                  //                         },
                  //                         activeColor: Colors.green,
                  //                         checkColor: Colors.white,
                  //                       )),
                  //                   const NanumText(
                  //                     text: '오전8:00',
                  //                     fontSize: 10,
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               width: 50,
                  //             ),
                  //             Container(
                  //               child: Column(
                  //                 children: [
                  //                   Transform.scale(
                  //                       scale: 2.5,
                  //                       child: Checkbox(
                  //                         side:
                  //                             MaterialStateBorderSide.resolveWith(
                  //                                 (states) => const BorderSide(
                  //                                     width: 1,
                  //                                     color: Colors.grey)),
                  //                         shape: RoundedRectangleBorder(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(15)),
                  //                         value: checkBoxProvider.surgery,
                  //                         onChanged: (value) {
                  //                           checkBoxProvider.set2(value!);
                  //                         },
                  //                         activeColor: Colors.green,
                  //                         checkColor: Colors.white,
                  //                       )),
                  //                   const NanumText(
                  //                     text: '오후12:30',
                  //                     fontSize: 10,
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //             const SizedBox(
                  //               width: 50,
                  //             ),
                  //             Container(
                  //               child: Column(
                  //                 children: [
                  //                   Transform.scale(
                  //                       scale: 2.5,
                  //                       child: Checkbox(
                  //                         side:
                  //                             MaterialStateBorderSide.resolveWith(
                  //                                 (states) => const BorderSide(
                  //                                     width: 1,
                  //                                     color: Colors.grey)),
                  //                         shape: RoundedRectangleBorder(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(15)),
                  //                         value: checkBoxProvider.obstetrics,
                  //                         onChanged: (value) {
                  //                           checkBoxProvider.set3(value!);
                  //                         },
                  //                         activeColor: Colors.green,
                  //                         checkColor: Colors.white,
                  //                       )),
                  //                   const NanumText(
                  //                     text: '오후5:30',
                  //                     fontSize: 10,
                  //                   )
                  //                 ],
                  //               ),
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                ],
              )),
        ),
      ],
    );
  }
}
