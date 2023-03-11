import 'dart:convert';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰
import 'package:super_medic/widgets/calender_widgets/calender_widgets.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:super_medic/widgets/calender_widgets/medicineCheck.dart';
import 'package:super_medic/pages/add_medicine.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  DateTime now = DateTime.now();
  // List<Check> checks = List.empty(growable: true);
  List<List> checkList = List.empty(growable: true);
  String? userEmail;
  bool isAppPage = true;
  bool checkNull = true;
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
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: isAppPage
            ? FloatingActionButton(
                backgroundColor: Colors.green,
                child: const Icon(Icons.add, color: Colors.white),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return Container(
                        height: MediaQuery.of(context).size.height * 0.9,
                        decoration: const BoxDecoration(
                          color: Colors.white, // 모달 배경색
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: AddMedicinePage(userEmail: userEmail!),
                      );
                    },
                  ).then((value) => fetchGet());
                },
              )
            : null,
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 65,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const NanumTitleText(
            text: "복약 관리",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: ContainedTabBarView(
          tabBarProperties: TabBarProperties(
              width: 180,
              height: 42,
              alignment: TabBarAlignment.start,
              labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.black,
              indicatorPadding: const EdgeInsets.all(0.0),
              unselectedLabelColor: Colors.grey[700]),
          tabs: const [
            NanumBodyText(
              text: '복약등록',
              fontWeight: FontWeight.bold,
            ),
            NanumBodyText(
              text: '복용기록',
              fontWeight: FontWeight.bold,
            )
          ],
          views: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (checkNull != true)
                    for (var check in checkList)
                      MediCheck(
                        items: check as List<Check>,
                        pad: 40,
                      ),
                ],
              ),
            ),
            TableEventsExample()
          ],
          onChange: (p0) {
            setState(() {
              isAppPage = p0 == 0 ? true : false;
            });
          },
        ),
      ),
    );
  }
}
