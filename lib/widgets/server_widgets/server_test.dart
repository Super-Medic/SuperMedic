// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!지우시면 안됩니다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'dart:io';
import 'dart:async';
import 'dart:convert';

///////////////////////////////////////////건강 검진 시작//////////////////////////////////////

// class Screenings_List {
//   var list = new List.empty(growable: true);

// }

// class Screenings{
//   List<Screenings_List>;
// }
///////////////////////////////////////////건강 검진 끝//////////////////////////////////////

///////////////////////////////////////////진료 내역 시작//////////////////////////////////////

///////////////////////////////////////////진료 내역 끝//////////////////////////////////////

///////////////////////////////////////////투약 내역 시작//////////////////////////////////////
// class MedList {
//   String? medicineNm;
//   String? medicineEffect;
//   String? dosageDay;

//   MedList({this.medicineNm, this.medicineEffect, this.dosageDay});

//   MedList.fromJson(Map<String, dynamic> json) {
//     medicineNm = json['medicineNm'];
//     medicineEffect = json['medicineEffect'];
//     dosageDay = json['dosageDay'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['medicineNm'] = medicineNm;
//     data['medicineEffect'] = medicineEffect;
//     data['dosageDay'] = dosageDay;
//     return data;
//   }
// }

// class Medicine {
//   String? No;
//   String? pharmNm;
//   String? medDate;
//   String? medType;
//   List<MedList>? medList;

//   Medicine({this.No, this.pharmNm, this.medDate, this.medType, this.medList});

//   Medicine.fromList(Map<String, dynamic> json) {
//     print(jsonEncode(json));

//     // no = json['No'];
//     // pharmNm = json['pharmNm'];
//     // medDate = json['medDate'];
//     // medType = json['medType'];
//     // if (json['medList'] != null) {
//     //   medList = <MedList>[];
//     //   json['medList'].forEach((v) {
//     //     medList!.add(MedList.fromJson(v));
//     //   });
//     // }
//   }

//   Map<String, dynamic> toJson() {
//     Map<String, dynamic> data = <String, dynamic>{};
//     data['No'] = No;
//     data['pharmNm'] = pharmNm;
//     data['medDate'] = medDate;
//     data['medType'] = medType;
//     if (medList != null) {
//       data['medList'] = medList!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

class Medicine {
  List<MedicineList>? medicineList;

  Medicine({this.medicineList});

  Medicine.fromJson(Map<String, dynamic> json) {
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
}

///////////////////////////////////////////투약 내역 끝//////////////////////////////////////
//////////////////////////////////////////////전체 내역 시작//////////////////////////////////////
// class HealthData {
//   List<Medicine> medicine;

//   HealthData({
//     required this.medicine,
//   });

//   factory HealthData.fromJson(Map<dynamic, dynamic> json) {
//     return HealthData(
//       medicine: (json['medList'] as List).map((e) => e == null ? null : MedList.fromJson(e)).toList(),
//     );
//   }

// Map<String, dynamic> toJson() {
//   return {
//     'common': common,
//   };
// }

// class Info {
//   final String name;
//   final String birthday;
//   final String age;
//   final String gender;

//   Info({
//     required this.name,
//     required this.birthday,
//     required this.age,
//     required this.gender,
//   });

//   factory Info.fromJson(Map<dynamic, dynamic> json) {
//     return Info(
//         name: json['name'],
//         birthday: json['birthday'],
//         age: json['age'],
//         gender: json['gender']);
//   }
//   Map<String, dynamic> toJson() {
//     return {'name': name, 'birthday': birthday, 'age': age, 'gender': gender};
//   }
// }

// Future<Medicine> requestHealthData() async {
//   final response = await http.post(
//       Uri.parse('https://mypd.kr:5000/health/medicine/test'),
//       headers: <String, String>{
//         'Content-Type': 'application/x-www-form-urlencoded',
//       },
//       body: <String, String>{
//         'loginOrgCd': 'kakao',
//         'name': '현석훈',
//         'birthday': '19980801',
//         'mobileNo': '01028670096',
//         'subjectType': '00',
//       });
//   if (response.statusCode == 200) {
//     print("응답 왔음");
//     // 만약 서버가 OK 응답을 반환하면, JSON을 파싱합니다.
//     // print(response.body);
//     print(json.decode(response.body));
//     return Medicine.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
//   } else {
//     // 만약 응답이 OK가 아니면, 에러를 던집니다.
//     throw Exception('Failed to load post');
//   }
// }
//////////////////////////////////////////////전체 내역 끝//////////////////////////////////////
Future<Medicine> requestHealthData() async {
  final response = await http.post(Uri.parse('http://10.0.2.2:8080'));
  if (response.statusCode == 200) {
    print(response.statusCode);
    print(utf8.decode(response.bodyBytes));

    return Medicine.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  } else {
    // 만약 응답이 OK가 아니면, 에러를 던집니다.adsdsaffsadfㅁㄴㅇ
    throw Exception('Failed to load post');
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  print(path);
  // print(path);
  return File('$path/test.json');
}

Future<File> saveJson(String jsonData) async {
  final file = await _localFile;

  // 파일 쓰기
  return file.writeAsString(jsonData);
}

// Future<void> saveJson(String json_data) async {
//   // final file = await _localFile;
//   // print(json_data.runtimeType);
//   final file = await File('assets/json/test.json');
//   String load_json = await file.readAsString();
//   print(load_json);
//   // print(file);
//   // 파일 쓰기
//   // file.writeAsString(json_data);
// }

class GetHealthInfo extends StatefulWidget {
  const GetHealthInfo({super.key});

  @override
  State<GetHealthInfo> createState() => _GetHealthInfoState();
}

class _GetHealthInfoState extends State<GetHealthInfo> {
  // late Future<Medicine> heathdata;
  // late Future<Medicine> medicine;
  late Future<Medicine> medicine;

  @override
  void initState() {
    super.initState();
    medicine = requestHealthData();
  }

  @override
  Widget build(BuildContext context) {
    secure_storage(String data) async {
      const storage = FlutterSecureStorage();
      await storage.write(key: "data", value: data);
      String? value = await storage.read(key: "test");
      print(value);
    }

    remove_secure_storage() async {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
    }

    return MaterialApp(
      title: 'Json test from server',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Json test from server'),
        ),
        body: Center(
          child: FutureBuilder<Medicine>(
            future: medicine,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // print(snapshot.hasData);
              if (snapshot.hasData) {
                print(jsonEncode(snapshot.data));

                // secure_storage(jsonEncode(snapshot.data));
                // _incrementCounter();

                // saveJson(jsonEncode(snapshot.data));
                remove_secure_storage();
                // saveJson(json.encode(snapshot.data.toJson()));

                return Column(children: [
                  Text(snapshot.data.medicineList[0].No),
                  Text(snapshot.data.medicineList[0].pharmNm),
                  Text(snapshot.data.medicineList[0].medDate),
                  Text(snapshot.data.medicineList[0].medType),
                ]);
              } else if (snapshot.hasError) {
                print("${snapshot.error}");
                return Text("${snapshot.error}");
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
