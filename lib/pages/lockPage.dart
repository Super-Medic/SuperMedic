import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//스타일
import 'package:super_medic/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/themes/textstyle.dart';

// ignore: must_be_immutable
class ApplicationLock extends StatefulWidget {
  const ApplicationLock({Key? key}) : super(key: key);

  @override
  State<ApplicationLock> createState() => _ApplicationLock();
}

class _ApplicationLock extends State<ApplicationLock> {
  late HomeProvider _homeProvider;
  final storage = const FlutterSecureStorage();
  String? userName;

  @override
  Widget build(BuildContext context) {
    List<String> AppLockPw = ["_", "_", "_", "_"];
    int inputPwLength = 0;
    var screenHeight =
        MediaQuery.of(context).size.height - kBottomNavigationBarHeight * 2;

    var screenWidth = MediaQuery.of(context).size.width;

    // getUserName();

    _homeProvider = context.watch<HomeProvider>();

    Widget numpad(
      String num,
    ) {
      return SizedBox(
          // height: bottombarHeight,
          height: (screenHeight / 2) / 4,
          // width: screenWidth / 3,
          width: screenWidth / 6,
          child: ElevatedButton(
              onPressed: () {
                // print(num);
                print(AppLockPw);
                AppLockPw[inputPwLength] = num;
                inputPwLength += 1;
                setState(() {});
                print(AppLockPw);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: const Size.fromHeight(45),
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child: Container(
                // height: 10,
                // width: 10,
                decoration: const BoxDecoration(color: Colors.red),
                child: NanumTitleText(
                  text: num,
                  color: Colors.black,
                ),
              )));
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            toolbarHeight: 60, backgroundColor: Colors.white, elevation: 0.0),
        body: Container(
            height: screenHeight,
            width: screenWidth,
            decoration: BoxDecoration(color: Colors.grey[400]),
            child: Column(children: [
              Container(
                height: screenHeight / 2,
                decoration: const BoxDecoration(color: Colors.red),
                child: Row(
                    children: List.generate(
                  AppLockPw.length,
                  (index) {
                    return NanumTitleText(text: AppLockPw[index]);
                  },
                )),
              ),
              // numpad('1')
              // Row(children: [numpad("1"), numpad("2"), numpad("3")]),
              // Row(children: [numpad("4"), numpad("5"), numpad("6")]),
              // Row(children: [numpad("7"), numpad("8"), numpad("9")]),
              // Row(children: [numpad(" "), numpad("0"), numpad("지우기")]),
              Row(children: [numpad("1")]),
            ])),
      ),
    );
  }
}
