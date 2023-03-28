import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:super_medic/function/LoginVerify.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart'; //스타일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:restart_app/restart_app.dart';

import 'package:getwidget/getwidget.dart';
import 'package:super_medic/widgets/forAuth_widget/itemClass.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:super_medic/main.dart';

// ignore: must_be_immutable
class UserInfoPage extends StatefulWidget {
  const UserInfoPage({Key? key}) : super(key: key);

  @override
  State<UserInfoPage> createState() => _UserInfoPage();
}

class _UserInfoPage extends State<UserInfoPage> {
  late HomeProvider _homeProvider;
  final storage = const FlutterSecureStorage();
  String? userName;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    _homeProvider = context.watch<HomeProvider>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.black,
            icon: const Icon(Icons.chevron_left, size: 40),
          ),
          leadingWidth: 30,
          toolbarHeight: 60,
          backgroundColor: Colors.white, //배경 색
          elevation: 0.0, //그림자 효과 해제
          title: const NanumTitleText(text: "마이페이지", fontSize: 20),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // Center(
              //   child: Container(
              //     width: screenWidth * 0.7,
              //     height: screenHeight * 0.12,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(25),
              //         color: Colors.grey[200]),
              //     child: const Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [],
              //     ),
              //   ),
              // ),

              Container(
                padding: AppTheme.widgetpadding,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: CommonColor.widgetbackgroud,
                  // borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: CommonColor.boxshadowcolor.withOpacity(0.02),
                      spreadRadius: 3,
                      blurRadius: 7,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //     print("알림 설정");
                    //   },
                    //   child: Container(
                    //     decoration: const BoxDecoration(color: Colors.white),
                    //     padding: AppTheme.widgetpadding,
                    //     height: screenHeight * 0.07,
                    //     child: Row(children: [
                    //       Icon(
                    //         Icons.notifications_active_outlined,
                    //         size: screenWidth * 0.06,
                    //         color: Colors.grey,
                    //       ),
                    //       SizedBox(width: screenWidth * 0.03),
                    //       const NanumText(
                    //         text: "알림 설정",
                    //         color: Colors.black,
                    //         fontSize: 13,
                    //       )
                    //     ]),
                    //   ),
                    // ),

                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      padding: AppTheme.detailpadding,
                      height: screenHeight * 0.07,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const NanumText(
                              text: "이름",
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            NanumText(
                              text: _homeProvider.loginValue!.name,
                              color: Colors.black,
                              fontSize: 17,
                            )
                          ]),
                    ),

                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      padding: AppTheme.detailpadding,
                      height: screenHeight * 0.07,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const NanumText(
                              text: "생년월일",
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            NanumText(
                              text: birthdayForm(
                                  _homeProvider.loginValue!.birthday),
                              color: Colors.black,
                              fontSize: 17,
                            )
                          ]),
                    ),
                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      padding: AppTheme.detailpadding,
                      height: screenHeight * 0.07,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const NanumText(
                              text: "성별",
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            NanumText(
                              text: _homeProvider.loginValue!.gender == "1"
                                  ? "남"
                                  : "여",
                              color: Colors.black,
                              fontSize: 17,
                            )
                          ]),
                    ),
                    Container(
                      decoration: const BoxDecoration(color: Colors.white),
                      padding: AppTheme.detailpadding,
                      height: screenHeight * 0.07,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const NanumText(
                              text: "이메일 주소",
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            NanumText(
                              text: _homeProvider.loginValue!.email,
                              color: Colors.black,
                              fontSize: 17,
                            )
                          ]),
                    ),
                  ],
                ),
              ),

              Container(
                height: 0.7,
                color: Colors.grey,
              ),

              SizedBox(
                height: screenHeight * 0.01,
              ),
              // const RecentMedicationHistory(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              // const RecentMedicalRecords(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              // const ImmunizationHistory(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              // const LinkedHealthData(),
              SizedBox(
                height: screenHeight * 0.03,
              ),

              SizedBox(
                height: screenHeight * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }

  webView(String title, String URL) {
    return Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => Scaffold(
            backgroundColor: CommonColor.background,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50.0),
              child: AppBar(
                backgroundColor: CommonColor.background,
                elevation: 0.0,
                title: NanumTitleText(text: title, fontSize: 15),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  color: const Color.fromRGBO(0, 0, 0, 1.0),
                  icon: const Icon(Icons.arrow_back_ios_new),
                  iconSize: 30,
                ),
              ),
            ),
            body: WebView(
              initialUrl: URL,
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              userAgent: "random",
            ),
          ),
        ));
  }

  String birthdayForm(String birthday) {
    String birthYear = birthday.substring(0, 2);
    final nowYear = DateFormat('yy').format(DateTime.now());

    birthYear = int.parse(birthYear) > int.parse(nowYear)
        ? "19$birthYear"
        : "20$birthYear";

    String month = birthday.substring(2, 4);
    month = int.parse(month).toString();

    String day = birthday.substring(4, 6);
    day = int.parse(day).toString();

    return "$birthYear년 $month월 $day일";
  }
}

class QuitPopUp extends StatefulWidget {
  const QuitPopUp({super.key});

  @override
  State<QuitPopUp> createState() => _QuitPopUpState();
}

