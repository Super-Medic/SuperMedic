// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:super_medic/widgets/calender_widgets/medicineCheck.dart';

import './utils.dart';

class TableEventsExample extends StatefulWidget {
  const TableEventsExample({super.key});

  @override
  _TableEventsExampleState createState() => _TableEventsExampleState();
}

class _TableEventsExampleState extends State<TableEventsExample> {
  late final ValueNotifier<List<Check>> _selectedEvents;
  CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.utc(
      DateTime.now().year, DateTime.now().month, DateTime.now().day);
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  CalendarData calData = CalendarData();

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<CalendarData>(context, listen: false).fetchPastGet();
    });
    setState(() {
      _selectedDay = _focusedDay;
      _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    });
    print(_focusedDay);
    print(_getEventsForDay(_focusedDay));
  }

  @override
  void dispose() {
    super.dispose();
    _selectedEvents.dispose();
  }

  List<Check> _getEventsForDay(DateTime day) {
    return calData.kevents[day] ?? [];
  }

  List<Check> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  @override
  Widget build(BuildContext context) {
    calData = context.watch<CalendarData>();
    return Scaffold(
      backgroundColor: CommonColor.background,
      body: Column(
        children: [
          TableCalendar<Check>(
            locale: 'ko_KR',
            firstDay: DateTime.utc(2010, 10, 16),
            lastDay: DateTime.utc(2030, 3, 14),
            focusedDay: _focusedDay,
            headerStyle: HeaderStyle(
                headerMargin: const EdgeInsets.only(left: 20, top: 5),
                titleTextFormatter: (date, locale) =>
                    DateFormat('y년 M월', locale).format(date),
                titleCentered: false,
                leftChevronVisible: false,
                rightChevronVisible: false,
                formatButtonVisible: false,
                titleTextStyle: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                )),
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            rangeStartDay: _rangeStart,
            rangeEndDay: _rangeEnd,
            calendarFormat: _calendarFormat,
            rangeSelectionMode: _rangeSelectionMode,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.sunday,
            rowHeight: 60, // 체크 박스 키우기
            daysOfWeekHeight: 40,
            pageJumpingEnabled: true,
            weekendDays: const [DateTime.sunday],
            daysOfWeekStyle: const DaysOfWeekStyle(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color.fromARGB(255, 189, 189, 189),
                    width: 0.5,
                  ),
                ),
              ),
              weekendStyle: TextStyle(
                color: Colors.red,
              ),
            ),
            calendarStyle: CalendarStyle(
              cellPadding: const EdgeInsets.only(top: 5), // 날짜 위쪽 패딩
              cellAlignment: Alignment.topCenter, // 날짜 위쪽 정렬
              markerMargin: const EdgeInsets.only(top: 10),
              markerDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              todayDecoration: BoxDecoration(
                color: Colors.green[300],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              selectedTextStyle: const TextStyle(
                color: Colors.black,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              rangeStartDecoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              rangeEndDecoration: BoxDecoration(
                color: Colors.green[300],
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              rangeHighlightColor: const Color.fromARGB(255, 188, 231, 192),
              defaultDecoration: BoxDecoration(
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(10),
              ),
              weekendTextStyle: const TextStyle(color: Colors.red),
            ),
            calendarBuilders:
                CalendarBuilders(markerBuilder: (context, day, events) {
              final takeCheck = checkTake(events);
              if (events.isNotEmpty) {
                // ignore: unrelated_type_equality_checks
                if (takeCheck == 0) {
                  return TakeImage(image: 'assets/images/warnming.png');
                  // ignore: unrelated_type_equality_checks
                } else if (takeCheck == 1) {
                  return TakeImage(image: 'assets/images/x icon.png');
                  // ignore: unrelated_type_equality_checks
                } else if (takeCheck == 2) {
                  return TakeImage(image: 'assets/images/check.png');
                }
              }
              return null;
            }),
            onDaySelected: _onDaySelected,
            onRangeSelected: _onRangeSelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          const SizedBox(height: 8.0),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.7),
                    blurRadius: 20.0,
                    spreadRadius: 0.0,
                    offset: const Offset(0, 7),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 30.0,
                      // vertical: 4.0,
                    ),
                    padding: const EdgeInsets.only(top: 40),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    child: NanumTitleText(
                      text:
                          DateFormat('M월 d일 EEEE', 'ko_KR').format(_focusedDay),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: ValueListenableBuilder<List<Check>>(
                      valueListenable: _selectedEvents,
                      builder: (context, value, _) {
                        // print(_selectedDay);
                        return ListView.builder(
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12.0,
                                vertical: 4.0,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              child: ListTile(
                                onTap: () {},
                                title: MediCheck(items: {true: value}, pad: 20),
                                // title: Text("abcd")),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  bool _isWeekend(
    DateTime day, {
    List<int> weekendDays = const [DateTime.saturday, DateTime.sunday],
  }) {
    return weekendDays.contains(day.weekday);
  }
}

checkTake(List<Check> events) {
  bool isContainTrue = false;
  bool isContainFalse = false;
  for (var element in events) {
    if (element.isChecked == false) {
      isContainFalse = true;
    } else if (element.isChecked) {
      isContainTrue = true;
    }
    if (isContainFalse && isContainTrue) break;
  }

  if (isContainFalse && isContainTrue) {
    return 0; //세모
  } else if (!isContainTrue) {
    return 1; // 엑스
  } else if (!isContainFalse) {
    return 2; // 체크
  } else {
    return 3;
  }
}

class TakeImage extends StatelessWidget {
  String image;
  TakeImage({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10), // marker buttom padding
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 15,
        height: 15,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(image),
          ),
        ),
      ),
    );
  }
}
