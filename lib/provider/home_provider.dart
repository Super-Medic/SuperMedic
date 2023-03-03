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
  List<SymptomModel> _symptomsValue = [];
  List<NoteTextModel> _noteTextValue = [];
  ScreeningModel? _screeningValue;
  MedicineModel? _medicineValue;
  DiagnosisModel? _diagnosisValue;
  LoginModel? _loginValue;

  List<BloodPressureModel> get bloodPressureValue => _bloodPressureValue;
  List<BloodSugarModel> get bloodSugarValue => _bloodSugarValue;
  List<SymptomModel> get symptomsValue => _symptomsValue;
  List<NoteTextModel> get noteTextValue => _noteTextValue;
  ScreeningModel? get screeningValue => _screeningValue;
  MedicineModel? get medicineValue => _medicineValue;
  DiagnosisModel? get diagnosisValue => _diagnosisValue;
  LoginModel? get loginValue => _loginValue;

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

  Future<void> symptomgetData() async {
    _symptomsValue = [];
    // try {
    dynamic symptoms = await storage.read(key: 'Symptoms');

    List<String> symptomBodyPartKeyValue = [];

    if (symptoms != null) {
      symptoms = jsonDecode(symptoms);
      List<String> symptomsDateKeyValue = symptoms.keys.toList();

      for (int i = 0; i < symptomsDateKeyValue.length; i++) {
        dynamic symptomTmp = [];
        symptomBodyPartKeyValue =
            symptoms[symptomsDateKeyValue[i]].keys.toList();
        for (int j = 0; j < symptomBodyPartKeyValue.length; j++) {
          symptomTmp = [
            symptomTmp,
            symptoms[symptomsDateKeyValue[i]][symptomBodyPartKeyValue[j]]
          ].expand((x) => x);
          symptomTmp = symptomTmp.toList();

          // symptomTmp.add(
          //     symptoms[symptomsDateKeyValue[i]][symptomBodyPartKeyValue[j]]);
        }

        _symptomsValue.add(SymptomModel(symptomsDateKeyValue[i], symptomTmp));
      }
    }

    notifyListeners();
    // } catch (e) {
    //   rethrow;
    // }
  }

  Future<void> noteTextgetData() async {
    _noteTextValue = [];
    try {
      dynamic noteText = await storage.read(key: 'Notes');

      if (noteText != null) {
        noteText = jsonDecode(noteText);

        List<String> noteTextKeyValue = noteText.keys.toList();
        for (int i = 0; i < noteTextKeyValue.length; i++) {
          _noteTextValue.add(NoteTextModel(
              noteTextKeyValue[i], noteText[noteTextKeyValue[i]]));
        }
      }
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> screeninggetData() async {
    dynamic screenings = await storage.read(key: 'Screenings');
    if (screenings != null) {
      _screeningValue = ScreeningModel.fromJson(jsonDecode(screenings));
    }
    notifyListeners();
  }

  Future<void> medicinegetData() async {
    dynamic medicine = await storage.read(key: 'Medicine');
    if (medicine != null) {
      _medicineValue = MedicineModel.fromJson(jsonDecode(medicine));
    }
    notifyListeners();
  }

  Future<void> diagnosisgetData() async {
    dynamic diagnosis = await storage.read(key: 'Diagnosis');
    if (diagnosis != null) {
      _diagnosisValue = DiagnosisModel.fromJson(jsonDecode(diagnosis));
    }
    notifyListeners();
  }

  Future<void> logingetData() async {
    dynamic login = await storage.read(key: 'LoginUser');
    if (login != null) {
      _loginValue = LoginModel.fromJson(jsonDecode(login));
    }
    notifyListeners();
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
