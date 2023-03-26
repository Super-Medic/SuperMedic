import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/pages/symptom_record_selectPage.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart';

class SymptomsRecentMajor extends StatefulWidget {
  const SymptomsRecentMajor({super.key});

  @override
  State<SymptomsRecentMajor> createState() => _SymptomsRecentMajorState();
}

class _SymptomsRecentMajorState extends State<SymptomsRecentMajor> {
  late HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();

    // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
    //   dynamic recordSymptom =
    //       Provider.of<HomeProvider>(context, listen: false).symptomsValue;
    //   symptomCount(recordSymptom).then((result) {
    //     setState(() {});
    //   });
    // });
    // print('initState');
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    List<String> recentMajorSymptomList = [];
    Map<String, int> symptomsForCount = {
      '두통': 0,
      '발열': 0,
      '편두통': 0,
      '어지러움': 0,
      '피로감': 0,
      '가슴두근': 0,
      '근육통': 0,
      '뒷골': 0,
      '코피': 0,
      '혈뇨': 0,
      '시력저하': 0,
      '오한': 0,
      '손발저림': 0,
      '부종': 0,
      'PMS': 0,
      '성욕감퇴': 0,
      '여드름': 0,
      '안면홍조': 0,
      '식은땀': 0,
      '각질': 0,
      '가려움': 0,
      '변비': 0,
      '소화불량': 0,
      '속쓰림': 0,
      '설사': 0,
      '경련': 0,
      '복통': 0,
      '메스꺼움': 0,
      '복부팽만': 0,
    };

    // 많이 기록된 증상 오름차순 정렬
    symptomSortByCount() async {
      var sortedSymptom = Map.fromEntries(symptomsForCount.entries.toList()
        ..sort((e1, e2) => e1.value.compareTo(e2.value)));

      // 최근 일주일 증상 중 주요 3개 증상
      for (int i = 0; i < 3; i++) {
        if (sortedSymptom[sortedSymptom.keys
                .toList()[sortedSymptom.keys.length - 1 - i]] !=
            0) {
          // recentMajorSymptomList.add(
          //     sortedSymptom.keys.toList()[sortedSymptom.keys.length - 1 - i]);
          recentMajorSymptomList.add(
              sortedSymptom.keys.toList()[sortedSymptom.keys.length - 1 - i]);
        }
      }
    }

    symptomCount(dynamic recordSymptom) async {
      print(recordSymptom);
      // 기록된 증상이 7일 이하인 경우
      if (recordSymptom.length < 7) {
        for (int i = 0; i < recordSymptom.length; i++) {
          for (int j = 0; j < recordSymptom[i].symptom.length; j++) {
            symptomsForCount[recordSymptom[i].symptom[j]] =
                symptomsForCount[recordSymptom[i].symptom[j]]! + 1;
          }
        }
      }
      // 기록된 증상이 7일 이상인 경우
      else {
        for (int i = 0; i < 7; i++) {
          for (int j = 0; j < recordSymptom[i].symptom.length; j++) {
            symptomsForCount[recordSymptom[i].symptom[j]] =
                symptomsForCount[recordSymptom[i].symptom[j]]! + 1;
          }
        }
      }

      await symptomSortByCount();
    }

// dynamic recordSymptom =
//           Provider.of<HomeProvider>(context, listen: false).symptomsValue;
    print("----");
    print(_homeProvider.symptomsValue);
    print("----");
    symptomCount(_homeProvider.symptomsValue);

    // .then((result) {
    //   setState(() {});
    // });

    return Container(
        // padding:
        // const EdgeInsets.fromLTRB(25, 10, 10, 0), // AppTheme.detailpadding,
        width: double.infinity,
        decoration: const BoxDecoration(color: CommonColor.widgetbackgroud),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(25, 10, 10, 0),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(children: [NanumTitleText(text: "최근 주요 증상")]),
                    ),

                    // const NanumText(text: '최근 10회'),
                  ]),
            ),
            Container(
                padding: const EdgeInsets.fromLTRB(15, 10, 10, 0),
                child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // height: screenHeight * 0.01,
                        width: screenWidth * 0.7,
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: _homeProvider.symptomsValue.isEmpty == false
                            ? getRecentSymptoms(context, recentMajorSymptomList)
                            : const NanumBodyText(
                                text: "오늘의 증상을 기록해보세요!",
                                color: Colors.grey,
                              ),
                      ),
                      // SizedBox(width: screenWidth * 0.0001),
                      Container(
                        padding:
                            EdgeInsets.fromLTRB(screenWidth * 0.01, 0, 0, 0),
                        child: Center(
                          child: TextButton(
                              onPressed: () => {
                                    Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const SymptomRecordSelect()))
                                        .then((value) {
                                      symptomCount(_homeProvider.symptomsValue)
                                          .then((result) {
                                        setState(() {});
                                      });
                                    })
                                  },
                              style: TextButton.styleFrom(
                                backgroundColor: CommonColor.buttoncolor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                              ),
                              child: const NanumTitleText(
                                  text: '기록하기',
                                  fontSize: 13,
                                  color: Colors.white)),
                        ),
                      ),
                    ])),
            // Container(
            //   padding: EdgeInsets.fromLTRB(screenWidth * 0.01, 0, 0, 0),
            //   child: Center(
            //     child: TextButton(
            //         onPressed: () => {removeSymptom(_homeProvider)},
            //         style: TextButton.styleFrom(
            //           backgroundColor: CommonColor.buttoncolor,
            //           shape: RoundedRectangleBorder(
            //               borderRadius: BorderRadius.circular(5)),
            //           padding: const EdgeInsets.symmetric(horizontal: 15),
            //         ),
            //         child: const NanumTitleText(
            //             text: '삭제하기',
            //             fontSize: 13,
            //             color: Colors.white,
            //             fontWeight: FontWeight.normal)),
            //   ),
            // ),
            SizedBox(height: screenHeight * 0.01),
          ],
        ));
  }

  removeSymptom(HomeProvider homeProvider) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "Symptoms");
    homeProvider.symptomgetData();
  }

  Widget getRecentSymptoms(
      BuildContext context, List<String> recentMajorSymptomList) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Wrap(
      direction: Axis.horizontal,
      // alignment: WrapAlignment.start,
      spacing: screenWidth * 0.015,
      // runSpacing: screenHeight * 0.005,

      alignment: WrapAlignment.spaceBetween,
      children: List.generate(
        recentMajorSymptomList.length,
        (index) {
          return Container(
            alignment: const Alignment(0, 0),
            width: screenWidth * 0.2,
            height: screenHeight * 0.035,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              recentMajorSymptomList[index],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: const Color.fromRGBO(96, 96, 96, 1),
                  fontSize: 11,
                  fontFamily: "NotoSansKRr",
                  fontWeight: FontWeight.bold),
            ),
          );
        },
      ),
    );
  }
}