class _QuitPopUpState extends State<QuitPopUp> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      icon: const Icon(
        Icons.error_outline,
        size: 35,
      ),
      content: const SizedBox(
        height: 60,
        child: Column(
          children: [
            NanumTitleText(text: '회원탈퇴'),
            NanumBodyText(
              text: '회원탈퇴 시 모든 정보 및 기록이 소멸됩니다.',
              fontSize: 12,
            ),
            // SizedBox(height: 5),
            // SizedBox(height: 5),
            NanumBodyText(
              text: '회원탈퇴 하시겠습니까?',
              fontSize: 12,
            ),
          ],
        ),
      ),
      actions: [
        Center(
            child: Row(children: [
          TextButton(
            onPressed: () async {
              await deleteSecureStorage();
              RestartWidget.restartApp(context);
            },
            style: TextButton.styleFrom(
              minimumSize: Size(screenWidth * 0.35, screenHeight * 0.04),
              backgroundColor: Colors.green,
            ),
            child: const NanumBodyText(
              text: '네',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: screenWidth * 0.01),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              minimumSize: Size(screenWidth * 0.35, screenHeight * 0.04),
              backgroundColor: Colors.green,
            ),
            child: const NanumBodyText(
              text: '아니오',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ]))
      ],
    );
  }

  void _showAlert({String? title, String? message}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title:
                Text(title!, style: const TextStyle(fontFamily: 'NotoSansKR')),
            content: Text(message!,
                style: const TextStyle(fontFamily: 'NotoSansKR')),
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

class LogoutPopUp extends StatelessWidget {
  const LogoutPopUp(HomeProvider homeProvider, {super.key});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      icon: const Icon(
        Icons.error_outline,
        size: 35,
      ),
      content: const SizedBox(
        height: 50,
        child: Column(
          children: [
            NanumTitleText(text: '로그아웃'),
            NanumBodyText(
              text: '로그아웃 하시겠습니까?',
            ),
          ],
        ),
      ),
      actions: [
        Center(
            child: Row(children: [
          TextButton(
            onPressed: () {
              Restart.restartApp();
            },
            style: TextButton.styleFrom(
              minimumSize: Size(screenWidth * 0.35, screenHeight * 0.04),
              backgroundColor: Colors.green,
            ),
            child: const NanumBodyText(
              text: '네',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: screenWidth * 0.01),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              minimumSize: Size(screenWidth * 0.35, screenHeight * 0.04),
              backgroundColor: Colors.green,
            ),
            child: const NanumBodyText(
              text: '아니오',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ]))
      ],
    );
  }
}

class CustomCheckBox extends StatefulWidget {
  final Item item;
  final Function func;
  const CustomCheckBox({
    super.key,
    required this.item,
    required this.func,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 0, 35),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
          child: GFCheckbox(
            size: 25,
            type: GFCheckboxType.circle,
            onChanged: (value) {
              setState(() {
                widget.item.isChecked = value;
                widget.func(value);
              });
            },
            value: widget.item.isChecked,
            activeBgColor: CommonColor.background,
            inactiveBgColor: CommonColor.background,
            activeBorderColor: CommonColor.background,
            inactiveBorderColor: CommonColor.background,
            // ignore: prefer_const_constructors
            inactiveIcon: Icon(
              Icons.check,
              size: 20,
              color: Colors.grey,
            ),
            activeIcon: const Icon(
              Icons.check,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 70,
          height: 40,
          child: ListTile(
            title: NanumBodyText(
              text: widget.item.data,
              color: Colors.black,
              textAlign: TextAlign.left,
            ),
            trailing: const Icon(
              Icons.navigate_next,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    backgroundColor: CommonColor.background,
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(50.0),
                      child: AppBar(
                        backgroundColor: CommonColor.background,
                        elevation: 0.0,
                        title: NanumTitleText(
                            text: widget.item.data, fontSize: 15),
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: const Color.fromRGBO(0, 0, 0, 1.0),
                          icon: const Icon(Icons.arrow_back_ios_new),
                          iconSize: 30,
                        ),
                      ),
                    ),
                    body: WebView(
                      initialUrl: widget.item.page,
                      javascriptMode: JavascriptMode.unrestricted,
                      gestureNavigationEnabled: true,
                      userAgent: "random",
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
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

class LockUnsetPopUp extends StatefulWidget {
  const LockUnsetPopUp({super.key});

  @override
  State<LockUnsetPopUp> createState() => _LockUnsetPopUpState();
}

class _LockUnsetPopUpState extends State<LockUnsetPopUp> {
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return AlertDialog(
      icon: const Icon(
        Icons.error_outline,
        size: 35,
      ),
      content: const SizedBox(
        height: 60,
        child: Column(
          children: [
            NanumTitleText(text: '잠금 설정 해제'),
            NanumBodyText(
              text: '어플리케이션 잠금을 해제 하시겠습니까?',
              fontSize: 12,
            ),
          ],
        ),
      ),
      actions: [
        Center(
            child: Row(children: [
          TextButton(
            onPressed: () async {
              await unsetAppLock();
              Provider.of<HomeProvider>(context, listen: false)
                  .checkAppLockState();

              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              minimumSize: Size(screenWidth * 0.35, screenHeight * 0.04),
              backgroundColor: Colors.green,
            ),
            child: const NanumBodyText(
              text: '네',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: screenWidth * 0.01),
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              minimumSize: Size(screenWidth * 0.35, screenHeight * 0.04),
              backgroundColor: Colors.green,
            ),
            child: const NanumBodyText(
              text: '아니오',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ]))
      ],
    );
  }

  void _showAlert({String? title, String? message}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title:
                Text(title!, style: const TextStyle(fontFamily: 'NotoSansKR')),
            content: Text(message!,
                style: const TextStyle(fontFamily: 'NotoSansKR')),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: const Text("확인",
                    style: TextStyle(fontFamily: 'NotoSansKR')),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  unsetAppLock() async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: "AppLockPw");
  }
}

unsetAppLock() async {
  const storage = FlutterSecureStorage();
  var tmp1 = await storage.read(key: "AppLockPw");
}
