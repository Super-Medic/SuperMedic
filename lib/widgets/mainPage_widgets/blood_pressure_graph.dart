import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/textstyle.dart';

// ignore: must_be_immutable
class BloodPressureGraph extends StatelessWidget {
  BloodPressureGraph({super.key});
  late HomeProvider _homeProvider;

  // late int indexValue;
  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    const style = TextStyle(
      fontFamily: "NotoSansKR",
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    return Stack(
      children: <Widget>[
        _homeProvider.bloodPressureValue.isNotEmpty
            ? Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.ideographic,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(
                          right: 0,
                          left: 0,
                          bottom: 0,
                          top: 54,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('300',
                                style: style, textAlign: TextAlign.left),
                            SizedBox(
                              height: screenHeight * 0.0558,
                            ),
                            const Text('200',
                                style: style, textAlign: TextAlign.left),
                            SizedBox(
                              height: screenHeight * 0.0558,
                            ),
                            const Text('100',
                                style: style, textAlign: TextAlign.left),
                            SizedBox(
                              height: screenHeight * 0.0558,
                            ),
                            const Text('0',
                                style: style, textAlign: TextAlign.left),
                          ],
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          padding: const EdgeInsets.only(
                            right: 10,
                            left: 12,
                            bottom: 5,
                            top: 60,
                          ),
                          width: _homeProvider.bloodPressureValue.length <= 7
                              ? screenWidth * 0.138 * 6
                              : _homeProvider.bloodPressureValue.length > 30
                                  ? screenWidth * 0.138 * 29
                                  : screenWidth *
                                      0.138 *
                                      (_homeProvider.bloodPressureValue.length -
                                          1),
                          height: screenHeight * 0.33,
                          child: Consumer<HomeProvider>(
                            builder: (context, homeProvider, child) =>
                                LineChart(
                              mainData(homeProvider,
                                  _homeProvider.bloodPressureValue.length - 1),
                            ),
                          ),
                        ),
                      ))
                    ]),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset(
                      'assets/images/test.png',
                      width: 70,
                    ),
                  ],
                )
              ])
            : Container(
                padding: const EdgeInsets.only(bottom: 15),
                child: const Center(
                    child: NanumBodyText(
                  text: '오늘의 혈압을 기록해보세요!',
                  color: Colors.grey,
                ))),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    List<String> dateData = _getDateData(_homeProvider.bloodPressureValue);
    const style = TextStyle(
      fontFamily: "NotoSansKR",
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    Widget? text;
    if (dateData.isNotEmpty) {
      for (int i = 0; i < dateData.length; i++) {
        if (value.toInt() == i) {
          text = Text(dateData[i], style: style);
        } else if (value.toInt() > i) {
          text = const Text('', style: style);
        }
      }
    } else {
      text = const Text('', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: text!,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 100:
        text = '100';
        break;
      case 200:
        text = '200';
        break;
      case 300:
        text = '300';
        break;
      default:
        return Container();
    }
    return Text(text, style: const TextStyle(fontFamily: "NotoSansKR"));
  }

  LineChartData mainData(homeProvider, count) {
    List<BloodPressure_MaxMin> valueData =
        _getValueData(homeProvider.bloodPressureValue);
    List<FlSpot> flspotMax = [];
    List<FlSpot> flspotMin = [];
    for (int i = 0; i < valueData.length; i++) {
      flspotMax.add(FlSpot(double.parse(i.toString()),
          double.parse((valueData[i].maxValue).toString())));
      flspotMin.add(FlSpot(double.parse(i.toString()),
          double.parse((valueData[i].minValue).toString())));
    }
    int indexValue = homeProvider.bloodpressureCount == -1
        ? count > 29
            ? 29
            : count
        : homeProvider.bloodpressureCount;

    final lineBarsData = [
      LineChartBarData(
        showingIndicators: [indexValue],
        spots: flspotMax,
        isCurved: false,
        color: Colors.green,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            color: Colors.green,
            //radius: 4,
            strokeWidth: 0,
          ),
        ),
        belowBarData: BarAreaData(
          show: false,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color.fromARGB(75, 76, 175, 79),
              Color.fromARGB(0, 76, 175, 79),
            ],
          ),
        ),
      ),
      LineChartBarData(
        spots: flspotMin,
        isCurved: false,
        color: Colors.orange,
        barWidth: 2,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
            color: Colors.orange,
            //radius: 4,
            strokeWidth: 0,
          ),
        ),
        belowBarData: BarAreaData(
          show: false,
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              Color.fromARGB(75, 255, 153, 0),
              Color.fromARGB(0, 255, 153, 0),
            ],
          ),
        ),
      ),
    ];

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 100,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: const Color.fromARGB(116, 158, 158, 158),
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: const Color.fromARGB(0, 255, 255, 255),
            strokeWidth: 0,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
            reservedSize: 30,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 30,
          ),
        ),
      ),
      borderData: FlBorderData(
          show: true,
          border: const Border(
              bottom: BorderSide(
                  color: Color.fromARGB(116, 158, 158, 158), width: 0.5),
              top: BorderSide(
                  color: Color.fromARGB(116, 158, 158, 158), width: 0.5))),
      clipData: FlClipData.none(),
      minX: 0,
      maxX: count <= 6
          ? 6
          : count >= 29
              ? 29
              : double.parse((count).toString()),
      minY: 0,
      maxY: 300,
      lineBarsData: lineBarsData,
      showingTooltipIndicators: [indexValue].map((index) {
        return ShowingTooltipIndicators([
          LineBarSpot(
            lineBarsData[0],
            lineBarsData.indexOf(lineBarsData[0]),
            lineBarsData[0].spots[index],
          ),
          LineBarSpot(
            lineBarsData[1],
            lineBarsData.indexOf(lineBarsData[1]),
            lineBarsData[1].spots[index],
          ),
        ]);
      }).toList(),
      lineTouchData: LineTouchData(
        handleBuiltInTouches: false,
        getTouchLineEnd: (barData, spotIndex) {
          return 300;
        },
        touchCallback: (FlTouchEvent event, LineTouchResponse? lineTouch) {
          if (lineTouch != null && lineTouch.lineBarSpots != null) {
            homeProvider.updateCurrentPressureValue(
                lineTouch.lineBarSpots![0].spotIndex);
          }
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
          showOnTopOfTheChartBoxArea: true,
          tooltipRoundedRadius: 15,
          fitInsideHorizontally: true,
          tooltipMargin: 0,
          tooltipBorder: const BorderSide(
              color: Color.fromARGB(143, 158, 158, 158),
              width: 1,
              style: BorderStyle.solid,
              strokeAlign: -0.5),
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;
              return LineTooltipItem(
                "",
                const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(
                    text: touchedBarSpots[0] == flSpot ? '최고' : '최저',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  TextSpan(
                    text: '  ${flSpot.y.floor()}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const TextSpan(
                    text: 'mmHg',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
                textAlign: TextAlign.left,
              );
            }).toList();
          },
        ),
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((index) {
            return TouchedSpotIndicatorData(
              FlLine(
                  color: const Color.fromARGB(142, 158, 158, 158),
                  strokeWidth: 1.5,
                  dashArray: [1]),
              FlDotData(
                show: false,
              ),
            );
          }).toList();
        },
      ),
    );
  }
}

List<String> _getDateData(dateData) {
  List<String> listData = [];
  if (dateData.length < 30) {
    for (int i = 0; i < dateData.length; i++) {
      listData.add(dateData[i].DateTime_Md);
    }
  } else if (dateData.length >= 30) {
    for (int i = dateData.length - 30; i < dateData.length; i++) {
      listData.add(dateData[i].DateTime_Md);
    }
  }
  // print(listData);
  return listData;
}

List<BloodPressure_MaxMin> _getValueData(valueData) {
  List<BloodPressure_MaxMin> listData = [];
  if (valueData.length < 30) {
    for (int i = 0; i < valueData.length; i++) {
      listData.add(BloodPressure_MaxMin(
          valueData[i].maxbloodPressure, valueData[i].minbloodPressure));
    }
  } else if (valueData.length >= 30) {
    for (int i = valueData.length - 30; i < valueData.length; i++) {
      listData.add(BloodPressure_MaxMin(
          valueData[i].maxbloodPressure, valueData[i].minbloodPressure));
    }
  }
  return listData;
}

class BloodPressure_MaxMin {
  final String maxValue;
  final String minValue;

  BloodPressure_MaxMin(this.maxValue, this.minValue);
}
