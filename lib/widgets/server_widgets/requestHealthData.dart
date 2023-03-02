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

Future<String> requestHealthData(
    String loginOrgCd, String healthDataType, String step,
    {String step_data = ''}) async {
  List<String> URIs = [
    'https://mypd.kr:5000/health/screenings/test',
    'https://mypd.kr:5000/health/medicine/test',
    'https://mypd.kr:5000/health/diagnosis/test'
  ];

  List<String> lastParamKeys = ['mobileCo', 'subjectType', 'subjectType'];
  List<String> lastParamValues = ['K', '00', '00'];
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

  String a = await _resultHealthData(URIs[idx] + init, healthDataType,
      loginOrgCd, lastParamKeys[idx], lastParamValues[idx], step, step_data);

  return a;
}

Future<String> _resultHealthData(
    String URI,
    String healthDataType,
    String loginOrgCd,
    String lastParamKey,
    String lastParamValue,
    String step,
    String stepData) async {
  final response = await http.post(Uri.parse(URI), headers: <String, String>{
    'Content-Type': 'application/x-www-form-urlencoded',
  }, body: <String, String>{
    'loginOrgCd': loginOrgCd,
    'name': '현석훈',
    'birthday': '19980801',
    'mobileNo': '01028670096',
    lastParamKey: lastParamValue,
    'step': step,
    'step_data': stepData
  });

  if ((response.statusCode == 200) && (step == 'sign')) {
    print(response.statusCode);
    print(utf8.decode(response.bodyBytes));

    saveSecureStorage(healthDataType, utf8.decode(response.bodyBytes));
    return utf8.decode(response.bodyBytes);
  } else if (step == 'init') {
    print(response.statusCode);

    return utf8.decode(response.bodyBytes);

    // 만약 응답이 OK가 아니면, 에러 반환.
  } else {
    print(response.statusCode);
    print(utf8.decode(response.bodyBytes));
    throw Exception('Failed to load post');
  }
}

saveSecureStorage(String key, String data) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: key, value: data);
}
