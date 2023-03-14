import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart'; //스타일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_pressure_detailPage_widgets/average_blood_pressure.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_pressure_detailPage_widgets/blood_pressure_dirction.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_pressure_detailPage_widgets/blood_pressure_timeline.dart';

// ignore: must_be_immutable
class BloodPressuredetailPage extends StatefulWidget {
  const BloodPressuredetailPage({Key? key}) : super(key: key);

  @override
  State<BloodPressuredetailPage> createState() => _BloodPressuredetailPage();
}

class _BloodPressuredetailPage extends State<BloodPressuredetailPage> {
// class HealthPage extends StatelessWidget {
//   HealthPage({Key? key}) : super(key: key);
  late HomeProvider _homeProvider;
  var i = 0;
  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CommonColor.background,
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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ignore: unrelated_type_equality_checks
            AverageBloodPressure(
                averageValue: _homeProvider.bloodPressureValue),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            const BloodPressureDirction(),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Container(
              padding: AppTheme.detailpadding,
              width: double.infinity,
              decoration:
                  const BoxDecoration(color: CommonColor.widgetbackgroud),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 10),
                      child: const NanumTitleText(text: '혈압 추이'),
                    ),
                  ]),
            ),
            BloodPressureTimeline(
                timeLineValue: _homeProvider.bloodPressureValue),
          ],
        ),
      )),
    );
  }
}
