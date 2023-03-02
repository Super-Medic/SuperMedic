import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/model.dart';

// ChangeNotifier 상속 받이 상태 관리
// BottomNavigation을 구동
class HomeProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  List<BloodSugarModel> _bloodSugarValue = [];
  List<BloodPressureModel> _bloodPressureValue = [];
  List<NoteModel> _noteTextValue = [];

  List<BloodPressureModel> get bloodPressureValue => _bloodPressureValue;
  List<BloodSugarModel> get bloodSugarValue => _bloodSugarValue;
  List<NoteModel> get noteTextValue => _noteTextValue;

  int _bloodpressureCount = -1;
  int get bloodpressureCount => _bloodpressureCount;

  int _bloodsugarCount = -1;
  int get bloodsugarCount => _bloodsugarCount;

  Future<void> bloodSugargetData() async {
    _bloodSugarValue = [];
    try {
      String? bloodSugarKeyValue = await storage.read(key: 'BloodSugar');
      if (bloodSugarKeyValue != null) {
        final bloodSugarKeyList = bloodSugarKeyValue.split(',');
        for (int i = 0; i < bloodSugarKeyList.length; i++) {
          final val = await storage.read(key: bloodSugarKeyList[i]);
          if (val != null) {
            _bloodSugarValue.add(BloodSugarModel.fromJson(jsonDecode(val)));
          }
        }
        _bloodsugarCount = -1;
        _bloodSugarValue = bloodSugarValue;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> bloodPressuregetData() async {
    _bloodPressureValue = [];
    try {
      String? bloodPressureKeyValue = await storage.read(key: 'BloodPressure');
      if (bloodPressureKeyValue != null) {
        final bloodPressureKeyList = bloodPressureKeyValue.split(',');
        for (int i = 0; i < bloodPressureKeyList.length; i++) {
          final val = await storage.read(key: bloodPressureKeyList[i]);
          if (val != null) {
            _bloodPressureValue
                .add(BloodPressureModel.fromJson(jsonDecode(val)));
          }
        }
        _bloodpressureCount = -1;
        _bloodPressureValue = bloodPressureValue;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> noteTextgetData() async {
    _noteTextValue = [];
    try {
      String? noteTextKeyValue = await storage.read(key: 'NoteText');
      if (noteTextKeyValue != null) {
        final noteTextKeyList = noteTextKeyValue.split(',');
        for (int i = 0; i < noteTextKeyList.length; i++) {
          final val = await storage.read(key: noteTextKeyList[i]);
          if (val != null) {
            _noteTextValue.add(NoteModel.fromJson(jsonDecode(val)));
          }
        }
        _noteTextValue = noteTextValue;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  updateCurrentPressureValue(int index) {
    _bloodpressureCount = index;
    notifyListeners();
  }

  updateCurrentSugarValue(int index) {
    _bloodsugarCount = index;
    notifyListeners();
  }
}
