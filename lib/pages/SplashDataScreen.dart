import 'package:flutter/material.dart';
import 'package:super_medic/pages/healthPage.dart';
import 'package:super_medic/pages/selectChronicDisease.dart';
import 'dart:async';

class SplashDataScreen extends StatefulWidget {
  const SplashDataScreen({super.key});

  @override
  _SplashDataScreen createState() => _SplashDataScreen();
}

class _SplashDataScreen extends State<SplashDataScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 1500), () {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const HealthPage())); // splash 화면 동안 인터넷 연결 체크 등등
    });
  }

  @override
  Widget build(BuildContext context) {
    const String imageLogoName = 'assets/images/loading.png';

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: () async => false,
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          // backgroundColor: hexToColor('#6F22D2'),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.384375),
                Container(
                  child: Image.asset(
                    imageLogoName,
                    width: screenWidth * 0.6,
                    height: screenHeight * 0.2,
                  ),
                ),
                const Expanded(child: SizedBox()),
                Align(
                  child: Text("",
                      style: TextStyle(
                        fontSize: screenWidth * (10 / 360),
                        color:
                            const Color.fromRGBO(26, 164, 87, 0.6), // #1aa457
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
      ),
    );
  }
}
