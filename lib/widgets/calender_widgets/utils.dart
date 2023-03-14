// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:super_medic/widgets/calender_widgets/calenderCheckBox.dart';
import 'package:http/http.dart' as http;
// import 'package:super_medic/widgets/calender_widgets/itemClass.dart';

/// Example event class.
class Event {
  final String title;
  // final CalCustomCheckBox checkBoxList;
  // const Event(this.title, this.checkBoxList);
  const Event(this.title);

  @override
  String toString() => title;
}

/// Example events.
///
/// Using a [LinkedHashMap] is highly recommended if you decide to use a map.
final kEvents = LinkedHashMap<DateTime, List<Event>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = Map.fromIterable(List.generate(50, (index) => index),
    key: (item) => DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5),
    value: (item) => List.generate(
        item % 4 + 1, (index) => Event('Event $item | ${index + 1}')))
  ..addAll({
    kToday: [
      Event('Today\'s Event 1'),
      Event('Today\'s Event 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// Returns a list of [DateTime] objects from [first] to [last], inclusive.
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
    (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month, kToday.day);

getData() async {
  String? userEmail;
  const storage = FlutterSecureStorage();
  String? val = await storage.read(key: 'LoginUser');
  if (val != null) {
    userEmail = LoginModel.fromJson(jsonDecode(val)).email;
  }
  final res = await http
      .get(Uri.parse('https://mypd.kr:5000/medicine/take?email=$userEmail'));
  List<List> temp = List.empty(growable: true);
  if (res.body != 'Empty') {
    // for (var data in json.decode(res.body)) {}
  }
}
