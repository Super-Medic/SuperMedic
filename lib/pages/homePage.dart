import 'package:flutter/material.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_pressure.dart';
import 'package:super_medic/widgets/mainPage_widgets/medication_time.dart';
import 'package:super_medic/widgets/mainPage_widgets/present_time.dart';
import 'package:super_medic/themes/theme.dart'; //스타일
import 'package:super_medic/themes/common_color.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/bottom_navigation_provider.dart';
import 'package:super_medic/widgets/notification/firebase_message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:super_medic/widgets/mainPage_widgets/note.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_sugar.dart';
import 'package:super_medic/widgets/mainPage_widgets/symptom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime someDateTime = DateTime.now();
  late HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize(context);
    FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    FirebaseMessaging.instance.getToken().then((token) {

      print(token);
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
    FirebaseMessaging.onMessage.listen((message) {});

    ///When the app is in background but opened and user taps
    ///on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      final routeFromMessage = message.data["route"];
      Navigator.of(context).pushNamed(routeFromMessage);
    });

    Future.microtask(() {
      if (_homeProvider.bloodSugarValue.isEmpty) {
        Provider.of<HomeProvider>(context, listen: false).bloodSugargetData();
      }
      if (_homeProvider.bloodPressureValue.isEmpty) {
        Provider.of<HomeProvider>(context, listen: false)
            .bloodPressuregetData();
      }
      if (_homeProvider.symptomsValue.isEmpty) {
        Provider.of<HomeProvider>(context, listen: false).symptomgetData();
      }
      if (_homeProvider.noteTextValue.isEmpty) {
        Provider.of<HomeProvider>(context, listen: false).noteTextgetData();
      }

      if (_homeProvider.screeningValue == null) {
        Provider.of<HomeProvider>(context, listen: false).screeninggetData();
      }
      if (_homeProvider.medicineValue == null) {
        Provider.of<HomeProvider>(context, listen: false).medicinegetData();
      }
      if (_homeProvider.diagnosisValue == null) {
        Provider.of<HomeProvider>(context, listen: false).diagnosisgetData();
      }

      if (_homeProvider.loginValue == null) {
        Provider.of<HomeProvider>(context, listen: false).logingetData();
      } 
    });
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: CommonColor.background,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: CommonColor.background, //배경 색
          elevation: 0.0, //그림자 효과 해제
          leading: Container(
            padding: const EdgeInsets.only(left: 10),
            child: Image.asset(
              'assets/images/home_logo.png',
              color: Colors.green,
            ),
          ),
          leadingWidth: 150,
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications_none),
              color: Colors.black,
              iconSize: 25,
              onPressed: () => {},
            ),
            IconButton(
              icon: const Icon(Icons.menu),
              color: Colors.black,
              iconSize: 25,
              onPressed: () => {},
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
        body: SingleChildScrollView(
            child: Container(
          padding: AppTheme.totalpadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const PresentTime(), //날짜
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const MedicationTime(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const BloodSugar(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const BloodPressure(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const Symptom(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const Note(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<BottomNavigationProvider>().updateCurrentPage(2);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: CommonColor.buttoncolor,
                  minimumSize: const Size.fromHeight(45),
                  elevation: 1.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const Text('나의 건강기록 보기'),
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
