// ignore_for_file: file_names
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart';
import 'package:super_medic/widgets/mainPage_widgets/present_time.dart';

class BloodSugarRecordPage extends StatefulWidget {
  const BloodSugarRecordPage({super.key});

  @override
  createState() {
    return BloodSugarRecordPageState();
  }
}

// ignore: must_be_immutable
class BloodSugarRecordPageState extends State<BloodSugarRecordPage> {
  // ignore: unused_field
  late HomeProvider _homeProvider;
  late List<RadioModel> sampleData = [];
  int thischeckindex = 0;
  List<String> bloodsugarItem = [];
  //piker의 초기값
  final FixedExtentScrollController controller =
      FixedExtentScrollController(initialItem: 80);
  String bloodsugar = "80";

  @override
  void initState() {
    super.initState();
    sampleData.add(RadioModel(false, '공복'));
    sampleData.add(RadioModel(false, '아침식후'));
    sampleData.add(RadioModel(false, '점심식후'));
    sampleData.add(RadioModel(false, '저녁식후'));
    for (int i = 0; i <= 180; i++) {
      bloodsugarItem.add(i.toString());
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
      backgroundColor: (sampleData[0].isSelected == false &&
                  sampleData[1].isSelected == false &&
                  sampleData[2].isSelected == false &&
                  sampleData[3].isSelected == false) ||
              bloodsugar == "0"
          ? Colors.grey
          : Colors.green,
      //foregroundColor: Colors.green[900],
      elevation: 0.0,
      // foregroundColor: Colors.greenAccent,
    );

    return Scaffold(
      backgroundColor: (sampleData[0].isSelected == false &&
                  sampleData[1].isSelected == false &&
                  sampleData[2].isSelected == false &&
                  sampleData[3].isSelected == false) ||
              bloodsugar == "0"
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
                      text: "혈당 기록하기",
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
                  const NanumTitleText(
                    text: "측정시기",
                    fontSize: 15,
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  //Radio Button
                  SizedBox(
                    height: screenHeight * 0.07,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: sampleData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Row(
                          children: [
                            InkWell(
                              highlightColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  // ignore: avoid_function_literals_in_foreach_calls
                                  sampleData.forEach(
                                      (element) => element.isSelected = false);
                                  sampleData[index].isSelected = true;
                                  thischeckindex = index + 1;
                                });
                              },
                              child: RadioItem(sampleData[index]),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  const NanumTitleText(
                    text: "혈당",
                    fontSize: 15,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Text(bloodsugar,
                                  style: const TextStyle(
                                      fontFamily: 'NotoSansKR',
                                      color: Colors.green,
                                      fontSize: 32)),
                              const NanumText(text: "mg/dL")
                            ],
                          ),
                        ),
                        Container(
                          width: screenWidth * 0.8,
                          height: screenHeight * 0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.transparent),
                          child: CupertinoPicker(
                              itemExtent: 55,
                              scrollController: controller,
                              onSelectedItemChanged: (i) {
                                setState(() {
                                  bloodsugar = bloodsugarItem[i];
                                });
                              },
                              children: [
                                ...bloodsugarItem.map((e) => Text(
                                      e,
                                      style: const TextStyle(
                                          fontFamily: 'NotoSansKR',
                                          color: Colors.grey,
                                          fontSize: 32),
                                    ))
                              ]),
                        ),
                      ],
                    ),
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
                fontSize: 22,
              ),
              onPressed: () async {
                if (thischeckindex == 0 || int.parse(bloodsugar) == 0) {
                  null;
                } else {
                  if (await secure_storage(
                          DateTime.now(),
                          sampleData[thischeckindex - 1].buttonText,
                          bloodsugar) ==
                      true) {
                    try {
                      // ignore: use_build_context_synchronously
                      Provider.of<HomeProvider>(context, listen: false)
                          .bloodSugargetData();
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    } catch (_) {
                      //팝업창 띄워줄 곳
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                  } else {
                    null;
                  }
                }
                //
              },
            ),
          )),
    );
  }
}

// ignore: non_constant_identifier_names
secure_storage(DateTime DateTime, String checkbutton, String bloodsugar) async {
  const storage = FlutterSecureStorage();
  print(DateTime);
  var val = jsonEncode(BloodSugarModel(
      DateFormat('yyyy년 M월 d일 E요일', 'ko').format(DateTime),
      DateFormat('hh:mm', 'ko').format(DateTime),
      DateFormat('M.d', 'ko').format(DateTime),
      checkbutton,
      bloodsugar));
  try {
    // 데이터 저장
    await storage.write(
        key:
            'BloodSugar_${DateFormat('yyyy-M-d-h-m-s', 'ko').format(DateTime)}',
        value: val);
    String? keyValue = await storage.read(key: 'BloodSugar');
    if (keyValue == null) {
      await storage.write(
          key: 'BloodSugar',
          value:
              'BloodSugar_${DateFormat('yyyy-M-d-h-m-s', 'ko').format(DateTime)}');
    } else {
      keyValue +=
          // ignore: prefer_adjacent_string_concatenation
          ',' +
              'BloodSugar_${DateFormat('yyyy-M-d-h-m-s', 'ko').format(DateTime)}';
      await storage.write(key: 'BloodSugar', value: keyValue);
    }
    return true;
  } catch (_) {
    return false;
  }
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  const RadioItem(this._item, {super.key});
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      margin: const EdgeInsets.fromLTRB(2, 5, 2, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Container(
            height: screenHeight * 0.05, //40.0, //버튼 크기
            width: screenWidth * 0.222, //87.0,
            // ignore: sort_child_properties_last
            child: Center(
              child: Text(_item.buttonText, //텍스트 설정
                  style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      color: _item.isSelected
                          ? Colors.green
                          : const Color.fromARGB(255, 165, 165, 165),
                      //fontWeight: FontWeight.bold,
                      fontSize: 12.0)),
            ),
            decoration: BoxDecoration(
              color: _item.isSelected ? Colors.transparent : Colors.transparent,
              border: Border.all(
                  //테두리 설정
                  width: 1.3,
                  color: _item.isSelected
                      ? Colors.green //클릭 되었을 때 테두리
                      : const Color.fromARGB(90, 165, 165, 165)), //기본 테두리
              borderRadius:
                  const BorderRadius.all(Radius.circular(10.0)), //테두리 굴곡
            ),
          ),
        ],
      ),
    );
  }
}

class RadioModel {
  bool isSelected;
  final String buttonText;

  RadioModel(this.isSelected, this.buttonText);
}
