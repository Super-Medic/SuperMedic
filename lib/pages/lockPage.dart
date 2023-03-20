import 'package:flutter/foundation.dart';
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
  late AppLockModel _applockValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _applockValue = AppLockModel(["_", "_", "_", "_"]);
  }

  @override
  Widget build(BuildContext context) {
    // print("good");
    print(MediaQuery.of(context).size.height);
    var screenHeight = MediaQuery.of(context).size.height * 0.93 -
        kBottomNavigationBarHeight -
        MediaQuery.of(context).padding.top;

    var screenWidth = MediaQuery.of(context).size.width;
    print(MediaQuery.of(context).padding.top);
    print(MediaQuery.of(context).padding.bottom);
    print(MediaQuery.of(context).viewInsets.bottom);
    print(MediaQuery.of(context).viewPadding.bottom);

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
      backgroundColor:
          _applockValue.inputPwLength == 4 ? Colors.green : Colors.grey,
      body: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
                //replace with our own icon data.
              ),
              title: const NanumTitleText(text: "비밀번호 설정"),
              toolbarHeight: 60,
              backgroundColor: Colors.white,
              elevation: 0.0),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Image.asset("assets/images/main_logo.png",
                        height: screenHeight * 0.3, width: screenWidth * 0.4),
                    NanumTitleText(
                      text: _applockValue.firstInput == false
                          ? "비밀번호 입력"
                          : "비밀번호 확인",
                      fontSize: 20,
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    NanumTitleText(
                      text: _applockValue.firstInput == false
                          ? "비밀번호를 입력해주세요"
                          : "비밀번호 확인을 위해 재입력 해주세요",
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        _applockValue.tmpapplockpw.length,
                        (index) {
                          return passwdUI(index);
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // SizedBox(height: screenHeight * 0.1),
              // numpad('1')
              Expanded(
                flex: 4,
                child: Column(children: [
                  Expanded(
                    flex: 1,
                    child: Row(children: [
                      numpad("input", "1"),
                      numpadSeperateList("vertical"),
                      numpad("input", "2"),
                      numpadSeperateList("vertical"),
                      numpad("input", "3")
                    ]),
                  ),
                  numpadSeperateList("horizon"),
                  Expanded(
                    flex: 1,
                    child: Row(children: [
                      numpad("input", "4"),
                      numpadSeperateList("vertical"),
                      numpad("input", "5"),
                      numpadSeperateList("vertical"),
                      numpad("input", "6")
                    ]),
                  ),
                  numpadSeperateList("horizon"),
                  Expanded(
                    flex: 1,
                    child: Row(children: [
                      numpad("input", "7"),
                      numpadSeperateList("vertical"),
                      numpad("input", "8"),
                      numpadSeperateList("vertical"),
                      numpad("input", "9")
                    ]),
                  ),
                  numpadSeperateList("horizon"),
                  Expanded(
                    flex: 1,
                    child: Row(children: [
                      numpad("nothing", " "),
                      numpadSeperateList("vertical"),
                      numpad("input", "0"),
                      numpadSeperateList("vertical"),
                      numpad("remove", "지우기")
                    ]),
                  ),
                ]),
              ),
              TextButton(
                  style: style,
                  onPressed: _applockValue.inputPwLength == 4
                      ? () {
                          _applockValue.firstInput == false
                              // 비밀번호 1차만 입력될 경우
                              ? setState(() {
                                  updateApplockValue("firstpwcompl", "");
                                })
                              // 비밀번호 2차까지 입력될 경우
                              : setState(() {
                                  updateApplockValue("pwcmp", "");
                                  // 1차, 2차 비밀번호가 다를 경우
                                  if (_applockValue.verifyCompl == false) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return const PopUp();
                                      },
                                    );
                                    updateApplockValue("init", "");
                                  }
                                  // 비밀번호 설정이 완료된 경우
                                  else {
                                    Navigator.of(context).pop();
                                  }
                                });
                        }
                      : null,
                  child: NanumTitleText(
                    text: _applockValue.firstInput == false ? '다음' : "저장",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          // bottomSheet:
        ),
      ),
    );
  }

  Widget passwdUI(int index) {
    if (_applockValue.tmpapplockpw[index] != "_") {
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
        // height: (screenHeight / 2) / 5,
        height: double.maxFinite,
        // width: screenWidth / 3,
        // width: double.maxFinite,
        width: (screenWidth - screenWidth * 0.002) / 3,
        child: ElevatedButton(
          onPressed: () {
            // print(num);
            updateApplockValue(type, num);
            setState(() {});
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
          height: double.maxFinite);
    } else {
      return Container(
          decoration: const BoxDecoration(color: Colors.grey),
          width: double.maxFinite,
          height: screenHeight * 0.0002);
    }
  }

  // saveAppPw() {
  //   const storage = FlutterSecureStorage();
  //   storage.write(key:"AppLockPw", value:_homeProvider.)
  // }

  updateApplockValue(String type, String value) async {
    switch (type) {
      case "init":
        // print("error");
        _applockValue.initPw();
        break;

      case "input":
        _applockValue.inputPw(value);
        break;

      case "remove":
        _applockValue.removePw();
        break;

      case "firstpwcompl":
        _applockValue.firstInputPwCompl();
        break;

      case "pwcmp":
        _applockValue.pwCmp();
        break;
    }
  }
}

class AppLockModel {
  late List<String> tmpapplockpw;
  late List<String> applockpwcheck;

  bool firstInput = false;
  bool verifyCompl = false;
  int inputPwLength = 0;

  AppLockModel(_tmpapplockpw) {
    tmpapplockpw = _tmpapplockpw;
  }
  initPw() {
    print("initPw");
    tmpapplockpw = ['_', '_', '_', '_'];
    firstInput = false;
    verifyCompl = false;
    inputPwLength = 0;
  }

  inputPw(String inputpw) {
    print("inputPw");
    if (inputPwLength <= 3) {
      tmpapplockpw[inputPwLength] = inputpw;
      inputPwLength += 1;
    }
    print("inputPwLength $inputPwLength $tmpapplockpw");
  }

  removePw() {
    print("removePw");
    if (inputPwLength != 0) {
      inputPwLength -= 1;
      tmpapplockpw[inputPwLength] = "_";
    }
    print("inputPwLength $inputPwLength $tmpapplockpw");
  }

  firstInputPwCompl() {
    print("firstInputPwCompl");
    firstInput = true;
    applockpwcheck = [...tmpapplockpw];
    tmpapplockpw = ["_", "_", "_", "_"];
    inputPwLength = 0;

    print("엥");
  }

  bool pwCmp() {
    print("pwCmp");
    if (listEquals(applockpwcheck, tmpapplockpw)) {
      verifyCompl = true;
    } else {
      verifyCompl = false;
    }
    return verifyCompl;
  }
}

class PopUp extends StatelessWidget {
  const PopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.error_outline,
        size: 35,
      ),
      content: const SizedBox(
        height: 50,
        child: Column(
          children: [
            NanumTitleText(
              text: '비밀번호 설정 확인 오류',
              fontWeight: FontWeight.bold,
            ),
            NanumBodyText(
              text: '이전 입력하신 비밀번호와 다릅니다.',
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width - 180, 40),
              backgroundColor: Colors.green,
            ),
            child: const NanumBodyText(
              text: '확인',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
