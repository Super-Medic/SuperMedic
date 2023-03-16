import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart';
import 'package:super_medic/widgets/mainPage_widgets/present_time.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';

// ignore: must_be_immutable
class SymptomRecordSelect extends StatefulWidget {
  const SymptomRecordSelect({super.key});

  @override
  State<SymptomRecordSelect> createState() => _SymptomRecordSelectState();
}

class _SymptomRecordSelectState extends State<SymptomRecordSelect> {
  late HomeProvider _homeProvider;

  bool selected = false;
  Map<String, List<Map<String, dynamic>>> dailySymptom = {
    "Head": [
      {'state': '두통', 'isCheck': false},
      {'state': '편두통', 'isCheck': false},
      {'state': '발열', 'isCheck': false},
      {'state': '어지러움', 'isCheck': false},
    ],
    "Body": [
      {'state': '피로감', 'isCheck': false},
      {'state': '가슴두근', 'isCheck': false},
      {'state': '근육통', 'isCheck': false},
      {'state': '뒷골', 'isCheck': false},
      {'state': '코피', 'isCheck': false},
      {'state': '혈뇨', 'isCheck': false},
      {'state': '시력저하', 'isCheck': false},
      {'state': '오한', 'isCheck': false},
      {'state': '손발저림', 'isCheck': false},
      {'state': '부종', 'isCheck': false},
      {'state': 'PMS', 'isCheck': false},
      {'state': '성욕감퇴', 'isCheck': false},
    ],
    "Skin": [
      {'state': '여드름', 'isCheck': false},
      {'state': '안면홍조', 'isCheck': false},
      {'state': '식은땀', 'isCheck': false},
      {'state': '각질', 'isCheck': false},
      {'state': '가려움', 'isCheck': false},
    ],
    "Stomach": [
      {'state': '변비', 'isCheck': false},
      {'state': '소화불량', 'isCheck': false},
      {'state': '속쓰림', 'isCheck': false},
      {'state': '설사', 'isCheck': false},
      {'state': '경련', 'isCheck': false},
      {'state': '복통', 'isCheck': false},
      {'state': '메스꺼움', 'isCheck': false},
      {'state': '복부팽만', 'isCheck': false},
    ]
  };

// 오늘 기록된 증상이 존재할 경우 해당 증상은 체크
  todaySymptomCheck(dynamic todaySymptom) async {
    DateTime now = DateTime.now();
    final dateKey = DateFormat('yyyy년MM월dd일').format(DateTime.now());
    if (todaySymptom.isEmpty == false) {
      for (int i = 0; i < todaySymptom.length; i++) {
        if (todaySymptom[i].DateTime == dateKey) {
          for (int j = 0; j < todaySymptom[i].symptom.length; j++) {
            for (int k = 0; k < dailySymptom.keys.length; k++) {
              for (int l = 0;
                  l < dailySymptom[dailySymptom.keys.toList()[k]]!.length;
                  l++) {
                if (dailySymptom[dailySymptom.keys.toList()[k]]![l]['state'] ==
                    todaySymptom[i].symptom[j]) {
                  dailySymptom[dailySymptom.keys.toList()[k]]![l]['isCheck'] =
                      true;
                }
              }
            }
          }
        }
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      dynamic todaySymptom =
          Provider.of<HomeProvider>(context, listen: false).symptomsValue;
      todaySymptomCheck(todaySymptom).then((result) {
        setState(() {});
      });
    });
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
      backgroundColor: Colors.green,
      disabledBackgroundColor: Colors.grey,
      foregroundColor: Colors.green[900],
      elevation: 0.0,
      // foregroundColor: Colors.greenAccent,
    );

