import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_medic/function/kakao_login.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/pages/lockPage.dart';
import 'package:super_medic/pages/loginPage.dart';
import 'package:super_medic/pages/mainPage.dart';
import 'package:super_medic/pages/selectChronicDisease.dart';
import 'package:super_medic/function/apple_login.dart';
import 'package:super_medic/function/LoginVerify.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  KakaoLogin kakaologin = KakaoLogin();
  AppleLogin applelogin = AppleLogin();

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 5000), () async {
      // ignore: unrelated_type_equality_checks
      dynamic val = await _loadLoginSecureStorage();
      bool storageBeing;
      if (val != false) {
        //Login User 인지 확인
        if (val.type == 'Kakao') {
          if (await kakaologin.KakaoTokenVerifiy(val)) {
            // ignore: unrelated_type_equality_checks
            await loadDiseaseSecureStorage() == true
                //비밀번호가 설정된 경ㅇ
                ? await loadPwSecureStorage() == true
                    ?
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ApplicationLock("verify")),
                      )
                    :
                    // ignore: use_build_context_synchronously
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MainPage()),
                      )
                // ignore: use_build_context_synchronously
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectChronicDisease()));
          } else {
            storageBeing = true;
            //있는데 로그인
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              // MaterialPageRoute(builder: (context) => MainPage()),
              MaterialPageRoute(
                  builder: (context) =>
                      LoginPage(being: storageBeing)), //LoginPage
            );
          }
        } else if (val.type == 'Naver') {
        } else if (val.type == 'Apple') {
          int loginValidation = await applelogin.AppleUidVerifiy(val);
          if (loginValidation == 0) {
            await loadDiseaseSecureStorage() == true
                // ignore: use_build_context_synchronously
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                  )
                // ignore: use_build_context_synchronously
                : Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectChronicDisease()));
          } else {
            // 자동 로그아웃 후 다시 로그인 페이지
            await deleteSecureStorage();
            storageBeing = false;
            //없는데 로그인
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              // MaterialPageRoute(builder: (context) => MainPage()),
              MaterialPageRoute(
                  builder: (context) =>
                      LoginPage(being: storageBeing)), //LoginPage
            );
          }
        }
      } else {
        storageBeing = false;
        //없는데 로그인
        // ignore: use_build_context_synchronously
        Navigator.pushReplacement(
          context,
          // MaterialPageRoute(builder: (context) => MainPage()),
          MaterialPageRoute(
              builder: (context) => LoginPage(being: storageBeing)), //LoginPage
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const String imageLogoName = 'assets/images/main_logo.png';

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          // backgroundColor: hexToColor('#6F22D2'),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: screenHeight * 0.384375),
              Image.asset(
                imageLogoName,
                width: screenWidth * 0.6,
                height: screenHeight * 0.2,
              ),
              const Expanded(child: SizedBox()),
              Align(
                child: Text("© Copyright 2023, 슈퍼메딕(MYPD)",
                    style: TextStyle(
                      fontFamily: 'NotoSansKR',
                      fontSize: screenWidth * (10 / 360),
                      color: const Color.fromRGBO(26, 164, 87, 0.6), // #1aa457
                      fontWeight: FontWeight.bold,
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.0625,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAlert({String? title, String? message}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title!,
                style: const TextStyle(
                  fontFamily: 'NotoSansKR',
                )),
            content: Text(message!,
                style: const TextStyle(
                  fontFamily: 'NotoSansKR',
                )),
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("확인",
                      style: TextStyle(fontFamily: 'NotoSansKR')),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  deleteSecureStorage() async {
    Login_verify secession = Login_verify();
    const storage = FlutterSecureStorage();
    String? userinfoRead = await storage.read(key: "LoginUser");

    LoginModel userInfo = LoginModel.fromJson(jsonDecode(userinfoRead!));

    final val = await secession.userSecession(userInfo.email);
    if (val == 'true') {
      const storage = FlutterSecureStorage();
      await storage.deleteAll();
    } else {
      _showAlert(title: "에러", message: "다시 시도해주세요");
    }
  }
}

Future<bool> loadDiseaseSecureStorage() async {
  const storage = FlutterSecureStorage();
  String? initchronicdisease = await storage.read(key: 'initChronicDisease');
  if (initchronicdisease != null) {
    return true;
  }
  return false;
}

dynamic _loadLoginSecureStorage() async {
  const storage = FlutterSecureStorage();
  String? val = await storage.read(key: 'LoginUser');
  if (val != null) {
    return LoginModel.fromJson(jsonDecode(val));
  }
  return false;
}

Future<bool> loadPwSecureStorage() async {
  const storage = FlutterSecureStorage();
  var val = await storage.read(key: "AppLockPw");
  if (val == null) {
    return false;
  } else {
    return true;
  }
}
