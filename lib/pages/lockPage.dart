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
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    _homeProvider = context.watch<HomeProvider>();

    final ButtonStyle style = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
          //모서리를 둥글게
          borderRadius: BorderRadius.circular(0)),
      minimumSize: Size(screenWidth, screenHeight * 0.07),
      backgroundColor: Colors.green,
      disabledBackgroundColor: Colors.grey,
      foregroundColor: Colors.green[900],
      elevation: 0.0,
      // foregroundColor: Colors.greenAccent,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          title: const NanumTitleText(text: "비밀번호 설정"),
          toolbarHeight: 60,
          backgroundColor: Colors.white,
          elevation: 0.0),
      body: SafeArea(
        child: Container(
          height: screenHeight,
          width: screenWidth,
          decoration: const BoxDecoration(color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    Image.asset("assets/images/main_logo(cp).png",
                        height: screenHeight * 0.3, width: screenWidth * 0.4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _homeProvider.applockValue!.applockpw.length,
                        (index) {
                          return passwdUI(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),

              // numpad('1')
              Expanded(
                flex: 2,
                child: Column(children: [
                  Row(children: [
                    numpad("input", "1"),
                    numpadSeperateList("vertical"),
                    numpad("input", "2"),
                    numpadSeperateList("vertical"),
                    numpad("input", "3")
                  ]),
                  numpadSeperateList("horizon"),
                  Row(children: [
                    numpad("input", "4"),
                    numpadSeperateList("vertical"),
                    numpad("input", "5"),
                    numpadSeperateList("vertical"),
                    numpad("input", "6")
                  ]),
                  numpadSeperateList("horizon"),
                  Row(children: [
                    numpad("input", "7"),
                    numpadSeperateList("vertical"),
                    numpad("input", "8"),
                    numpadSeperateList("vertical"),
                    numpad("input", "9")
                  ]),
                  numpadSeperateList("horizon"),
                  Row(children: [
                    numpad("nothing", " "),
                    numpadSeperateList("vertical"),
                    numpad("input", "0"),
                    numpadSeperateList("vertical"),
                    numpad("remove", "지우기")
                  ]),
                ]),
              )
            ],
          ),
        ),
      ),
      bottomSheet: TextButton(
        style: style,
        onPressed: _homeProvider.applockValue!.inputPwLength == 4
            ? () async {
                
                // Navigator.pop(context);
              }
            : null,
        child: const NanumTitleText(
          text: '저장',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget passwdUI(int index) {
    if (_homeProvider.applockValue!.applockpw[index] != "_") {
      return const NanumTitleText(text: "*", fontSize: 50, color: Colors.green);
    } else {
      return const NanumTitleText(
        text: "_",
        fontSize: 50,
        color: Colors.grey,
      );
    }
  }

  Widget numpad(String type, String num) {
    var screenHeight =
        MediaQuery.of(context).size.height - kBottomNavigationBarHeight * 2;
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        // height: bottombarHeight,
        height: (screenHeight / 2) / 5,
        // width: screenWidth / 3,
        width: (screenWidth - screenWidth * 0.002) / 3,
        child: ElevatedButton(
          onPressed: () {
            // print(num);
            _homeProvider.updateApplockValue(type, num);
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.green,
            backgroundColor: Colors.white,
            minimumSize: const Size.fromHeight(45),
            elevation: 0.0,
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius.circular(15)),
          ),
          child: NanumTitleText(
            text: num,
            color: Colors.green,
            fontSize: 20,
          ),
        ));
  }

  Widget numpadSeperateList(String type) {
    var screenHeight =
        MediaQuery.of(context).size.height - kBottomNavigationBarHeight * 2;
    var screenWidth = MediaQuery.of(context).size.width;

    if (type == "vertical") {
      return Container(
          decoration: const BoxDecoration(color: Colors.grey),
          width: screenWidth * 0.0003,
          height: screenHeight * 0.1);
    } else {
      return Container(
          decoration: const BoxDecoration(color: Colors.grey),
          width: screenWidth,
          height: screenHeight * 0.0002);
    }
  }
}
