// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';
import 'dart:convert';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:http/http.dart' as http;
// import 'package:super_medic/widgets/calender_widgets/itemClass.dart';

class CalendarData extends ChangeNotifier {
  // ignore: prefer_final_fields
  LinkedHashMap<DateTime, List<List<Check>>> _kevents =
      LinkedHashMap<DateTime, List<List<Check>>>();
  LinkedHashMap<DateTime, List<List<Check>>> get kevents => _kevents;

  Future<void> fetchPastGet() async {
    late int today;
    Map dayToint = {
      "일": 0,
      "월": 1,
      "화": 2,
      "수": 3,
      "목": 4,
      "금": 5,
      "토": 6,
    };
    today = dayToint[DateFormat.E('ko_KR').format(DateTime.now())];
    const storage = FlutterSecureStorage();
    String? userEmail;
    String? val = await storage.read(key: 'LoginUser');
    if (val != null) {
      userEmail = LoginModel.fromJson(jsonDecode(val)).email;
    }
    final res = await http.get(
        Uri.parse('https://mypd.kr:5000/medicine/parse/past?email=$userEmail'));
    Map<DateTime, List<List<Check>>> checkMap = <DateTime, List<List<Check>>>{};
    if (res.body != 'Empty') {
      for (var data in json.decode(res.body)) {
        final year = data['date'].substring(0, 4);
        final month = data['date'].substring(5, 7);
        final day = data['date'].substring(8, 10);
        List<List<Check>> medicineData = List.empty(growable: true);
        final keys = data['takeinfo'].keys.toList();
        data['takeinfo'].forEach((key, value) {
          List<Check> checks = List.empty(growable: true);
          for (var i = 0; i < value.length; i++) {
            checks.add(Check(
                id: 0,
                medicine: key,
                time: value[i]['time'],
                isChecked: value[i]['check']));
          }
          medicineData.add(checks);
        });
        checkMap[DateTime.utc(
                int.parse('$year'), int.parse('$month'), int.parse('$day'))] =
            medicineData;
      }
    }
    // // 오늘
    final response = await http.get(Uri.parse(
        'https://mypd.kr:5000/medicine/parse/current?email=$userEmail'));
    if (response.body != 'Empty') {
      List<List<Check>> medicineData = List.empty(growable: true);

      for (var data in json.decode(response.body)) {
        if (data['days'].contains(today)) {
          List<Check> checks = List.empty(growable: true);
          for (var time in data['times']) {
            checks.add(Check(
                id: data['id'],
                medicine: data['medicine_name'],
                time: time['time'],
                isChecked: time['check']));
          }
          medicineData.add(checks);
        }
        checkMap[DateTime.utc(DateTime.now().year, DateTime.now().month,
            DateTime.now().day)] = medicineData;
      }
    }

    _kevents = LinkedHashMap<DateTime, List<List<Check>>>(
      equals: isSameDay,
      hashCode: getHashCode,
    )..addAll(checkMap);
    // print(_kevents);
    _kevents = kevents;
    notifyListeners();
  }
}

/// Example event class.

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
