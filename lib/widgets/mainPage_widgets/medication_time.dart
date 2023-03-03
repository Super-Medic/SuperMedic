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
  double inputHeight = 0;
  late int today;
  Map dayToint = {
    "일": 0,
    "월": 1,
    "화": 2,
    "수": 3,
    "목": 4,
    "금": 5,
    "토": 6,
  };
  @override
  void initState() {
    super.initState();
    today = dayToint[DateFormat.E('ko_KR').format(now)];
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
    if (res.body != '[]') {
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
      double newHeight;

      if (temp.isEmpty)
        newHeight = 0;
      else if (temp.length == 1)
        newHeight = 0.160;
      else
        newHeight = 0.325;

      if (mounted) {
        setState(() {
          checkList = temp;
          inputHeight = newHeight;
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
          height: checkNull == true ? 0 : screenHeight * inputHeight,
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
                ],
              ),
            ),
          ),
      ],
    );
  }
}
