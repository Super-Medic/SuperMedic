import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/pages/selectAuth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class Screenings {
  List<ScreeningList>? screeningList;

  Screenings({this.screeningList});

  Screenings.fromJson(Map<String, dynamic> json) {
    if (json['screeningList'] != null) {
      screeningList = <ScreeningList>[];
      json['screeningList'].forEach((v) {
        screeningList!.add(ScreeningList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (screeningList != null) {
      data['screeningList'] = screeningList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScreeningList {
  String? year;
  String? result;
  String? chkAgency;
  String? opinion;
  String? screeningDate;
  String? kidney;
  String? weight;
  String? waist;
  String? BMI;
  String? vision;
  String? hearing;
  String? bloodPressure;
  String? proteinuria;
  String? hemoglobin;
  String? FBG;
  String? cholesterol;
  String? HDL;
  String? triglycerides;
  String? LDL;
  String? serumCreatinine;
  String? GFR;
  String? SGOT;
  String? SGPT;
  String? y_GTP;
  String? tuberculosis;
  String? osteoporosis;

  ScreeningList(
      {this.year,
      this.result,
      this.chkAgency,
      this.opinion,
      this.screeningDate,
      this.kidney,
      this.weight,
      this.waist,
      this.BMI,
      this.vision,
      this.hearing,
      this.bloodPressure,
      this.proteinuria,
      this.hemoglobin,
      this.FBG,
      this.cholesterol,
      this.HDL,
      this.triglycerides,
      this.LDL,
      this.serumCreatinine,
      this.GFR,
      this.SGOT,
      this.SGPT,
      this.y_GTP,
      this.tuberculosis,
      this.osteoporosis});

  ScreeningList.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    result = json['result'];
    chkAgency = json['chkAgency'];
    opinion = json['opinion'];
    screeningDate = json['screeningDate'];
    kidney = json['kidney'];
    weight = json['weight'];
    waist = json['waist'];
    BMI = json['BMI'];
    vision = json['vision'];
    hearing = json['hearing'];
    bloodPressure = json['bloodPressure'];
    proteinuria = json['proteinuria'];
    hemoglobin = json['hemoglobin'];
    FBG = json['FBG'];
    cholesterol = json['cholesterol'];
    HDL = json['HDL'];
    triglycerides = json['triglycerides'];
    LDL = json['LDL'];
    serumCreatinine = json['serumCreatinine'];
    GFR = json['GFR'];
    SGOT = json['SGOT'];
    SGPT = json['SGPT'];
    y_GTP = json['y_GTP'];
    tuberculosis = json['tuberculosis'];
    osteoporosis = json['osteoporosis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['result'] = result;
    data['chkAgency'] = chkAgency;
    data['opinion'] = opinion;
    data['screeningDate'] = screeningDate;
    data['kidney'] = kidney;
    data['weight'] = weight;
    data['waist'] = waist;
    data['BMI'] = BMI;
    data['vision'] = vision;
    data['hearing'] = hearing;
    data['bloodPressure'] = bloodPressure;
    data['proteinuria'] = proteinuria;
    data['hemoglobin'] = hemoglobin;
    data['FBG'] = FBG;
    data['cholesterol'] = cholesterol;
    data['HDL'] = HDL;
    data['triglycerides'] = triglycerides;
    data['LDL'] = LDL;
    data['serumCreatinine'] = serumCreatinine;
    data['GFR'] = GFR;
    data['SGOT'] = SGOT;
    data['SGPT'] = SGPT;
    data['y_GTP'] = y_GTP;
    data['tuberculosis'] = tuberculosis;
    data['osteoporosis'] = osteoporosis;
    return data;
  }
}

class HealthScreenings extends StatefulWidget {
  const HealthScreenings({Key? key}) : super(key: key);

  @override
  State<HealthScreenings> createState() => _HealthScreenings();
}

class _HealthScreenings extends State<HealthScreenings> {
  late dynamic screenings;

  dynamic _loadSecureStorage() async {
    screenings = await loadSecureStorage("Screenings");
    return screenings;
  }

  @override
  void initState() {
    super.initState();
    screenings = _loadSecureStorage();
  }

  // ignore: non_constant_identifier_names
  Widget State_normal() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const NanumBodyText(text: '정상', color: Colors.white),
    );
  }

  // ignore: non_constant_identifier_names
  Widget State_caution() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const NanumBodyText(text: '주의', color: Colors.white),
    );
  }

  // ignore: non_constant_identifier_names
  Widget State_danger() {
    return Container(
      padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(15),
      ),
      child: const NanumBodyText(text: '위험', color: Colors.white),
    );
  }

  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  Widget ExData(Screenings screenings) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                TextButton.icon(
                    onPressed: () {
                      print("성공");
                    },
                    label: const NanumBodyText(
                      text: '',
                    ),
                    icon: Row(
                      children: const [
                        NanumTitleText(text: '건강검진'),
                        Icon(
                          Icons.chevron_right,
                          weight: 900,
                          color: Colors.black,
                        ),
                      ],
                    ),
                    style: TextButton.styleFrom(
                        iconColor: Colors.green,
                        foregroundColor: Colors.black)),
                const NanumBodyText(text: "2022년 12월 15일"),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        const NanumBodyText(text: '종합판정'),
                        const NanumBodyText(text: '   '),
                        NanumTitleText(
                            text: screenings.screeningList?[0].result as String,
                            color: Colors.red),
                      ],
                    )),
                // Container(
                //     padding: const EdgeInsets.only(top: 10, bottom: 10),
                //     child: const Row(
                //       crossAxisAlignment: CrossAxisAlignment.baseline,
                //       textBaseline: TextBaseline.alphabetic,
                //       children: [
                //         NanumBodyText(text: '검진구분'),
                //         NanumBodyText(text: '   '),
                //         NanumTitleText(
                //             text:
                //                 "일단 일반"), //user["entry"][i]["entry"][0]["code"][0]["display"].split('(')[1].split(')')[0]
                //       ],
                //     )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        const NanumBodyText(text: '비만'),
                        const NanumBodyText(text: '   '),
                        if (double.parse(
                                screenings.screeningList?[0].BMI as String) >=
                            30)
                          State_danger(),
                        if (double.parse(screenings.screeningList?[0].BMI
                                    as String) >=
                                25 &&
                            double.parse(screenings.screeningList?[0].BMI
                                    as String) <=
                                29.8)
                          State_caution(),
                        if (double.parse(screenings.screeningList?[0].BMI
                                    as String) >=
                                18.5 &&
                            double.parse(screenings.screeningList?[0].BMI
                                    as String) <=
                                24.9)
                          State_normal(),
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        const NanumBodyText(text: '당뇨'),
                        const NanumBodyText(text: '   '),
                        if (double.parse(
                                screenings.screeningList?[0].FBG as String) >=
                            126)
                          State_danger(),
                        if (double.parse(screenings.screeningList?[0].FBG
                                    as String) >=
                                100 &&
                            double.parse(screenings.screeningList?[0].FBG
                                    as String) <=
                                125)
                          State_caution(),
                        if (double.parse(
                                screenings.screeningList?[0].FBG as String) <
                            100)
                          State_normal(),
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      children: [
                        const NanumBodyText(text: '신장'),
                        const NanumBodyText(text: '   '),
                        if (double.parse(
                                screenings.screeningList?[0].GFR as String) <
                            60)
                          State_caution(),
                        if (double.parse(
                                screenings.screeningList?[0].GFR as String) >=
                            60)
                          State_normal(),
                      ],
                    )),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      children: [
                        const NanumBodyText(text: '혈압'),
                        const NanumBodyText(text: '   '),
                        if (double.parse(screenings
                                    .screeningList?[0].bloodPressure
                                    ?.split("/")[0] as String) >=
                                140 ||
                            double.parse(screenings
                                    .screeningList?[0].bloodPressure
                                    ?.split("/")[1] as String) >=
                                90)
                          State_danger(),
                        if ((double.parse(screenings.screeningList?[0].bloodPressure
                                        ?.split("/")[0] as String) >=
                                    120 &&
                                double.parse(screenings
                                        .screeningList?[0].bloodPressure
                                        ?.split("/")[0] as String) <
                                    140) ||
                            (double.parse(screenings.screeningList?[0].bloodPressure
                                        ?.split("/")[1] as String) >=
                                    80 &&
                                double.parse(screenings.screeningList?[0].bloodPressure?.split("/")[1] as String) < 90))
                          State_caution(),
                        if (double.parse(screenings
                                    .screeningList?[0].bloodPressure
                                    ?.split("/")[0] as String) <
                                120 &&
                            double.parse(screenings
                                    .screeningList?[0].bloodPressure
                                    ?.split("/")[1] as String) <
                                80)
                          State_normal(),
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      children: [
                        const NanumBodyText(text: '빈혈'),
                        const NanumBodyText(text: '   '),
                        if (double.parse(screenings.screeningList?[0].hemoglobin
                                as String) <
                            12)
                          State_danger(),
                        if (double.parse(screenings.screeningList?[0].hemoglobin
                                    as String) >=
                                12 &&
                            double.parse(screenings.screeningList?[0].hemoglobin
                                    as String) <=
                                12.9)
                          State_caution(),
                        if (double.parse(screenings.screeningList?[0].hemoglobin
                                as String) >=
                            13)
                          State_normal(),
                      ],
                    )),
                Container(
                    padding: const EdgeInsets.only(top: 10, bottom: 20),
                    child: Row(
                      children: [
                        const NanumBodyText(text: '간'),
                        const NanumBodyText(text: '     '),
                        if (double.parse(
                                screenings.screeningList?[0].SGOT as String) >=
                            51)
                          State_danger(),
                        if (double.parse(screenings.screeningList?[0].SGOT
                                    as String) >=
                                41 &&
                            double.parse(screenings.screeningList?[0].SGOT
                                    as String) <=
                                50)
                          State_caution(),
                        if (double.parse(
                                screenings.screeningList?[0].SGOT as String) <=
                            40)
                          State_normal(),
                      ],
                    )),
              ],
            ),
          ],
        ));
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
                    text: '건강검진',
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
                                      builder: (context) => const AuthPage(
                                          healthDataType: "Screenings")))
                              .then((value) {
                            setState(() {});
                          });

                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) => const AuthPage(
                          //               healthDataType: "Screenings",
                          //             )));
                        },
                        icon: const Icon(
                          Icons.add,
                          size: 30,
                          weight: 900,
                        ),
                        label: const NanumBodyText(
                          text: '나의 건강검진내역을 불러오세요',
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
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _loadSecureStorage(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          // 데이터를 정상적으로 받아오게 되면 다음 부분을 실행하게 되는 것이다.

          if (snapshot.hasData == true) {
            if (snapshot.data == false) {
              return NotData();
            }
            Screenings screenings = snapshot.data;
            return ExData(screenings);
          }
          //error가 발생하게 될 경우 반환하게 되는 부분
          else if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(fontSize: 15),
              ),
            );
          }
          //해당 부분은 data를 아직 받아 오지 못했을때 실행되는 부분을 의미한다.
          else {
            return const CircularProgressIndicator();
          }
        });
  }
}

deleteSecureStorage() async {
  const storage = FlutterSecureStorage();
  await storage.deleteAll();
}

Future<dynamic> loadSecureStorage(String key) async {
  const storage = FlutterSecureStorage();
  String? screeningData = await storage.read(key: key);
  if (screeningData == null) {
    return false;
  }
  Screenings screenings = Screenings.fromJson(jsonDecode(screeningData));

  // Medicine medicine = Medicine.fromJson(jsonDecode(medicineData));
  return screenings;
}
