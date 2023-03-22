import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_sugar_detailPage_widgets/average_blood_sugar.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_sugar_detailPage_widgets/blood_sugar_dirction.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_sugar_detailPage_widgets/blood_sugar_timeline.dart';

// ignore: must_be_immutable
class BloodSugardetailPage extends StatefulWidget {
  const BloodSugardetailPage({Key? key}) : super(key: key);

  @override
  State<BloodSugardetailPage> createState() => _BloodSugardetailPage();
}

class _BloodSugardetailPage extends State<BloodSugardetailPage> {
  // 스크롤 제어를 위한 컨트롤러를 선언합니다.
  final ScrollController _scrollController = ScrollController();
  late HomeProvider _homeProvider;

  void _scrollToTop() {
    setState(() {
      _scrollController.jumpTo(0);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  var i = 0;
  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CommonColor.background,
      appBar: AppBar(
        leading: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          IconButton(
            padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          const NanumTitleText(text: '혈당', fontSize: 20),
        ]),
        leadingWidth: 100,
        toolbarHeight: 48,
        backgroundColor: Colors.white, //배경 색
        elevation: 0.0, //
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // ignore: unrelated_type_equality_checks
            AverageBloodSugar(averageValue: _homeProvider.bloodSugarValue),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            const BloodSugarDirction(),
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
                      child: const NanumTitleText(
                        text: '혈당 기록',
                        fontSize: 15,
                      ),
                    ),
                  ]),
            ),
            BloodSugarTimeline(timeLineValue: _homeProvider.bloodSugarValue),
          ],
        ),
      )),
      floatingActionButton: FloatingActionButton.small(
        backgroundColor: Colors.green,
        onPressed: () {
          // 스크롤 위치 맨위로 이동
          _scrollToTop();
        },
        child: const Icon(
          Icons.expand_less,
        ),
      ),
    );
  }
}
