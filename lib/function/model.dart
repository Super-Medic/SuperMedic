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

class NoteModel {
  final String DateTime;
  final String DateTime_hm;
  final String NoteText;

  NoteModel(this.DateTime, this.DateTime_hm, this.NoteText);

  NoteModel.fromJson(Map<String, dynamic> json)
      : DateTime = json['DateTime'],
        DateTime_hm = json['DateTime_hm'],
        NoteText = json['NoteText'];

  Map<String, dynamic> toJson() => {
        'DateTime': DateTime,
        'DateTime_hm': DateTime_hm,
        'NoteText': NoteText,
      };
}

class LoginModel {
  final String type;
  final String accessToken;
  final String reflashToken;

  LoginModel(this.type, this.accessToken, this.reflashToken);

  LoginModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        accessToken = json['accessToken'],
        reflashToken = json['reflashToken'];

  Map<String, dynamic> toJson() => {
        'type': type,
        'accessToken': accessToken,
        'reflashToken': reflashToken,
      };
}
