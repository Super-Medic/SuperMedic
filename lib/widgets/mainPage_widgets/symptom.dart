import 'package:flutter/material.dart';
import 'package:super_medic/pages/symptom_record_selectPage.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart'; //폰트 설정 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';

class Symptom extends StatefulWidget {
  const Symptom({super.key});

  @override
  State<Symptom> createState() => _SymptomState();
}

class _SymptomState extends State<Symptom> {
  late HomeProvider _homeProvider;

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
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
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: AppTheme.widgetpadding,
              child: TextButton.icon(
                  onPressed: () async {
                    const storage = FlutterSecureStorage();
                    dynamic Symptoms = await storage.read(key: "Symptoms");
                    // print(Symptoms);
                  },
                  label: const NanumBodyText(
                    text: '',
                  ),
                  icon: const Row(
                    children: [
                      NanumTitleText(text: '증상'),
                      // Icon(
                      //   Icons.chevron_right,
                      //   weight: 900,
                      //   color: Colors.black,
                      // ),
                    ],
                  ),
                  style: TextButton.styleFrom(
                      iconColor: Colors.green, foregroundColor: Colors.black)),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SymptomRecordSelect()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: CommonColor.buttoncolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                ),
                child: const Row(
                  //spaceEvenly: 요소들을 균등하게 배치하는 속성
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    NanumTitleText(
                      text: '오늘기록',
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        _homeProvider.symptomsValue.isEmpty == false
            ? Center(
                child: Wrap(
                  direction: Axis.horizontal,
                  // alignment: WrapAlignment.start,
                  spacing: screenWidth * 0.03,
                  runSpacing: screenHeight * 0.01,

                  alignment: WrapAlignment.spaceBetween,
                  children: List.generate(
                    _homeProvider
                        .symptomsValue[_homeProvider.symptomsValue.length - 1]
                        .symptom
                        .length,
                    (index) {
                      return symptomList(
                          context,
                          index,
                          _homeProvider
                              .symptomsValue[
                                  _homeProvider.symptomsValue.length - 1]
                              .symptom);
                    },
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.only(bottom: 15),
                child:
                    const Center(child: NanumBodyText(text: '오늘의 증상을 기록해보세요!')))
      ]),
    );
  }

  Widget symptomList(BuildContext context, index, List<dynamic> symptomList) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    // print(symptomList);
    return Container(
      alignment: const Alignment(0, 0),
      width: screenWidth * 0.17,
      height: screenHeight * 0.035,
      decoration: BoxDecoration(
          color: Colors.green, borderRadius: BorderRadius.circular(550)),
      child: Text(
        symptomList[index],
        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}
