import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
  List<String> recentSymptomList = [];

  

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    return Container(
        padding:
            const EdgeInsets.fromLTRB(25, 10, 0, 0), // AppTheme.detailpadding,
        width: double.infinity,
        decoration: const BoxDecoration(color: CommonColor.widgetbackgroud),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(bottom: 20),
              child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(children: [
                        NanumTitleText(
                          text: "최근 주요 증상",
                          fontWeight: FontWeight.bold,
                        )
                      ]),
                    ),

                    // const NanumText(text: '최근 10회'),
                  ]),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              const SizedBox(
                child: Row(children: [
                  NanumTitleText(
                    text: "최근 주요 증상",
                    fontWeight: FontWeight.bold,
                  )
                ]),
              ),
              getRecentSymptoms(),
              // const NanumText(text: '최근 10회'),
            ]),
          ],
        ));
  }

  Widget getRecentSymptoms() {
    return const Text("test");
  }
}
