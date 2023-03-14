import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/pages/healthPage.dart';
import 'package:super_medic/pages/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/pages/medicinePage.dart';
import 'package:super_medic/pages/meditalkPage.dart';
import 'package:super_medic/pages/myPage.dart';
import 'package:super_medic/provider/bottom_navigation_provider.dart';
import 'package:super_medic/widgets/notification/firebase_message.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  late BottomNavigationProvider _bottomNavigationProvider;
  DateTime? currentBackPressTime; //뒤로가기 버튼 클릭 시 앱 종료 구현
  String? userEmail;

  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize(context);
    //  FirebaseMessaging.instance.setAutoInitEnabled(true);
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: true,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getToken().then((token) async {
      const storage = FlutterSecureStorage();
      String? val = await storage.read(key: 'LoginUser');
      if (val != null) {
        userEmail = LoginModel.fromJson(jsonDecode(val)).email;
      }
      http.Response response = await http.post(
        Uri.parse('https://mypd.kr:5000/notification/uploadToken'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {'email': userEmail, 'token': token},
      );
    });

    FirebaseMessaging.instance.getAPNSToken().then((APNStoken) {
      print(APNStoken);
    });

    ///gives you the message on which user taps
    ///and it opened the app from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });

    ///forground work
    FirebaseMessaging.onMessage.listen((message) {
      if (message.notification != null) {
        if (defaultTargetPlatform == TargetPlatform.android) {
          LocalNotificationService.display(message);
        }
      }
    });

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      if (message.notification != null) {
        final routeFromMessage = message.data["route"];
        Navigator.of(context).pushNamed(routeFromMessage);
      }
    });
  }

  // 네비게이션바 UI Widget
  Widget _navigationBody() {
    switch (_bottomNavigationProvider.currentPage) {
      case 0:
        return const HomePage();
      case 1:
        return const MedicinePage();
      case 2:
        return const HealthPage();
      case 3:
        return const MeditalkPage();
      case 4:
        return const MyPage();
    }
    return Container();
  }

  // 네비게이션바 Widget
  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // item이 4개 이상일 경우 추가
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        BottomNavigationBarItem(
            icon: Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset(
                  'assets/images/home_icon1.png',
                  width: 22.5,
                  height: 22.5,
                  color: const Color.fromARGB(160, 158, 158, 158),
                )),
            activeIcon: Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('assets/images/home_icon1.png',
                    width: 22.5, height: 22.5)),
            label: '홈'),
        BottomNavigationBarItem(
          icon: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/images/home_icon2.png',
                width: 22.5,
                height: 22.5,
                color: const Color.fromARGB(160, 158, 158, 158),
              )),
          activeIcon: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset('assets/images/home_icon2.png',
                  width: 22.5, height: 22.5)),
          label: '복약관리',
        ),
        BottomNavigationBarItem(
          icon: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/images/home_icon3.png',
                width: 22.5,
                height: 22.5,
                color: const Color.fromARGB(160, 158, 158, 158),
              )),
          activeIcon: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset('assets/images/home_icon3.png',
                  width: 22.5, height: 22.5)),
          label: '마이데이터',
        ),
        BottomNavigationBarItem(
          icon: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/images/home_icon4.png',
                width: 22.5,
                height: 22.5,
                color: const Color.fromARGB(160, 158, 158, 158),
              )),
          activeIcon: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset('assets/images/home_icon4.png',
                  width: 22.5, height: 22.5)),
          label: '메디톡',
        ),
        BottomNavigationBarItem(
            icon: Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: const Icon(
                  Icons.person_outline_rounded,
                  color: const Color.fromARGB(160, 158, 158, 158),
                )),
            label: '마이페이지')
      ],

      // 현재 페이지 : _bottomNavigationProvider의 currentPage
      currentIndex: _bottomNavigationProvider.currentPage,
      selectedItemColor: Colors.black,
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 9,
        color: Color.fromARGB(160, 158, 158, 158),
      ),
      selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
      // _bottomNavigationProvider에 updateCurrentPage를 통해 index를 전달
      onTap: (index) {
        _bottomNavigationProvider.updateCurrentPage(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _bottomNavigationProvider = context.watch<BottomNavigationProvider>();

    //뒤로 가기 두 번 클릭 시 어플 종료
    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(
            msg: "'뒤로' 버튼을 한번 더 누르시면 종료됩니다.",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color(0xff6E6E6E),
            fontSize: 12,
            toastLength: Toast.LENGTH_SHORT);
        return Future.value(false);
      }
      SystemNavigator.pop();
      return Future.value(true);
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
          child: _navigationBody(),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
