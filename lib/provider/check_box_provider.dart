import 'package:flutter/material.dart';

class CheckBoxProvider with ChangeNotifier {
  bool _medicine = false;
  bool get medicine => _medicine; //내과
  bool _surgery = false;
  bool get surgery => _surgery; //외과
  bool _obstetrics = false;
  bool get obstetrics => _obstetrics; //산부인과
  bool _neurosurgery = false;
  bool get neurosurgery => _neurosurgery; //신경외과
  bool _orthopedics = false;
  bool get orthopedics => _orthopedics; //정형외과
  bool _otorhinolaryngology = false;
  bool get otorhinolaryngology => _otorhinolaryngology; //이비인후과
  bool _ophthalmology = false;
  bool get ophthalmology => _ophthalmology; //안과
  bool _plasticSurgery = false;
  bool get plasticSurgery => _plasticSurgery; //성형외과

  void set1(bool medicine) {
    _medicine = medicine;
    notifyListeners();
  }

  void set2(bool surgery) {
    _surgery = surgery;
    notifyListeners();
  }

  void set3(bool obstetrics) {
    _obstetrics = obstetrics;
    notifyListeners();
  }

  void set4(bool neurosurgery) {
    _neurosurgery = neurosurgery;
    notifyListeners();
  }

  void set5(bool orthopedics) {
    _orthopedics = orthopedics;
    notifyListeners();
  }

  void set6(bool otorhinolaryngology) {
    _otorhinolaryngology = otorhinolaryngology;
    notifyListeners();
  }

  void set7(bool ophthalmology) {
    _ophthalmology = ophthalmology;
    notifyListeners();
  }

  void set8(bool plasticSurgery) {
    _plasticSurgery = plasticSurgery;
    notifyListeners();
  }
}
