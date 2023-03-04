// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:super_medic/function/model.dart';

Future<String> requestHealthData(
    String loginOrgCd, String healthDataType, String step,
    {String step_data = ''}) async {
  List<String> URIs = [
    'https://mypd.kr:5000/health/screenings/',
    'https://mypd.kr:5000/health/medicine/',
    'https://mypd.kr:5000/health/diagnosis/'
  ];

  // List<String> lastParamKeys = ['mobileCo', 'subjectType', 'subjectType'];
  // List<String> lastParamValues = ['K', '00', '00'];
  String init = '';
  int idx = 0;
  if (step == 'init') {
    init = 'init';
  } else if (step == 'sign') {
    init = 'sign';
  }

  switch (healthDataType) {
    case "Screenings":
      idx = 0;
      break;
    case "Medicine":
      idx = 1;
      break;
    case "Diagnosis":
      idx = 2;
      break;
  }

  String a = await _resultHealthData(
      URIs[idx] + init, healthDataType, loginOrgCd, step, step_data);

  return a;
}

Future<String> _resultHealthData(String URI, String healthDataType,
    String loginOrgCd, String step, String stepData) async {
  const storage = FlutterSecureStorage();

  String? userinfoRead = await storage.read(key: "LoginUser");
  LoginModel userInfo = LoginModel.fromJson(jsonDecode(userinfoRead!));

  String birthday;
  if (userInfo.gender == '1' || userInfo.gender == '2') {
    birthday = '19${userInfo.birthday}';
  } else {
    birthday = '20${userInfo.birthday}';
  }
  final response = await http.post(Uri.parse(URI), headers: <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
  }, body: <String, String>{
    'loginOrgCd': loginOrgCd,
    'name': userInfo.name,
    'birthday': birthday,
    'mobileNo': userInfo.phone,
    'mobileCo': userInfo.telecom,
    'subjectType': "00",
    'step': step,
    'step_data': stepData
  });

  if ((response.statusCode == 200) && (step == 'sign')) {
    saveSecureStorage(healthDataType, utf8.decode(response.bodyBytes));
    return response.statusCode.toString();
  } else if (step == 'init') {
    return utf8.decode(response.bodyBytes);
    // 만약 응답이 OK가 아니면, 에러 반환.
  } else {
    return response.statusCode.toString();
  }
}

saveSecureStorage(String key, String data) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: key, value: data);
}
