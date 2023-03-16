import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:timelines/timelines.dart';

// ignore: must_be_immutable
class SymptomsTimeline extends StatefulWidget {
  const SymptomsTimeline({super.key});

  @override
  State<SymptomsTimeline> createState() => _SymptomsTimelineState();
}

class _SymptomsTimelineState extends State<SymptomsTimeline> {
  late HomeProvider _homeProvider;

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return _homeProvider.symptomsValue.isEmpty == true
        ? Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(50),
            child: const NanumBodyText(text: "등록된 증상이 존재하지 않습니다."))
        : Padding(
            padding: EdgeInsets.fromLTRB(
                0.0, screenHeight * 0.01, 0.0, 0.0), //timeline padding
            child: FixedTimeline.tileBuilder(
              theme: TimelineThemeData(
                nodePosition: 0.0,
                color: const Color.fromARGB(112, 152, 152, 152),
              ),
              builder: TimelineTileBuilder.connected(
                itemCount: _homeProvider.symptomsValue.length,

                //원 옆에 글씨 생성
                contentsBuilder: (_, index) {
                  print(screenWidth);
                  return Padding(
                    padding: EdgeInsets.only(
                        left: screenWidth * 0.02), // 선과 Content 사이 간격
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              NanumBodyText(
                                text:
                                    _homeProvider.symptomsValue[index].DateTime,
                                //style: DefaultTextStyle.of(context).style.copyWith(
                                fontSize: 14.0, //14
                                color: Colors.grey,
                              ),
                              // SizedBox(width: screenWidth * 0.1),
                              Container(
                                // decoration:
                                //     const BoxDecoration(color: Colors.red),
                                alignment: const Alignment(0, 0),
                                width: screenWidth * 0.5,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Wrap(
                                    direction: Axis.horizontal,
                                    // alignment: WrapAlignment.start,
                                    spacing: screenWidth * 0.015,
                                    runSpacing: screenHeight * 0.005,

                                    alignment: WrapAlignment.end,
                                    children: List.generate(
                                      _homeProvider
                                          .symptomsValue[index].symptom.length,
                                      (symptomIndex) {
                                        return Container(
                                          alignment: const Alignment(0, 0),
                                          width: screenWidth * 0.15,
                                          height: screenHeight * 0.035,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[100],
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Text(
                                            _homeProvider.symptomsValue[index]
                                                .symptom[symptomIndex],
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                    color: const Color.fromRGBO(
                                                        96, 96, 96, 1),
                                                    fontSize: 11,
                                                    fontFamily: "NotoSansKRr",
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              )
                            ]),
                        //),
                        SizedBox(height: screenHeight * 0.05),
                      ],
                    ),
                  );
                },

                //원 생성
                indicatorBuilder: (_, index) {
                  // if (processes[index].isCompleted) return null;
                  return const OutlinedDotIndicator(
                      borderWidth: 2.5, position: 0);
                },

                //선 생성
                connectorBuilder: (_, index, ___) => const SolidLineConnector(
                  color: Color.fromARGB(112, 152, 152, 152),
                ),
              ),
            ),
          );
  }
}
