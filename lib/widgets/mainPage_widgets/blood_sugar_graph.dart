import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/textstyle.dart';

// ignore: must_be_immutable
class BloodSugarGraph extends StatelessWidget {
  BloodSugarGraph({super.key});
  late HomeProvider _homeProvider;

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    return Stack(
      children: <Widget>[
        _homeProvider.bloodSugarValue.isNotEmpty
            ? AspectRatio(
                aspectRatio: 1.5,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                    left: 0,
                    bottom: 5,
                    top: 50,
                  ),
                  child: Consumer<HomeProvider>(
                    builder: (context, homeProvider, child) => LineChart(
                      mainData(homeProvider,
                          _homeProvider.bloodSugarValue.length - 1),
                    ),
                  ),
                ),
              )
            : Container(
                padding: const EdgeInsets.only(bottom: 15),
                child: const Center(
                    child:
                        NanumTitleText(text: '데이터가 존재하지 않아요.\n데이터를 추가해주세요'))),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    List<String> dateData = _getDateData(_homeProvider.bloodSugarValue);
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    Widget? text;
    if (dateData.isNotEmpty) {
      for (int i = 0; i < dateData.length; i++) {
        if (value.toInt() <= i) {
          text = Text(dateData[i], style: style);
        } else {
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
    const style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 12,
    );
    String text;
    switch (value.toInt()) {
      case 0:
        text = '0';
        break;
      case 60:
        text = '60';
        break;
      case 120:
        text = '120';
        break;
      case 180:
        text = '180';
        break;
      default:
        return Container();
    }
    return Text(text, style: style, textAlign: TextAlign.left);
  }

  LineChartData mainData(homeProvider, count) {
    List<String> valueData = _getValueData(_homeProvider.bloodSugarValue);
    List<FlSpot> flspot = [];
    for (int i = 0; i < valueData.length; i++) {
      flspot.add(FlSpot(
          double.parse(i.toString()), double.parse(valueData[i].toString())));
    }
    int indexValue = homeProvider.bloodsugarCount == -1
        ? count
        : homeProvider.bloodsugarCount;

    final lineBarData = [
      LineChartBarData(
        showingIndicators: [indexValue],
        spots: flspot,
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
    ];

    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        horizontalInterval: 60,
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
            showTitles: true,
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
      maxX: 6,
      // _homeProvider.bloodSugarValue.length < 7
      //     ? double.parse((_homeProvider.bloodSugarValue.length - 1).toString())
      //     : 6,
      minY: 0,
      maxY: 180,
      lineBarsData: lineBarData,
      showingTooltipIndicators: [indexValue].map((index) {
        return ShowingTooltipIndicators([
          LineBarSpot(
            lineBarData[0],
            lineBarData.indexOf(lineBarData[0]),
            lineBarData[0].spots[index],
          ),
        ]);
      }).toList(),
      lineTouchData: LineTouchData(
        handleBuiltInTouches: false,
        getTouchLineEnd: (barData, spotIndex) {
          return 180;
        },
        touchCallback: (FlTouchEvent event, LineTouchResponse? lineTouch) {
          if (lineTouch != null && lineTouch.lineBarSpots != null) {
            homeProvider
                .updateCurrentSugarValue(lineTouch.lineBarSpots![0].spotIndex);
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
                  const TextSpan(
                    text: '혈당',
                    style: TextStyle(
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
                    text: 'mg/dL',
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
                  strokeWidth: 3,
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
  if (dateData.length < 7) {
    for (int i = 0; i < dateData.length; i++) {
      listData.add(dateData[i].DateTime_Md);
    }
  } else if (dateData.length >= 7) {
    for (int i = dateData.length - 7; i < dateData.length; i++) {
      listData.add(dateData[i].DateTime_Md);
    }
  }
  return listData;
}

List<String> _getValueData(valueData) {
  List<String> listData = [];
  if (valueData.length < 7) {
    for (int i = 0; i < valueData.length; i++) {
      listData.add(valueData[i].bloodsugar);
    }
  } else if (valueData.length >= 7) {
    for (int i = valueData.length - 7; i < valueData.length; i++) {
      listData.add(valueData[i].bloodsugar);
    }
  }
  return listData;
}
