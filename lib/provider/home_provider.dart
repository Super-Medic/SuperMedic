import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_pressure.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_sugar.dart';
import 'package:super_medic/widgets/mainPage_widgets/medication_time.dart';
import 'package:super_medic/widgets/mainPage_widgets/note.dart';
import 'package:super_medic/widgets/mainPage_widgets/symptom.dart';

// ChangeNotifier 상속 받이 상태 관리
// BottomNavigation을 구동
class HomeProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();
  List<BloodSugarModel> _bloodSugarValue = [];
  List<BloodPressureModel> _bloodPressureValue = [];
  List<SymptomModel> _symptomsValue = [];
  List<NoteTextModel> _noteTextValue = [];
  List<Widget> _homeItems = [];
  List<String> _homeIndex = [];
  ScreeningModel? _screeningValue;
  MedicineModel? _medicineValue;
  DiagnosisModel? _diagnosisValue;
  LoginModel? _loginValue;
  
  

  List<BloodPressureModel> get bloodPressureValue => _bloodPressureValue;
  List<BloodSugarModel> get bloodSugarValue => _bloodSugarValue;
  List<SymptomModel> get symptomsValue => _symptomsValue;
  List<NoteTextModel> get noteTextValue => _noteTextValue;
  List<Widget> get homeItems => _homeItems;
  List<String> get homeIndex => _homeIndex;
  ScreeningModel? get screeningValue => _screeningValue;
  MedicineModel? get medicineValue => _medicineValue;
  DiagnosisModel? get diagnosisValue => _diagnosisValue;
  LoginModel? get loginValue => _loginValue;
  

  int _bloodpressureCount = -1;
  int get bloodpressureCount => _bloodpressureCount;

  int _bloodsugarCount = -1;
  int get bloodsugarCount => _bloodsugarCount;

  int _bloodsugarCountAfter = -1;
  int get bloodsugarCountAfter => _bloodsugarCountAfter;

  Future<void> homeItemsGet() async {
    _homeItems = [];
    try {
      String? homeIndexKeyValue = await storage.read(key: 'HomeIndex');
      if (homeIndexKeyValue == null) {
        await storage.write(
            key: 'HomeIndex',
            value:
                '[MedicationTime, BloodSugar, BloodPressure, Symptom, Note]');
        homeIndexKeyValue = await storage.read(key: 'HomeIndex');
      }
      if (homeIndexKeyValue != null) {
        _homeIndex = homeIndexKeyValue
            .substring(1, homeIndexKeyValue.length - 1)
            .split(', ');
        _homeItems = List.generate(homeIndex.length, (i) {
          switch (homeIndex[i]) {
            case 'MedicationTime': return const MedicationTime();
            case 'BloodSugar': return const BloodSugar();
            case 'BloodPressure': return const BloodPressure();
            case 'Symptom': return const Symptom();
            case 'Note': return const Note();
            default: return Container();
          }
        });
        _homeIndex = homeIndex;
        _homeItems = homeItems;
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

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
        _bloodsugarCountAfter = -1;
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
    _symptomsValue = _symptomsValue.reversed.toList();

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

  updateCurrentSugarAfterValue(int index) {
    _bloodsugarCountAfter = index;
    notifyListeners();
  }
}
