import 'package:flutter/material.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart';
import 'package:timelines/timelines.dart';

class BloodSugarRecorde extends StatelessWidget {
  const BloodSugarRecorde({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppTheme.detailpadding,
      width: double.infinity,
      decoration: const BoxDecoration(color: CommonColor.widgetbackgroud),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.only(bottom: 20, top: 10),
          child: NanumTitleText(text: '혈당 기록'),
        ),
        Container(
          height: 700,
          child: Timeline.tileBuilder(
            physics: const NeverScrollableScrollPhysics(), //스크롤 막기
            theme: TimelineThemeData(
              color: Color.fromARGB(118, 158, 158, 158),
              nodePosition: 0,
            ),
            builder: TimelineTileBuilder.connected(
              contentsAlign: ContentsAlign.basic,
              contentsBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('$index'),
                      Text('asdf'),
                    ]),
              ),
              indicatorBuilder: (context, index) {
                return const OutlinedDotIndicator();
              },
              connectorBuilder: (context, index, type) {
                return const SolidLineConnector();
              },
              itemCount: 8,
            ),
          ),
        ),
      ]),
    );
  }
}
