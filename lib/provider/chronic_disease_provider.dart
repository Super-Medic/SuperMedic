// import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class ChronicDiseaseProvider with ChangeNotifier {
  // final bool diabetes; // 당뇨
  // final bool hypertension; // 고혈압
  // final bool hyperlipidemia; // 고지혈증
  // final bool hip_arthritis; // 고관절염
  // final bool back_pain; // 요통
  // final bool osteoporosis; // 골다공증
  // final bool cataract; // 백내장
  // final bool heart_disease; // 심장질환
  // final bool asthma; // 천식
  // final bool myocardial_infarction; // 심근경색증
  // final bool stroke; // 뇌졸중
  // final bool enlarged_prostate; // 전립선비대증

  // ChronicDiseaseProvider(
  //     {required this.diabetes,
  //     required this.hypertension,
  //     required this.hyperlipidemia,
  //     required this.hip_arthritis,
  //     required this.back_pain,
  //     required this.osteoporosis,
  //     required this.cataract,
  //     required this.heart_disease,
  //     required this.asthma,
  //     required this.myocardial_infarction,
  //     required this.stroke,
  //     required this.enlarged_prostate});
  
  bool _diabetes = false; // 당뇨
  bool get diabetes => _diabetes;

  bool _hypertension = false; // 고혈압
  bool get hypertension => _hypertension;

  bool _hyperlipidemia = false; // 고지혈증
  bool get hyperlipidemia => _hyperlipidemia;

  bool _hip_arthritis = false; // 고관절염
  bool get hip_arthritis => _hip_arthritis;

  bool _back_pain = false; // 요통
  bool get back_pain => _back_pain;

  bool _osteoporosis = false; // 골다공증
  bool get osteoporosis => _osteoporosis;

  bool _cataract = false; // 백내장
  bool get cataract => _cataract;

  bool _heart_disease = false; // 심장질환
  bool get heart_disease => _heart_disease;

  bool _asthma = false; // 천식
  bool get asthma => _asthma;

  bool _myocardial_infarction = false; // 심근경색증
  bool get myocardial_infarction => _myocardial_infarction;

  bool _stroke = false; // 뇌졸중
  bool get stroke => _stroke;

  bool _enlarged_prostate = false; // 전립선비대증
  bool get enlarged_prostate => _enlarged_prostate;


  void set1(bool diabetes) {
    _diabetes = diabetes;
    notifyListeners();
  }

  void set2(bool hypertension) {
    _hypertension = hypertension;
    notifyListeners();
  }

  void set3(bool hyperlipidemia) {
    _hyperlipidemia = hyperlipidemia;
    notifyListeners();
  }

  void set4(bool hip_arthritis) {
    _hip_arthritis = hip_arthritis;
    notifyListeners();
  }

  void set5(bool back_pain) {
    _back_pain = back_pain;
    notifyListeners();
  }

  void set6(bool osteoporosis) {
    _osteoporosis = osteoporosis;
    notifyListeners();
  }

  void set7(bool cataract) {
    _cataract = cataract;
    notifyListeners();
  }

  void set8(bool heart_disease) {
    _heart_disease = heart_disease;
    notifyListeners();
  }

  void set9(bool asthma) {
    _asthma = asthma;
    notifyListeners();
  }

  void set10(bool myocardial_infarction) {
    _myocardial_infarction = myocardial_infarction;
    notifyListeners();
  }

  void set11(bool stroke) {
    _stroke = stroke;
    notifyListeners();
  }

  void set12(bool enlarged_prostate) {
    _enlarged_prostate = enlarged_prostate;
    notifyListeners();
    // }
  }
}
