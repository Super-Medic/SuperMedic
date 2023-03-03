import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:super_medic/function/kakao_login.dart';
import 'dart:async';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/pages/loginPage.dart';
import 'package:super_medic/pages/mainPage.dart';
import 'package:super_medic/pages/selectChronicDisease.dart';
import 'package:super_medic/widgets/notification/firebase_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  KakaoLogin kakaologin = KakaoLogin();
  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize(context);
    FirebaseMessaging.instance
        .requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    )
        .then((value) {
      print('퍼미션');
      print(value);
    });
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getToken().then((token) {
      print('토큰');
      print(token);
    });
    FirebaseMessaging.instance.getAPNSToken().then((APNStoken) {
      print('APNS 토큰');
      print(APNStoken);
    });

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];

        Navigator.of(context).pushNamed(routeFromMessage);
      } else {
        print('1');

        print(message);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        print(message.notification!.body);
        print(message.notification!.title);
        LocalNotificationService.display(message);
      } else {
        print('1');
        print(message);
      }
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });
    Timer(const Duration(milliseconds: 5000), () async {
      // ignore: unrelated_type_equality_checks
      dynamic val = await _loadLoginSecureStorage();
      if (val != false) {
        //Login User 인지 확인
        if (val.type == 'Kakao') {
          if (await kakaologin.KakaoTokenVerifiy(val)) {
            // ignore: unrelated_type_equality_checks
            await loadDiseaseSecureStorage() == true
                // ignore: use_build_context_synchronously
                ? Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  )
                // ignore: use_build_context_synchronously
                : Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SelectChronicDisease()));
          } else {
            // ignore: use_build_context_synchronously
            Navigator.push(
              context,
              // MaterialPageRoute(builder: (context) => MainPage()),
              MaterialPageRoute(builder: (context) => LoginPage()), //LoginPage
            );
          }
        } else if (val.type == 'Naver') {}
      } else {
        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          // MaterialPageRoute(builder: (context) => MainPage()),
          MaterialPageRoute(builder: (context) => LoginPage()), //LoginPage
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
