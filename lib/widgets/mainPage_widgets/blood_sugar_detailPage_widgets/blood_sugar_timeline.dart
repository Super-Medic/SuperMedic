import 'package:flutter/material.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart';
import 'package:timelines/timelines.dart';

// ignore: must_be_immutable
class BloodSugarTimeline extends StatelessWidget {
  const BloodSugarTimeline({super.key, required this.timeLineValue});
  final timeLineValue;

  @override
  Widget build(BuildContext context) {
    final data = _sugardata(timeLineValue);
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(color: CommonColor.widgetbackgroud),
      child: Center(
        child: timeLineValue.isEmpty
            ? Container(
                padding: const EdgeInsets.only(bottom: 20),
                child: const NanumBodyText(text: '오늘의 혈당을 기록해보세요!'))
            : Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _DeliveryProcesses(processes: data.deliveryProcesses),
                ],
              ),
      ),
    );
  }
}

class _DeliveryProcesses extends StatelessWidget {
  const _DeliveryProcesses({Key? key, required this.processes})
      : super(key: key);

  final List<_DeliveryProcess> processes;
  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(
        color: Color(0xff9b9b9b),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0), //timeline padding
        child: FixedTimeline.tileBuilder(
          theme: TimelineThemeData(
            nodePosition: 0.0,
            color: const Color.fromARGB(112, 152, 152, 152),
            //원 디자인
            // indicatorTheme: const IndicatorThemeData(
            //   position: 0, //원 포지션
            //   size: 15.0, //원 사이즈
            // ),
            //선 디자인
            // connectorTheme: const ConnectorThemeData(
            //   thickness: 2.5, //선 두께
            // ),
          ),
          builder: TimelineTileBuilder.connected(
            itemCount: processes.length,

            //원 옆에 글씨 생성
            contentsBuilder: (_, index) {
              if (processes[index].isCompleted) return null;

              return Padding(
                padding: const EdgeInsets.only(left: 8.0), // 선과 Content 사이 간격
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    NanumBodyText(
                      text: processes[index].name,
                      //style: DefaultTextStyle.of(context).style.copyWith(
                      fontSize: 14.0,
                      color: Colors.grey,
                    ),
                    //),
                    _InnerTimeline(messages: processes[index].messages),
                  ],
                ),
              );
            },

            //원 생성
            indicatorBuilder: (_, index) {
              if (processes[index].isCompleted) return null;
              return const OutlinedDotIndicator(borderWidth: 2.5, position: 0);
            },

            //선 생성
            connectorBuilder: (_, index, ___) => const SolidLineConnector(
              color: Color.fromARGB(112, 152, 152, 152),
            ),
          ),
        ),
      ),
    );
  }
}

//Timeline 사이 글작성
class _InnerTimeline extends StatelessWidget {
  const _InnerTimeline({
    required this.messages,
  });

  final List<_DeliveryMessageSugar> messages;

  @override
  Widget build(BuildContext context) {
    bool isEdgeIndex(int index) {
      return index == 0 || index == messages.length + 1;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: FixedTimeline.tileBuilder(
        theme: TimelineTheme.of(context).copyWith(
          indicatorTheme: TimelineTheme.of(context).indicatorTheme.copyWith(
                size: 0.0,
                position: 0.5,
              ),
        ),
        builder: TimelineTileBuilder(
          contentsBuilder: (_, index) {
            if (isEdgeIndex(index)) {
              return null;
            }
            return Column(children: [
              messages[index - 1].towidget()
            ]); //Row(children: [Text(messages[index - 1].toString())]);
          },
          itemExtentBuilder: (_, index) =>
              isEdgeIndex(index) ? 10.0 : 80.0, //아이템 유무에 따라 선 길이 설정
          itemCount: messages.length + 1,
        ),
      ),
    );
  }
}

// ignore: prefer_const_constructors
_sugardata(final timeLineValue) {
  final List<String> name = [];
  final List<_DeliveryProcess> deliveryProcesses = [];
  final List<_DeliveryMessageSugar> deliveryMessage = [];
  int count = -1;

  // print(timeLineValue is List<BloodSugarModel>);
  if (timeLineValue.isNotEmpty) {
    for (int i = timeLineValue.length - 1; i >= 0; i--) {
      if (i == timeLineValue.length - 1) {
        name.add(timeLineValue[i].DateTime);
      } else if (timeLineValue[i].DateTime != timeLineValue[i + 1].DateTime) {
        name.add(timeLineValue[i].DateTime);
      }
    }
    var twoDList = List.generate(name.length, (_) => [...deliveryMessage]);
    for (int i = 0; i < timeLineValue.length; i++) {
      if (i == 0) {
        count += 1;
        twoDList[count].add(_DeliveryMessageSugar(timeLineValue[i].DateTime_hm,
            timeLineValue[i].checkbutton, timeLineValue[i].bloodsugar));
      } else if (timeLineValue[i].DateTime != timeLineValue[i - 1].DateTime) {
        count += 1;
        twoDList[count].add(_DeliveryMessageSugar(timeLineValue[i].DateTime_hm,
            timeLineValue[i].checkbutton, timeLineValue[i].bloodsugar));
      } else {
        twoDList[count].add(_DeliveryMessageSugar(timeLineValue[i].DateTime_hm,
            timeLineValue[i].checkbutton, timeLineValue[i].bloodsugar));
      }
    }
    for (int i = 0; i < name.length; i++) {
      deliveryProcesses.add(
          _DeliveryProcess(name[i], messages: twoDList[name.length - i - 1]));
    }
    deliveryProcesses.add(const _DeliveryProcess.complete());
  }
  //  else {
  //   // print("여기");
  // }

  return _OrderInfo(deliveryProcesses: deliveryProcesses);
}

class _OrderInfo {
  const _OrderInfo({
    required this.deliveryProcesses,
  });

  final List<_DeliveryProcess> deliveryProcesses;
}

class _DeliveryProcess {
  const _DeliveryProcess(
    this.name, {
    this.messages = const [],
  });

  const _DeliveryProcess.complete()
      : name = 'Done',
        messages = const [];

  final String name;
  final List<_DeliveryMessageSugar> messages;

  bool get isCompleted => name == 'Done';
}

//가운데 삽입할 문제 객체 생성
class _DeliveryMessageSugar {
  const _DeliveryMessageSugar(this.timeNow, this.checkbutton, this.bloodsugar);

  final String timeNow; // final DateTime createdAt;
  final String checkbutton;
  final String bloodsugar;

  Widget towidget() {
    return Container(
      padding: AppTheme.widgetpadding,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Center(
          child: NanumBodyText(
            text: timeNow,
            fontSize: 20,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                children: [
                  NanumText(text: checkbutton),
                  const NanumText(
                    text: "  ",
                  ),
                  NanumTitleText(text: bloodsugar),
                  const NanumText(text: 'mg/dL'),
                ],
              ),
            ),
          ],
        )
      ]),
    );
  }
}
