import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:http/http.dart' as http;

class MedicineTake extends ChangeNotifier {
  List<Map> _checkList = []; // 오늘 복약 O
  List<Map> _checkListForNotToday = []; // 오늘 복약 X
  double _inputHeight = 0;
  List<Map> get checkList => _checkList;
  List<Map> get checkListForNotToday => _checkListForNotToday;
  double get inputHeight => _inputHeight;

  String? userEmail;
  bool isLoading = false;
  DateTime now = DateTime.now();
  late int today = dayToint[DateFormat.E('ko_KR').format(now)];
  Map dayToint = {
    "일": 0,
    "월": 1,
    "화": 2,
    "수": 3,
    "목": 4,
    "금": 5,
    "토": 6,
  };
  Future<void> fetchGet() async {
    const storage = FlutterSecureStorage();
    String? val = await storage.read(key: 'LoginUser');
    if (val != null) {
      userEmail = LoginModel.fromJson(jsonDecode(val)).email;
    }
    final res = await http.get(Uri.parse(
        'https://mypd.kr:5000/medicine/parse/current?email=$userEmail'));
    List<Map> temp = List.empty(growable: true);
    List<Map> tempForNotToday = List.empty(growable: true);
    if (res.body != 'Empty') {
      for (var data in json.decode(res.body)) {
        if (data['days'].contains(today)) {
          Map<bool, List<Check>> checkMap = <bool, List<Check>>{};
          List<Check> checks = List.empty(growable: true);
          for (var time in data['times']) {
            checks.add(
              Check(
                id: data['id'],
                medicine: data['medicine_name'],
                time: time['time'],
                isChecked: time['check'],
              ),
            );
          }
          checkMap[true] = checks;
          temp.add(checkMap);
        } else {
          Map<bool, List<Check>> checkMapForNotToday = <bool, List<Check>>{};
          List<Check> checksForNotToday = List.empty(growable: true);
          for (var time in data['times']) {
            checksForNotToday.add(
              Check(
                id: data['id'],
                medicine: data['medicine_name'],
                time: time['time'],
                isChecked: time['check'],
              ),
            );
          }
          checkMapForNotToday[true] = checksForNotToday;
          tempForNotToday.add(checkMapForNotToday);
        }
      }
      _checkList = temp;
      _checkListForNotToday = tempForNotToday;
      if (_checkList.isEmpty) {
        _inputHeight = 0;
      } else if (_checkList.length == 1) {
        _inputHeight = 0.25;
      } else {
        _inputHeight = 0.325;
      }
      notifyListeners();
    }
  }

  bool isEmpty() {
    return _checkList.isEmpty ? true : false;
  }
}
