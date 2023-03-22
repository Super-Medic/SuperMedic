import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_medic/function/kakao_login.dart';
import 'package:super_medic/function/apple_login.dart';
import 'package:super_medic/pages/selectChronicDisease.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/widgets/forAuth_widget/itemClass.dart';
import 'package:super_medic/widgets/forAuth_widget/customCheckBox.dart';
import 'package:super_medic/widgets/forAuth_widget/customCheckBoxTitle.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class JointosPage extends StatefulWidget {
  JointosPage(
      {Key? key,
      required this.phone,
      required this.telecom,
      required this.frist_number,
      required this.second_number,
      required this.name,
      required this.paltform,
      this.credential})
      : super(key: key);
  String phone;
  String telecom;
  String frist_number;
  String second_number;
  String name;
  String paltform;
  AuthorizationCredentialAppleID? credential;

  @override
  State<JointosPage> createState() => _JointosPage();
}

class _JointosPage extends State<JointosPage> {
  List<Item> items = List.empty(growable: true);
  final Item agree =
      Item(data: "전체동의", page: 'assets/images/tos.png', isChecked: false);

  @override
  void initState() {
    super.initState();
    items.add(Item(
        data: "(필수) 서비스 이용약관",
        page:
            'https://ringed-rutabaga-f09.notion.site/55ed2ee6c3914158a2f0b89434d1add9',
        isChecked: false));
    items.add(Item(
        data: "(필수) 개인정보(민감정보) 수집 및 이용 동의",
        page: 'https://www.notion.so/4f6734367bf14be98688c6acccfdd6df?pvs=4',
        isChecked: false));
  }

  void _showAlert({String? title, String? message}) {
    showCupertinoDialog(
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            title: Text(title!,
                style: const TextStyle(
                  fontFamily: 'NotoSansKR',
                )),
            content: Text(message!,
                style: const TextStyle(
                  fontFamily: 'NotoSansKR',
                )),
            actions: [
              CupertinoDialogAction(
                  isDefaultAction: true,
                  child: const Text("확인",
                      style: TextStyle(
                        fontFamily: 'NotoSansKR',
                      )),
                  onPressed: () {
                    Navigator.pop(context);
                  })
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CommonColor.background,

      // ignore: prefer_const_constructors
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.03,
            ),
            const NanumTitleText(
              text: '약관 내용에 동의해주세요',
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: screenHeight * 0.02,
            ),
            CustomCheckBoxTitle(
              item: agree,
              func: itemChange,
            ),
            SizedBox(
              height: screenHeight * 0.015,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: 2,
                // shrinkWrap: true,
                itemBuilder: (context, index) {
                  return CustomCheckBox(
                    item: items[index],
                    func: checkAll,
                  );
                },
              ),
            ),
            SafeArea(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () async {
                  // ignore: prefer_typing_uninitialized_variables
                  var joinresult;
                  if (widget.paltform == 'kakao') {
                    KakaoLogin kakaologin = KakaoLogin();
                    joinresult = await kakaologin.get_user_join(
                        widget.phone,
                        widget.telecom,
                        widget.frist_number,
                        widget.second_number,
                        widget.name);
                  } else if (widget.paltform == 'apple') {
                    AppleLogin applelogin = AppleLogin();
                    joinresult = await applelogin.get_user_join(
                        widget.phone,
                        widget.telecom,
                        widget.frist_number,
                        widget.second_number,
                        widget.name,
                        widget.credential);
                  }
                  if (joinresult == 'true') {
                    // ignore: use_build_context_synchronously
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectChronicDisease()),
                        (route) => false);
                  } else {
                    // ignore: avoid_print
                    _showAlert(title: "회원가입 실패", message: "다시 시도해주세요");
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor:
                      agree.isChecked == false ? Colors.grey : Colors.green,
                  minimumSize:
                      Size(MediaQuery.of(context).size.width * 0.9, 55),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                ),
                child: const NanumTitleText(
                  text: '확인',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
            const Padding(
              padding: EdgeInsets.all(10),
            )
          ],
        ),
      ),
    );
  }

  void itemChange(bool val) {
    setState(() {
      for (var item in items) {
        item.isChecked = val;
      }
    });
  }

  void checkAll(bool val) {
    setState(() {
      var cnt = 0;
      for (var item in items) {
        cnt = item.isChecked ? cnt + 1 : cnt;
      }
      agree.isChecked = (cnt == items.length) ? true : false;
    });
  }
}
