import 'package:flutter/material.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/pages/mainPage.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SelectChronicDisease extends StatefulWidget {
  const SelectChronicDisease({super.key});

  @override
  State<SelectChronicDisease> createState() => _SelectChronicDiseaseState();
}

class _SelectChronicDiseaseState extends State<SelectChronicDisease> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
          //모서리를 둥글게
          borderRadius: BorderRadius.circular(0)),
      minimumSize: Size(screenWidth, screenHeight * 0.07),
      // backgroundColor: Colors.green,
      backgroundColor: Colors.green,
      foregroundColor: Colors.green[900],
      elevation: 0.0,
    );

    return Scaffold(
      backgroundColor: CommonColor.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: screenHeight * 0.05,
            ),
            Image.asset(
              "assets/images/main_logo.png",
              width: screenWidth * 0.25,
              height: screenHeight * 0.15,
            ),
            SizedBox(
              height: screenHeight * 0.005,
            ),
            const NanumText(
              text: "보유 질환을 선택해주세요 \n언제든 설정 메뉴에서 변경할 수 있어요",
              fontSize: 17,
              // fontWeight: FontWeight.bold,
              color: CommonColor.boxshadowcolor,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            Wrap(
              direction: Axis.horizontal,
              // alignment: WrapAlignment.start,
              spacing: screenWidth * 0.03,
              runSpacing: screenHeight * 0.005,

              alignment: WrapAlignment.spaceBetween,
              children: List.generate(
                tag.length,
                (index) {
                  return buildTags(context, index);
                },
              ),
            ),
            SizedBox(
              height: screenHeight * 0.005,
            ),
            // const TotalDisease(),
            SizedBox(
              height: screenHeight * 0.2,
            ),
            ElevatedButton(
              style: style,
              onPressed: selected == true
                  ? () {
                      saveInitChronicDisease(tag);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );
                    }
                  : null,
              child: const NanumTitleText(text: '다음으로', color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  final List<Map<String, dynamic>> tag = [
    {'state': '당뇨', 'isCheck': false},
    {'state': '고혈압', 'isCheck': false},
    {'state': '고지혈증', 'isCheck': false},
    {'state': '고관절염', 'isCheck': false},
    {'state': '요통', 'isCheck': false},
    {'state': '골다공증', 'isCheck': false},
    {'state': '백내장', 'isCheck': false},
    {'state': '심장질환', 'isCheck': false},
    {'state': '천식', 'isCheck': false},
    {'state': '심근경색증', 'isCheck': false},
    {'state': '뇌졸중', 'isCheck': false},
    {'state': '그 외', 'isCheck': false},
  ];

  Widget buildTags(BuildContext context, index) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return ChoiceChip(
        backgroundColor: Colors.white,
        labelPadding: const EdgeInsets.all(0.0),
        pressElevation: 0,
        label: Container(
          alignment: const Alignment(0, 0),
          width: screenWidth * 0.17,
          height: screenHeight * 0.02,
          child: Text(
            tag[index]['state'],
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: tag[index]['isCheck'] ? Colors.white : Colors.grey,
                fontSize: 11,
                fontWeight: FontWeight.bold),
          ),
        ),
        selected: tag[index]['isCheck'] == true,
        selectedColor: Colors.green,
        onSelected: (value) {
          setState(() {
            tag[index]['isCheck'] = !tag[index]['isCheck'];
            for (int i = 0; i < tag.length; i++) {
              if (tag[i]['isCheck'] == true) {
                selected = true;
                break;
              }
              selected = false;
            }
          });
        },
        elevation: 0);
  }
}

saveInitChronicDisease(List<Map<String, dynamic>> tag) async {
  const storage = FlutterSecureStorage();
  storage.write(key: "initChronicDisease", value: jsonEncode(tag));
}
