import 'package:flutter/material.dart';

import '../themes/textstyle.dart';

class BloodSugarModel {
  final String DateTime;
  final String DateTime_hm;
  final String DateTime_Md;
  final String checkbutton;
  final String bloodsugar;

  BloodSugarModel(this.DateTime, this.DateTime_hm, this.DateTime_Md,
      this.checkbutton, this.bloodsugar);

  BloodSugarModel.fromJson(Map<String, dynamic> json)
      : DateTime = json['DateTime'],
        DateTime_hm = json['DateTime_hm'],
        DateTime_Md = json['DateTime_Md'],
        checkbutton = json['checkbutton'],
        bloodsugar = json['bloodsugar'];

  Map<String, dynamic> toJson() => {
        'DateTime': DateTime,
        'DateTime_hm': DateTime_hm,
        'DateTime_Md': DateTime_Md,
        'checkbutton': checkbutton,
        'bloodsugar': bloodsugar,
      };
}

class BloodPressureModel {
  final String DateTime;
  final String DateTime_hm;
  final String DateTime_Md;
  final String maxbloodPressure;
  final String minbloodPressure;
  final String pulse;

  BloodPressureModel(this.DateTime, this.DateTime_hm, this.DateTime_Md,
      this.maxbloodPressure, this.minbloodPressure, this.pulse);

  BloodPressureModel.fromJson(Map<String, dynamic> json)
      : DateTime = json['DateTime'],
        DateTime_hm = json['DateTime_hm'],
        DateTime_Md = json['DateTime_Md'],
        maxbloodPressure = json['maxbloodPressure'],
        minbloodPressure = json['minbloodPressure'],
        pulse = json['pulse'];

  Map<String, dynamic> toJson() => {
        'DateTime': DateTime,
        'DateTime_hm': DateTime_hm,
        'DateTime_Md': DateTime_Md,
        'maxbloodPressure': maxbloodPressure,
        'minbloodPressure': minbloodPressure,
        'pulse': pulse,
      };
}

class SymptomModel {
  final String DateTime;
  final List<dynamic> symptom;

  SymptomModel(this.DateTime, this.symptom);

  SymptomModel.fromJson(Map<String, dynamic> json)
      : DateTime = json['DateTime'],
        symptom = json['symptom'];

  Map<String, dynamic> toJson() => {
        'DateTime': DateTime,
        'symptom': symptom,
      };
}

class NoteTextModel {
  final String DateTime;
  final String note;

  NoteTextModel(this.DateTime, this.note);

  NoteTextModel.fromJson(Map<String, dynamic> json)
      : DateTime = json['DateTime'],
        note = json['note'];

  Map<String, dynamic> toJson() => {
        'DateTime': DateTime,
        'note': note,
      };
}

class ScreeningModel {
  List<ScreeningList>? screeningList;

  ScreeningModel({this.screeningList});

