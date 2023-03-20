import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart';
import 'package:super_medic/widgets/mainPage_widgets/present_time.dart';

class BloodPressureRecordPage extends StatefulWidget {
  const BloodPressureRecordPage({super.key});

  @override
  createState() {
    return BloodPressureRecordPageState();
  }
}

// ignore: must_be_immutable
class BloodPressureRecordPageState extends State<BloodPressureRecordPage> {
  // ignore: unused_field
  late HomeProvider _homeProvider;
  final FixedExtentScrollController controller1 =
      FixedExtentScrollController(initialItem: 150);
  final FixedExtentScrollController controller2 =
      FixedExtentScrollController(initialItem: 150);
  final FixedExtentScrollController controller3 =
      FixedExtentScrollController(initialItem: 150);
  String maxbloodpressure = "150";
  String minbloodpressure = "150";
  String pulse = "150";
  List<String> maxbloodpressureItem = [];
  List<String> minbloodpressureItem = [];
  List<String> pulseItem = [];

  @override
  void initState() {
    super.initState();
    for (int i = 0; i <= 300; i++) {
      maxbloodpressureItem.add(i.toString());
      minbloodpressureItem.add(i.toString());
      pulseItem.add(i.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final ButtonStyle style = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
          //모서리를 둥글게
          borderRadius: BorderRadius.circular(0)),
      minimumSize: Size(screenWidth, screenHeight * 0.07),
      // ignore: unrelated_type_equality_checks
      backgroundColor:
          maxbloodpressure == "0" || minbloodpressure == "0" || pulse == "0"
              ? Colors.grey
              : Colors.green,
      // foregroundColor: Colors.green[900],
      elevation: 0.0,
      // foregroundColor: Colors.greenAccent,
    );

    return Scaffold(
      backgroundColor:
          maxbloodpressure == "0" || minbloodpressure == "0" || pulse == "0"
              ? Colors.grey
              : Colors.green,
      body: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
              //replace with our own icon data.
            ),
            toolbarHeight: 48,
            backgroundColor: Colors.white, //배경 색
            elevation: 0.0, //
          ),
          body: Container(
            padding: AppTheme.totalpadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                const Center(
                  child: NanumTitleText(
                    text: "혈압 기록하기",
                    fontSize: 25,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                const PresentTime(),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                Row(
                  children: [
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const NanumTitleText(
                            text: "최고(mmHg)",
                            fontSize: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      NanumBodyText(
                                        text: maxbloodpressure,
                                        color: Colors.green,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const NanumBodyText(text: 'mmHg')
                                    ],
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.8,
                                  height: screenHeight * 0.20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.transparent),
                                  child: CupertinoPicker(
                                      itemExtent: 55,
                                      scrollController: controller1,
                                      selectionOverlay:
                                          const CupertinoPickerDefaultSelectionOverlay(
                                              background: Color.fromARGB(
                                                  30, 76, 175, 79)),
                                      onSelectedItemChanged: (i) {
                                        setState(() {
                                          maxbloodpressure =
                                              maxbloodpressureItem[i];
                                        });
                                      },
                                      children: [
                                        ...maxbloodpressureItem.map((e) => Text(
                                              e,
                                              style: const TextStyle(
                                                  fontFamily: 'NotoSansKR',
                                                  color: Colors.green,
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.w500),
                                            ))
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const NanumTitleText(
                            text: "최저(mmHg)",
                            fontSize: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      NanumBodyText(
                                        text: minbloodpressure,
                                        color: Colors.green,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const NanumBodyText(text: 'mmHg')
                                    ],
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.8,
                                  height: screenHeight * 0.20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.transparent),
                                  child: CupertinoPicker(
                                      itemExtent: 55,
                                      scrollController: controller2,
                                      selectionOverlay:
                                          const CupertinoPickerDefaultSelectionOverlay(
                                              background: Color.fromARGB(
                                                  30, 76, 175, 79)),
                                      onSelectedItemChanged: (i) {
                                        setState(() {
                                          minbloodpressure =
                                              minbloodpressureItem[i];
                                        });
                                      },
                                      children: [
                                        ...minbloodpressureItem.map((e) => Text(
                                              e,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontFamily: 'NotoSansKR',
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.w500),
                                            ))
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Row(
                  children: [
                    const Flexible(
                      fit: FlexFit.tight,
                      child: Text(""),
                    ),
                    Flexible(
                      flex: 2,
                      fit: FlexFit.tight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const NanumTitleText(
                            text: "맥박(분/회)",
                            fontSize: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Column(
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.baseline,
                                    textBaseline: TextBaseline.alphabetic,
                                    children: [
                                      NanumBodyText(
                                        text: pulse,
                                        color: Colors.green,
                                        fontSize: 40,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      const NanumBodyText(text: '분/회')
                                    ],
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.8,
                                  height: screenHeight * 0.2,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: Colors.transparent),
                                  child: CupertinoPicker(
                                      itemExtent: 55,
                                      scrollController: controller3,
                                      selectionOverlay:
                                          const CupertinoPickerDefaultSelectionOverlay(
                                              background: Color.fromARGB(
                                                  30, 76, 175, 79)),
                                      onSelectedItemChanged: (i) {
                                        setState(() {
                                          pulse = pulseItem[i];
                                        });
                                      },
                                      children: [
                                        ...pulseItem.map((e) => Text(
                                              e,
                                              style: const TextStyle(
                                                  color: Colors.green,
                                                  fontFamily: 'NotoSansKR',
                                                  fontSize: 32,
                                                  fontWeight: FontWeight.w500),
                                            ))
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Flexible(
                      fit: FlexFit.tight,
                      child: Text(""),
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomSheet: TextButton(
            // style: style,
            style: style,

            child: const NanumTitleText(
              text: '저장',
              color: Colors.white,
            ),
            onPressed: () async {
              if (int.parse(maxbloodpressure) == 0 ||
                  int.parse(minbloodpressure) == 0 ||
                  int.parse(pulse) == 0) {
                null;
              } else {
                if (await secure_storage(DateTime.now(), maxbloodpressure,
                        minbloodpressure, pulse) ==
                    true) {
                  // ignore: use_build_context_synchronously
                  Provider.of<HomeProvider>(context, listen: false)
                      .bloodPressuregetData();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } else {
                  null;
                }
              }
              //
            },
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
secure_storage(DateTime DateTime, String maxbloodpressure,
    String minbloodpressure, String pulse) async {
  const storage = FlutterSecureStorage();
  var val = jsonEncode(BloodPressureModel(
      DateFormat('yyyy년 M월 d일 E요일', 'ko').format(DateTime),
      DateFormat('hh:mm', 'ko').format(DateTime),
      DateFormat('M.d', 'ko').format(DateTime),
      maxbloodpressure,
      minbloodpressure,
      pulse));
  try {
    // 데이터 저장
    await storage.write(
        key:
            'BloodPressure_${DateFormat('yyyy-M-d-h-m-s', 'ko').format(DateTime)}',
        value: val);
    String? keyValue = await storage.read(key: 'BloodPressure');
    if (keyValue == null) {
      await storage.write(
          key: 'BloodPressure',
          value:
              'BloodPressure_${DateFormat('yyyy-M-d-h-m-s', 'ko').format(DateTime)}');
    } else {
      keyValue +=
          // ignore: prefer_adjacent_string_concatenation
          ',' +
              'BloodPressure_${DateFormat('yyyy-M-d-h-m-s', 'ko').format(DateTime)}';
      await storage.write(key: 'BloodPressure', value: keyValue);
    }
    return true;
  } catch (_) {
    return false;
  }
}
