import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_medic/function/kakao_login.dart';
import 'package:super_medic/function/apple_login.dart';
import 'package:super_medic/pages/joinPage.dart';
import 'package:super_medic/pages/selectChronicDisease.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class LoginPage extends StatefulWidget {
  LoginPage({super.key, required this.being});
  bool being;

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  KakaoLogin kakaologin = KakaoLogin();
  AppleLogin applelogin = AppleLogin();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    const String imageLogoName = 'assets/images/main_logo.png';
    const String imagekakaoLoginName =
        'assets/images/kakao_login_large_wide.png';
    const String imagenaverLoginName = 'assets/images/naver_login.png';
    const String imageAppleLoginName = 'assets/images/apple_login.png';

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    // ignore: no_leading_underscores_for_local_identifiers
    void _showAlert({String? title, String? message}) {
      showCupertinoDialog(
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              title: Text(title!),
              content: Text(message!),
              actions: [
                CupertinoDialogAction(
                    isDefaultAction: true,
                    child: const Text("확인"),
                    onPressed: () {
                      Navigator.pop(context);
                    })
              ],
            );
          });
    }

    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        // backgroundColor: hexToColor('#6F22D2'),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: screenHeight * 0.25),
            Image.asset(
              imageLogoName,
              width: screenWidth * 0.6,
              height: screenHeight * 0.2,
            ),
            const Expanded(flex: 3, child: SizedBox()),
            Expanded(
                flex: 1,
                child: isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.green,
                      )
                    : const SizedBox()),
            const Expanded(flex: 4, child: SizedBox()),
            InkWell(
              child: Image.asset(
                imagekakaoLoginName,
                width: screenWidth * 0.7,
                height: screenHeight * 0.07,
              ),
              onTap: () async {
                setState(() {
                  isLoading = true;
                });
                var result = await kakaologin.signInWithKakao();
                setState(() {
                  isLoading = false;
                });
                // ignore: unrelated_type_equality_checks
                if (result == "true") {
                  if (!widget.being) {
                    KakaoLogin loginBeing = KakaoLogin();
                    bool value = await loginBeing.KakaoLoginBeing();
                    if (value) {
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const SelectChronicDisease()));
                    } else {
                      _showAlert(title: "로그인 실패", message: "다시 시도해주세요");
                    }
                  }
                } else if (result == "false") {
                  // ignore: use_build_context_synchronously
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JoinPage(
                                platform: 'kakao',
                              )));
                  // ignore: use_build_context_synchronously
                } else {
                  _showAlert(title: "로그인 실패", message: "다시 시도해주세요");
                }
              },
            ),
            Container(
              padding: EdgeInsets.only(bottom: screenWidth * 0.01),
              child: InkWell(
                  child: Image.asset(
                    imagenaverLoginName,
                    width: screenWidth * 0.7,
                    height: screenHeight * 0.07,
                  ),
                  onTap: () async {
                    _showAlert(
                        title: "서비스 준비중",
                        message: "서비스 준비중입니다.\n카카오 로그인으로 시도해주세요.");
                  }),
            ),
            // ignore: unrelated_type_equality_checks
            if (SignInWithApple.isAvailable() != 'false')
              InkWell(
                child: Image.asset(
                  imageAppleLoginName,
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.07,
                ),
                onTap: () async {
                  setState(() {
                    isLoading = true;
                  });
                  var result = await applelogin.signInWithApple();
                  setState(() {
                    isLoading = false;
                  });
                  // ignore: unrelated_type_equality_checks
                  try {
                    if (await applelogin.AppleUidVerifiy2(result) == 0) {
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => JoinPage(
                            platform: 'apple',
                            credential: result,
                          ),
                        ),
                      );
                    } else {
                      _showAlert(title: "로그인 실패", message: "다시 시도해주세요");
                    }
                  } catch (context) {
                    _showAlert(title: "로그인 실패", message: "다시 시도해주세요");
                  }
                },
              ),
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
    );
  }
}