  ScreeningModel.fromJson(Map<String, dynamic> json) {
    if (json['screeningList'] != null) {
      screeningList = <ScreeningList>[];
      json['screeningList'].forEach((v) {
        screeningList!.add(ScreeningList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (screeningList != null) {
      data['screeningList'] = screeningList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ScreeningList {
  String? year;
  String? result;
  String? chkAgency;
  String? opinion;
  String? screeningDate;
  String? kidney;
  String? weight;
  String? waist;
  String? BMI;
  String? vision;
  String? hearing;
  String? bloodPressure;
  String? proteinuria;
  String? hemoglobin;
  String? FBG;
  String? cholesterol;
  String? HDL;
  String? triglycerides;
  String? LDL;
  String? serumCreatinine;
  String? GFR;
  String? SGOT;
  String? SGPT;
  String? y_GTP;
  String? tuberculosis;
  String? osteoporosis;

  ScreeningList(
      {this.year,
      this.result,
      this.chkAgency,
      this.opinion,
      this.screeningDate,
      this.kidney,
      this.weight,
      this.waist,
      this.BMI,
      this.vision,
      this.hearing,
      this.bloodPressure,
      this.proteinuria,
      this.hemoglobin,
      this.FBG,
      this.cholesterol,
      this.HDL,
      this.triglycerides,
      this.LDL,
      this.serumCreatinine,
      this.GFR,
      this.SGOT,
      this.SGPT,
      this.y_GTP,
      this.tuberculosis,
      this.osteoporosis});

  ScreeningList.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    result = json['result'];
    chkAgency = json['chkAgency'];
    opinion = json['opinion'];
    screeningDate = json['screeningDate'];
    kidney = json['kidney'];
    weight = json['weight'];
    waist = json['waist'];
    BMI = json['BMI'];
    vision = json['vision'];
    hearing = json['hearing'];
    bloodPressure = json['bloodPressure'];
    proteinuria = json['proteinuria'];
    hemoglobin = json['hemoglobin'];
    FBG = json['FBG'];
    cholesterol = json['cholesterol'];
    HDL = json['HDL'];
    triglycerides = json['triglycerides'];
    LDL = json['LDL'];

    serumCreatinine = json['serumCreatinine'];
    GFR = json['GFR'];
    SGOT = json['SGOT'];
    SGPT = json['SGPT'];
    y_GTP = json['y_GTP'];
    tuberculosis = json['tuberculosis'];
    osteoporosis = json['osteoporosis'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['result'] = result;
    data['chkAgency'] = chkAgency;
    data['opinion'] = opinion;
    data['screeningDate'] = screeningDate;
    data['kidney'] = kidney;
    data['weight'] = weight;
    data['waist'] = waist;
    data['BMI'] = BMI;
    data['vision'] = vision;
    data['hearing'] = hearing;
    data['bloodPressure'] = bloodPressure;
    data['proteinuria'] = proteinuria;
    data['hemoglobin'] = hemoglobin;
    data['FBG'] = FBG;
    data['cholesterol'] = cholesterol;
    data['HDL'] = HDL;
    data['triglycerides'] = triglycerides;
    data['LDL'] = LDL;
    data['serumCreatinine'] = serumCreatinine;
    data['GFR'] = GFR;
    data['SGOT'] = SGOT;
    data['SGPT'] = SGPT;
    data['y_GTP'] = y_GTP;
    data['tuberculosis'] = tuberculosis;
    data['osteoporosis'] = osteoporosis;
    return data;
  }
}

class MedicineModel {
  List<MedicineList>? medicineList;

  MedicineModel({this.medicineList});

  MedicineModel.fromJson(Map<String, dynamic> json) {
    if (json['medicineList'] != null) {
      medicineList = <MedicineList>[];
      json['medicineList'].forEach((v) {
        medicineList!.add(MedicineList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (medicineList != null) {
      data['medicineList'] = medicineList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedicineList {
  String? No;
  String? pharmNm;
  String? medDate;
  String? medType;
  List<MedList>? medList;

  MedicineList(
      {this.No, this.pharmNm, this.medDate, this.medType, this.medList});

  MedicineList.fromJson(Map<String, dynamic> json) {
    No = json['No'];
    pharmNm = json['pharmNm'];
    medDate = json['medDate'];
    medType = json['medType'];
    if (json['medList'] != null) {
      medList = <MedList>[];
      json['medList'].forEach((v) {
        medList!.add(MedList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['No'] = No;
    data['pharmNm'] = pharmNm;
    data['medDate'] = medDate;
    data['medType'] = medType;
    if (medList != null) {
      data['medList'] = medList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MedList {
  String? medicineNm;
  String? medicineEffect;
  String? dosageDay;

  MedList({this.medicineNm, this.medicineEffect, this.dosageDay});

  MedList.fromJson(Map<String, dynamic> json) {
    medicineNm = json['medicineNm'];
    medicineEffect = json['medicineEffect'];
    dosageDay = json['dosageDay'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['medicineNm'] = medicineNm;
    data['medicineEffect'] = medicineEffect;
    data['dosageDay'] = dosageDay;
    return data;
  }

  Widget towidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      const Center(
        child: NanumBodyText(
          text: "",
          fontSize: 20,
        ),
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              NanumTitleText(text: medicineEffect!, fontSize: 15),
              const NanumText(
                text: " ",
              ),
              NanumTitleText(text: '(${dosageDay!}정)', fontSize: 15),
            ],
          ),
        ],
      )
    ]);
  }
}

class DiagnosisModel {
  List<DiagnosisTotalList>? diagnosisTotalList;

  DiagnosisModel({this.diagnosisTotalList});

  DiagnosisModel.fromJson(Map<String, dynamic> json) {
    if (json['diagnosisTotalList'] != null) {
      diagnosisTotalList = <DiagnosisTotalList>[];
      json['diagnosisTotalList'].forEach((v) {
        diagnosisTotalList!.add(DiagnosisTotalList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (diagnosisTotalList != null) {
      data['diagnosisTotalList'] =
          diagnosisTotalList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DiagnosisTotalList {
  List<DiagnosisList>? diagnosisList;

  DiagnosisTotalList({this.diagnosisList});

  DiagnosisTotalList.fromJson(Map<String, dynamic> json) {
    if (json['diagnosisList'] != null) {
      diagnosisList = <DiagnosisList>[];
      json['diagnosisList'].forEach((v) {
        diagnosisList!.add(DiagnosisList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (diagnosisList != null) {
      data['diagnosisList'] = diagnosisList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DiagnosisList {
  String? examinee;
  String? No;
  String? pharmNm;
  String? diagType;
  String? diagSdate;

  DiagnosisList(
      {this.examinee, this.No, this.pharmNm, this.diagType, this.diagSdate});

  DiagnosisList.fromJson(Map<String, dynamic> json) {
    examinee = json['examinee'];
    No = json['No'];
    pharmNm = json['pharmNm'];
    diagType = json['diagType'];
    diagSdate = json['diagSdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['examinee'] = examinee;
    data['No'] = No;
    data['pharmNm'] = pharmNm;
    data['diagType'] = diagType;
    data['diagSdate'] = diagSdate;
    return data;
  }
}

class LoginModel {
  final String type;
  final String accessToken;
  final String reflashToken;
  final String email;
  final String name;
  final String phone;
  final String telecom;
  final String birthday;
  final String gender;

  LoginModel(this.type, this.accessToken, this.reflashToken, this.email,
      this.name, this.phone, this.telecom, this.birthday, this.gender);

  LoginModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        accessToken = json['accessToken'], // Apple Login일 경우 userId
        reflashToken = json['reflashToken'], // Apple Login일 경우 identityToken
        email = json['email'],
        name = json['name'],
        phone = json['phone'],
        telecom = json['telecom'],
        birthday = json['birthday'],
        gender = json['gender'];

  Map<String, dynamic> toJson() => {
        'type': type,
        'accessToken': accessToken,
        'reflashToken': reflashToken,
        'email': email,
        'name': name,
        'phone': phone,
        'telecom': telecom,
        'birthday': birthday,
        'gender': gender
      };
}

class LoginBeingModel {
  final String name;
  final String phone_number;
  final String telecom;
  final String birthday;
  final int gender;

  LoginBeingModel(
      this.name, this.phone_number, this.telecom, this.birthday, this.gender);

  LoginBeingModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        phone_number = json['phone_number'],
        telecom = json['telecom'],
        birthday = json['birthday'],
        gender = json['gender'];
}
