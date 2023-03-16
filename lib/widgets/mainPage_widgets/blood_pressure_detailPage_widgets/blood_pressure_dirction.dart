import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_pressure_graph.dart';

class BloodPressureDirction extends StatefulWidget {
  const BloodPressureDirction({Key? key}) : super(key: key);

  @override
  State<BloodPressureDirction> createState() => _BloodPressureDirction();
}

class _BloodPressureDirction extends State<BloodPressureDirction> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: AppTheme.detailpadding,
        width: double.infinity,
        decoration: const BoxDecoration(color: CommonColor.widgetbackgroud),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              child: const NanumTitleText(
                text: '혈압 추이',
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: BloodPressureGraph(),
            )
          ],
        ));
  }
}
