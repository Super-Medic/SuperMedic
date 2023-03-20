import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/widgets/blood_sugar_total_graph.dart';
import 'package:super_medic/provider/home_provider.dart';

class BloodSugarDirction extends StatefulWidget {
  const BloodSugarDirction({Key? key}) : super(key: key);

  @override
  State<BloodSugarDirction> createState() => _BloodSugarDirction();
}

class _BloodSugarDirction extends State<BloodSugarDirction> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    HomeProvider().bloodPressuregetData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: AppTheme.detailpadding,
        width: double.infinity,
        decoration: const BoxDecoration(color: CommonColor.widgetbackgroud),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      NanumTitleText(text: '혈당 추이', fontSize: 15),
                    ]),
                    // TextButton(
                    //     onPressed: () => {
                    //           // Navigator.push(
                    //           //     context,
                    //           //     MaterialPageRoute(
                    //           //         builder: (context) =>
                    //           //             const BloodSugarRecordPage()))
                    //         },
                    //     style: TextButton.styleFrom(
                    //       backgroundColor:
                    //           const Color.fromARGB(150, 158, 158, 158),
                    //       shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(5)),
                    //       padding: const EdgeInsets.symmetric(horizontal: 7),
                    //     ),
                    //     child: const NanumTitleText(
                    //       text: '분석',
                    //       fontSize: 15,
                    //       color: Colors.white,
                    //     )),
                  ]),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: const BloodSugarTotalGraph(),
            )
          ],
        ));
  }
}