    return Scaffold(
      backgroundColor: selected ? Colors.green : Colors.grey,
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
                    text: '증상 기록하기',
                    fontSize: 25,
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
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
                  text: "머리",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                SymptomButton(context, "Head"),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const NanumTitleText(
                  text: "몸 상태",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                SymptomButton(context, "Body"),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const NanumTitleText(
                  text: "피부",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                SymptomButton(context, "Skin"),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                const NanumTitleText(
                  text: "복부",
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                SymptomButton(context, "Stomach")
              ],
            ),
          ),
          bottomSheet: TextButton(
            // style: style,
            style: style,
            onPressed: selected == true
                ? () async {
                    await saveSymptoms(dailySymptom, context);
                    // _homeProvider.symptomgetData();
                    Provider.of<HomeProvider>(context, listen: false)
                        .symptomgetData();
                    var nav = Navigator.of(context);
                    nav.pop();
                    // Navigator.pop(context);
                  }
                : null,

            child: const NanumTitleText(
              text: '저장',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget SymptomButton(BuildContext context, String bodyPart) {
    // List<Map<String, dynamic>> symptom = symptom;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: const Alignment(0, 0),
      child: Wrap(
        direction: Axis.horizontal,
        // alignment: WrapAlignment.start,
        spacing: screenWidth * 0.03,
        // runSpacing: screenHeight * 0.005,

        alignment: WrapAlignment.spaceBetween,
        children: List.generate(
          dailySymptom[bodyPart]!.length,
          (index) {
            return buildTags(context, index, bodyPart);
          },
        ),
      ),
    );
  }

  Widget buildTags(BuildContext context, index, bodyPart) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return ChoiceChip(
        // backgroundColor: const Color.fromRGBO(244, 244, 244, 0.9),
        backgroundColor: const Color.fromARGB(200, 244, 244, 244),
        labelPadding: const EdgeInsets.all(0.0),
        pressElevation: 0,
        label: Container(
          alignment: const Alignment(0, 0),
          width: screenWidth * 0.17,
          height: screenHeight * 0.02,
          child: Text(
            dailySymptom[bodyPart]![index]['state'],
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: dailySymptom[bodyPart]![index]['isCheck']
                    ? Colors.white
                    : const Color.fromRGBO(96, 96, 96, 1),
                fontSize: 11,
                fontFamily: "NotoSansKR",
                fontWeight: FontWeight.bold),
          ),
        ),
        selected: dailySymptom[bodyPart]![index]['isCheck'] == true,
        selectedColor: Colors.green,
        onSelected: (value) {
          setState(() {
            dailySymptom[bodyPart]![index]['isCheck'] =
                !dailySymptom[bodyPart]![index]['isCheck'];
            List<String> dailySymptomKey = dailySymptom.keys.toList();
            for (int i = 0; i < dailySymptomKey.length; i++) {
              for (int j = 0;
                  j < dailySymptom[dailySymptomKey[i]]!.length;
                  j++) {
                if (dailySymptom[dailySymptomKey[i]]![j]['isCheck'] == true) {
                  selected = true;
                  i = dailySymptomKey.length;
                  break;
                }
                selected = false;
              }
            }
          });
        },
        elevation: 0);
  }
}

saveSymptoms(Map<String, List<Map<String, dynamic>>> symptom,
    BuildContext context) async {
  late HomeProvider homeProvider = context.watch<HomeProvider>();
  DateTime now = DateTime.now();
  final dateKey = DateFormat('yyyy년MM월dd일').format(DateTime.now());

  const storage = FlutterSecureStorage();

  Map<String, List<dynamic>> symptomTmp = {
    "Head": [],
    "Body": [],
    "Skin": [],
    "Stomach": []
  };
  Map<String, dynamic> symptomAdd = {};

  addSymptomForSave(symptom["Head"]!, "Head", symptomTmp);
  addSymptomForSave(symptom["Body"]!, "Body", symptomTmp);
  addSymptomForSave(symptom["Skin"]!, "Skin", symptomTmp);
  addSymptomForSave(symptom["Stomach"]!, "Stomach", symptomTmp);

  dynamic Symptoms = await storage.read(key: "Symptoms");

  Symptoms ??= "{}"; // 저장된 Symptoms가 없을 경우

  Symptoms = jsonDecode(Symptoms as String);
  // symptomAdd[dateKey] = symptomTmp;
  // Symptoms.insert(0, symptomAdd);
  Symptoms[dateKey] = symptomTmp;

  await storage.write(key: "Symptoms", value: jsonEncode(Symptoms));
}

addSymptomForSave(List<Map<String, dynamic>> symptom, String state,
    Map<String, List<dynamic>> symptomsTmp) {
  for (int i = 0; i < symptom.length; i++) {
    if (symptom[i]["isCheck"] == true) {
      symptomsTmp[state]!.add(symptom[i]["state"]);
    }
  }
}
