import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart'; //스타일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/widgets/mainPage_widgets/symptoms_detailPage_widgets/symptoms_recent_major.dart';
import 'package:super_medic/widgets/mainPage_widgets/symptoms_detailPage_widgets/symptoms_timeline.dart';

// ignore: must_be_immutable
class SymptomsdetailPage extends StatefulWidget {
  const SymptomsdetailPage({Key? key}) : super(key: key);

  @override
  State<SymptomsdetailPage> createState() => _SymptomsdetailPage();
}

class _SymptomsdetailPage extends State<SymptomsdetailPage> {
// class HealthPage extends StatelessWidget {
//   HealthPage({Key? key}) : super(key: key);
  late HomeProvider _homeProvider;

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
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
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SymptomsRecentMajor(),
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
                          child: const NanumTitleText(text: '증상 기록'),
                        ),
                        const SymptomsTimeline()
                      ]),
                ),
              ],
            ),
          )),
    );
  }
}
