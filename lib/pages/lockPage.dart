import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/pages/mainPage.dart';
//스타일
import 'package:super_medic/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/themes/textstyle.dart';

// ignore: must_be_immutable
class ApplicationLock extends StatefulWidget {
  String type;
  ApplicationLock(String type, {Key? key})
      : type = type,
        super(key: key);

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
    var screenHeight = MediaQuery.of(context).size.height * 0.93 -
        kBottomNavigationBarHeight -
        MediaQuery.of(context).padding.top;

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
      backgroundColor:
          _applockValue.inputPwLength == 4 ? Colors.green : Colors.grey,
      body: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
              leading: widget.type == "init"
                  ? IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                      //replace with our own icon data.
                    )
                  : null,
              title:
                  NanumTitleText(text: widget.type == "init" ? "비밀번호 설정" : ""),
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
              widget.type == "init"
                  ? TextButton(
                      style: style,
                      // 입력한 비밀번호가 4자리일 경우
                      onPressed: _applockValue.inputPwLength == 4
                          ? () async {
                              // 비밀번호 검증인 경우
                              // if (widget.type == "verify") {
                              //   if (await _applockValue.verifyPw() == true) {
                              //     if (!mounted) return;
                              //     Navigator.push(
                              //       context,
                              //       MaterialPageRoute(
                              //           builder: (context) => const MainPage()),
                              //     );
                              //   } else {
                              //     if (!mounted) return;
                              //     showDialog(
                              //         context: context,
                              //         barrierDismissible: false,
                              //         builder: (context) {
                              //           return PopUp(
                              //               title: '비밀번호 확인 오류',
                              //               body: '등록된 비밀번호가 아닙니다.');
                              //         });
                              //     setState(() {
                              //       updateApplockValue("init", "");
                              //     });
                              //   }
                              // }
                              // 비밀번호 초기화인 경우
                              // else
                              if (widget.type == "init") {
                                // 비밀번호 1차만 입력될 경우
                                if (_applockValue.firstInput == false) {
                                  setState(() {
                                    updateApplockValue("firstpwcompl", "");
                                  });
                                }
                                // 비밀번호 2차까지 입력될 경우
                                else {
                                  setState(() {
                                    updateApplockValue("pwcmp", "");
                                    // 1차, 2차 비밀번호가 다를 경우
                                    if (_applockValue.verifyCompl == false) {
                                      showDialog(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return PopUp(
                                              title: '비밀번호 설정 확인 오류',
                                              body: '이전 입력하신 비밀번호와 다릅니다.');
                                        },
                                      );
                                      updateApplockValue("init", "");
                                    }
                                    // 비밀번호 설정이 완료된 경우
                                    else {
                                      saveSecureStorage(
                                          "AppLockPw",
                                          jsonEncode(
                                              _applockValue.applockpwcheck));

                                      Provider.of<HomeProvider>(context,
                                              listen: false)
                                          .checkAppLockState();
                                      Navigator.of(context).pop();
                                    }
                                  });
                                }
                              }
                            }
                          : null,
                      child: NanumTitleText(
                        text: _applockValue.firstInput == false
                            ? widget.type == "verify"
                                ? "확인"
                                : "다음"
                            : "저장",
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ))
                  : const SizedBox(),
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
          onPressed: () async {
            await updateApplockValue(type, num);
            setState(() {});

            if (widget.type == "verify" && _applockValue.inputPwLength == 4) {
              if (await _applockValue.verifyPw() == true) {
                if (!mounted) return;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MainPage()),
                );
              } else {
                if (!mounted) return;
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return PopUp(
                          title: '비밀번호 확인 오류', body: '등록된 비밀번호가 아닙니다.');
                    });
                setState(() {
                  updateApplockValue("init", "");
                });
              }
            }
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
    tmpapplockpw = ['_', '_', '_', '_'];
    firstInput = false;
    verifyCompl = false;
    inputPwLength = 0;
  }

  inputPw(String inputpw) {
    if (inputPwLength <= 3) {
      tmpapplockpw[inputPwLength] = inputpw;
      inputPwLength += 1;
    }
  }

  removePw() {
    if (inputPwLength != 0) {
      inputPwLength -= 1;
      tmpapplockpw[inputPwLength] = "_";
    }
  }

  firstInputPwCompl() {
    firstInput = true;
    applockpwcheck = [...tmpapplockpw];
    tmpapplockpw = ["_", "_", "_", "_"];
    inputPwLength = 0;
  }

  bool pwCmp() {
    if (listEquals(applockpwcheck, tmpapplockpw)) {
      verifyCompl = true;
    } else {
      verifyCompl = false;
    }
    return verifyCompl;
  }

  Future<bool> verifyPw() async {
    const storage = FlutterSecureStorage();
    var savedPw = jsonDecode(await storage.read(key: "AppLockPw") as String)
        .cast<String>();

    if (listEquals(savedPw, tmpapplockpw)) {
      return true;
    } else {
      return false;
    }

// }
  }
}

class PopUp extends StatelessWidget {
  PopUp({required this.title, required this.body, super.key});
  String title;
  String body;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.error_outline,
        size: 35,
      ),
      content: SizedBox(
        height: 50,
        child: Column(
          children: [
            NanumTitleText(
              text: title,
              fontWeight: FontWeight.bold,
            ),
            NanumBodyText(
              text: body,
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

saveSecureStorage(String key, String data) async {
  const storage = FlutterSecureStorage();
  await storage.write(key: key, value: data);
}
