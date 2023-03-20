import 'dart:convert';

import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import "package:flutter/material.dart";
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰
import 'package:super_medic/widgets/calender_widgets/calender_widgets.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:super_medic/widgets/calender_widgets/medicineCheck.dart';
import 'package:super_medic/widgets/calender_widgets/medicineCheckForNotToday.dart';
import 'package:super_medic/pages/add_medicine.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:super_medic/provider/medicine_provider.dart';
import 'package:super_medic/widgets/calender_widgets/utils.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  String? userEmail;
  bool isLoading = false;
  MedicineTake _medicineTake = MedicineTake();
  CalendarData calData = CalendarData();

  @override
  void initState() {
    super.initState();
    getEmail();
    setState(() {
      isLoading = true;
    });
    Future.microtask(() {
      Provider.of<MedicineTake>(context, listen: false).fetchGet();
      Provider.of<CalendarData>(context, listen: false).fetchPastGet();
    }).then((value) {
      setState(() {
        isLoading = false;
      });
    });
  }

  Future<void> getEmail() async {
    const storage = FlutterSecureStorage();
    String? val = await storage.read(key: 'LoginUser');
    if (val != null) {
      userEmail = LoginModel.fromJson(jsonDecode(val)).email;
    }
  }

  @override
  Widget build(BuildContext context) {
    calData = context.watch<CalendarData>();
    _medicineTake = context.watch<MedicineTake>();
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
            title: const NanumTitleText(text: "복용약", fontSize: 20),
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
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                NanumBodyText(
                  text: '복용기록',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )
              ],
              views: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var check in _medicineTake.checkList)
                        MediCheck(
                          items: check as Map<bool, List<Check>>,
                          pad: 20,
                        ),
                      for (var check in _medicineTake.checkListForNotToday)
                        MediCheckForNotToday(
                          items: check as Map<bool, List<Check>>,
                          pad: 20,
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
                            if (mounted) {
                              setState(() {
                                isLoading = true;
                              });
                            }
                            await _medicineTake.fetchGet();
                            await calData.fetchPastGet();
                            if (mounted) {
                              setState(() {
                                isLoading = false;
                              });
                            }
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width,
                          height: 100,
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
                const TableEventsExample()
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
