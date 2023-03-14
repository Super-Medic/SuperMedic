import 'dart:convert';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰
import 'package:super_medic/widgets/calender_widgets/calender_widgets.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:super_medic/widgets/calender_widgets/medicineCheck.dart';
import 'package:super_medic/widgets/calender_widgets/medicineCheckForNotToday.dart';

import 'package:super_medic/pages/add_medicine.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  DateTime now = DateTime.now();
  // List<Check> checks = List.empty(growable: true);
  List<Map> checkList = List.empty(growable: true); // 오늘 복약 O
  List<Map> checkListForNotToday = List.empty(growable: true); // 오늘 복약 X
  String? userEmail;
  bool checkNull = true;
  bool isLoading = false;

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
    setState(() {
      isLoading = true;
    });
    fetchGet().then((res) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> fetchGet() async {
    const storage = FlutterSecureStorage();
    String? val = await storage.read(key: 'LoginUser');
    if (val != null) {
      userEmail = LoginModel.fromJson(jsonDecode(val)).email;
    }
    final res = await http.get(Uri.parse(
        'https://mypd.kr:5000/medicine/parse/current?email=$userEmail'));
    List<Map> temp = List.empty(growable: true);
    List<Map> tempForNotToday = List.empty(growable: true);
    if (res.body != 'Empty') {
      checkNull = false;
      for (var data in json.decode(res.body)) {
        if (data['days'].contains(today)) {
          Map<bool, List<Check>> checkMap = <bool, List<Check>>{};
          List<Check> checks = List.empty(growable: true);
          for (var time in data['times']) {
            checks.add(
              Check(
                id: data['id'],
                medicine: data['medicine_name'],
                time: time['time'],
                isChecked: time['check'],
              ),
            );
          }
          checkMap[true] = checks;
          temp.add(checkMap);
        } else {
          Map<bool, List<Check>> checkMapForNotToday = <bool, List<Check>>{};
          List<Check> checksForNotToday = List.empty(growable: true);
          for (var time in data['times']) {
            checksForNotToday.add(
              Check(
                id: data['id'],
                medicine: data['medicine_name'],
                time: time['time'],
                isChecked: time['check'],
              ),
            );
          }
          checkMapForNotToday[true] = checksForNotToday;
          tempForNotToday.add(checkMapForNotToday);
        }
      }
      if (mounted) {
        setState(() {
          checkList = temp;
          checkListForNotToday = tempForNotToday;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: CommonColor.background,
          appBar: AppBar(
            leading: Container(),
            toolbarHeight: 65,
            backgroundColor: CommonColor.background,
            elevation: 0.0,
            title: const NanumTitleText(
              text: "복용약",
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          body: SafeArea(
            child: ContainedTabBarView(
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
                            items: check as Map<bool, List<Check>>,
                            pad: 40,
                          ),
                      if (checkNull != true)
                        for (var check in checkListForNotToday)
                          MediCheckForNotToday(
                            items: check as Map<bool, List<Check>>,
                            pad: 40,
                          ),
                      InkWell(
                        onTap: () async {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (BuildContext context) {
                              return Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.9,
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
                          ).then((value) async {
                            setState(() {
                              isLoading = true;
                            });
                            await fetchGet();
                            setState(() {
                              isLoading = false;
                            });
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          height: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                              border: Border.all(color: Colors.green)),
                          child: Center(
                              child: Image.asset(
                            'assets/images/plus.png',
                            width: 60,
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
                TableEventsExample()
              ],
            ),
          ),
        ),
        Stack(children: <Widget>[
          Opacity(
            opacity: 0.5, //0.5만큼~
            child: isLoading
                ? const ModalBarrier(dismissible: false, color: Colors.black)
                : null, //클릭 못하게~
          ),
          Center(
            child: isLoading
                ? SpinKitSpinningCircle(
                    itemBuilder: (context, index) {
                      return Center(
                          child: Image.asset(
                        'assets/images/loading.png',
                      ));
                    },
                  )
                : null, //무지성 돌돌이~
          ),
        ]),
      ],
    );
  }
}
