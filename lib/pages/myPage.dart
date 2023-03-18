import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/LoginVerify.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/pages/lockPage.dart';
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
class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPage();
}

class _MyPage extends State<MyPage> {
  late HomeProvider _homeProvider;
  final storage = const FlutterSecureStorage();
  String? userName;

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // getUserName();

    _homeProvider = context.watch<HomeProvider>();

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 60,
          backgroundColor: Colors.white, //배경 색
          elevation: 0.0, //그림자 효과 해제
          // leading: Container(
          //   padding: const EdgeInsets.only(left: 10),
          //   child: Image.asset(
          //     'assets/images/home_logo.png',
          //     color: Colors.green,
          //   ),
          // ),
          // leadingWidth: 150,
          // actions: [
          //   IconButton(
          //     icon: const Icon(Icons.notifications_none),
          //     color: Colors.black,
          //     iconSize: 25,
          //     onPressed: () => {},
          //   ),
          //   IconButton(
          //     icon: const Icon(Icons.menu),
          //     color: Colors.black,
          //     iconSize: 25,
          //     onPressed: () => {
          //       context.read<BottomNavigationProvider>().updateCurrentPage(4)
          //     },
          //   ),
          //   const SizedBox(
          //     width: 10,
          //   ),
          // ],
        ),
        body: SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // ignore: unrelated_type_equality_checks
              // First(context),
              // Container(
              //   height: 0.7,
              //   color: Colors.grey,
              // ),

              Center(
                child: Container(
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.12,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.grey[200]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: screenWidth * 0.05),
                          Icon(
                            Icons.person,
                            size: screenWidth * 0.1,
                            color: Colors.black,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          NanumText(
                            text: _homeProvider.loginValue!.name,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          )
                        ],
                      ),
                      IconButton(
                          iconSize: screenWidth * 0.1,
                          onPressed: () {},
                          icon: const Icon(Icons.chevron_right),
                          color: Colors.black),
                    ],
                  ),
                ),
              ),
              // Container(
              //   height: 0.7,
              //   color: Colors.grey,
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ApplicationLock()));
                      },
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: AppTheme.widgetpadding,
                        height: screenHeight * 0.07,
                        child: Row(children: [
                          Icon(
                            Icons.lock_outline,
                            size: screenWidth * 0.06,
                            color: Colors.grey,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          const NanumText(
                            text: "비밀번호 잠금",
                            color: Colors.black,
                            fontSize: 13,
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
              ),

              // Container(
              //   height: screenHeight * 0.06,
              //   // color: Colors.grey,
              // ),
              Container(
                height: 0.7,
                color: Colors.grey,
              ),
              // SizedBox(width: screenWidth * 0.03),
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        webView("개인정보처리방침",
                            "https://ringed-rutabaga-f09.notion.site/bee487fc6fdb418292d2a5f352f32469");
                      },
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: AppTheme.widgetpadding,
                        height: screenHeight * 0.07,
                        child: Row(children: [
                          Icon(
                            Icons.assignment_outlined,
                            size: screenWidth * 0.06,
                            color: Colors.grey,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          const NanumText(
                            text: "개인정보처리방침",
                            color: Colors.black,
                            fontSize: 13,
                          )
                        ]),
                      ),
                    ),
                    // Container(
                    //   height: 0.4,
                    //   color: Colors.grey,
                    // ),
                    GestureDetector(
                      onTap: () {
                        webView("개인정보(민감정보) 수집 및 이용 동의",
                            "https://ringed-rutabaga-f09.notion.site/4f6734367bf14be98688c6acccfdd6df");
                      },
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: AppTheme.widgetpadding,
                        height: screenHeight * 0.07,
                        child: Row(children: [
                          Icon(
                            Icons.assignment_outlined,
                            size: screenWidth * 0.06,
                            color: Colors.grey,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          const NanumText(
                            text: "개인정보(민감정보) 수집 및 이용 동의",
                            color: Colors.black,
                            fontSize: 13,
                          )
                        ]),
                      ),
                    ),
                    // Container(
                    //   height: 0.4,
                    //   color: Colors.grey,
                    // ),
                    GestureDetector(
                      onTap: () {
                        webView("서비스 이용약관",
                            "https://ringed-rutabaga-f09.notion.site/55ed2ee6c3914158a2f0b89434d1add9");
                      },
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: AppTheme.widgetpadding,
                        height: screenHeight * 0.07,
                        child: Row(children: [
                          Icon(
                            Icons.assignment_outlined,
                            size: screenWidth * 0.06,
                            color: Colors.grey,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          const NanumText(
                            text: "서비스 이용약관",
                            color: Colors.black,
                            fontSize: 13,
                          )
                        ]),
                      ),
                    ),
                    // Container(
                    //   height: screenHeight * 0.005,
                    //   color: Colors.grey,
                    // ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) {
                              return const QuitPopUp();
                            });
                      },
                      child: Container(
                        decoration: const BoxDecoration(color: Colors.white),
                        padding: AppTheme.widgetpadding,
                        height: screenHeight * 0.07,
                        child: Row(children: [
                          Icon(
                            Icons.close,
                            size: screenWidth * 0.06,
                            color: Colors.grey,
                          ),
                          SizedBox(width: screenWidth * 0.03),
                          const NanumText(
                            text: "회원탈퇴",
                            color: Colors.black,
                            fontSize: 13,
                          )
                        ]),
                      ),
                    ),
                  ],
                ),
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
                title: NanumTitleText(
                  text: title,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
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
}

class QuitPopUp extends StatefulWidget {
  const QuitPopUp({super.key});

  // late HomeProvider _homeProvider;
  // const QuitPopUp({
  //   Key? key,
  //   required this.homeProvider,
  // }) : super(key: key);
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
            NanumTitleText(
              text: '회원탈퇴',
              fontWeight: FontWeight.bold,
            ),
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
            NanumTitleText(
              text: '로그아웃',
              fontWeight: FontWeight.bold,
            ),
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
                          text: widget.item.data,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
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
