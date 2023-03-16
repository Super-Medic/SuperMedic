import 'package:flutter/material.dart';
import 'package:super_medic/pages/mainPage.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:super_medic/themes/theme.dart';

class SelectChronicDisease extends StatefulWidget {
  const SelectChronicDisease({super.key});

  @override
  State<SelectChronicDisease> createState() => _SelectChronicDiseaseState();
}

class _SelectChronicDiseaseState extends State<SelectChronicDisease> {
  bool selected = false;
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    final ButtonStyle style = TextButton.styleFrom(
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
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
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
          backgroundColor: CommonColor.background, //배경 색
          elevation: 0.0, //
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20),
        child: Form(
          key: formKey,
          child: Padding(
            padding: AppTheme.totalpadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    NanumTitleText(
                      text: '보유 질환을 선택해주세요',
                      fontSize: 25.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    // NanumTitleText(
                    //   text: '언제든 설정 메뉴에서 변경할 수 있어요',
                    //   fontSize: 25.0,
                    //   color: Colors.black,
                    //   fontWeight: FontWeight.bold,
                    // ),
                    // NanumTitleText(
                    //   text: '선택해주세요 ',
                    //   fontSize: 25.0,
                    //   color: Colors.black,
                    //   fontWeight: FontWeight.bold,
                    // ),
                  ],
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: screenHeight * 0.15,
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: ElevatedButton(
        style: style,
        onPressed: selected == true
            ? () {
                saveInitChronicDisease(tag);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              }
            : null,
        child: const NanumTitleText(text: '다음', color: Colors.white),
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
                fontFamily: 'NotoSansKR',
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
