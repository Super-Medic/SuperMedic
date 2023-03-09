import 'package:flutter/material.dart';
import 'package:super_medic/pages/jointosPage.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class JoinPage extends StatefulWidget {
  String platform;
  AuthorizationCredentialAppleID? credential;
  JoinPage({super.key, required this.platform, this.credential});

  @override
  _JoinPageState createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final formKey = GlobalKey<FormState>();
  String phone = '';
  String telecom = '';
  final telecom_items = ['SKT', 'KT', 'LG U+'];
  String frist_number = '';
  String second_number = '';
  String name = '';

  @override
  void initState() {
    super.initState();
    setState(() {
      telecom = telecom_items[0];
    });
  }

  renderTextFormField({
    required String label,
    required FormFieldSetter onSaved,
    required FormFieldValidator validator,
    required int maxLength,
    required final height,
  }) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 12.0,
                // fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        TextFormField(
          onSaved: onSaved,
          validator: validator,
          cursorColor: Colors.green,
          maxLength: maxLength,
          decoration: const InputDecoration(
            counterText: '',
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    width: 1.6, color: Color.fromARGB(40, 158, 158, 158))),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.green, width: 1.6),
            ),
          ),
        ),
        Container(height: height),
      ],
    );
  }

  renderButton(height) {
    return SizedBox(
        height: height,
        child: TextButton(
          style: TextButton.styleFrom(backgroundColor: Colors.green),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              // ignore: use_build_context_synchronously
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                builder: (BuildContext context) {
                  return Container(
                    height: 400,
                    decoration: const BoxDecoration(
                      color: Colors.white, // 모달 배경색
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                    ),
                    child: JointosPage(
                      phone: phone,
                      telecom: telecom,
                      frist_number: frist_number,
                      second_number: second_number,
                      name: name,
                      paltform: widget.platform,
                      credential: widget.credential,
                    ),
                  );
                },
              );
            }
          },
          child: const Text(
            '다음',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: CommonColor.background,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          backgroundColor: CommonColor.background,
          elevation: 0.0,
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 20),
        child: Form(
          key: formKey,
          child: Padding(
            padding: AppTheme.totalpadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const NanumTitleText(
                  text: '슈퍼메딕에 오신 것을',
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                const NanumTitleText(
                  text: '환영해요!',
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                renderTextFormField(
                  label: '휴대폰 번호',
                  onSaved: (val) {
                    setState(() {
                      phone = val;
                    });
                  },
                  validator: (val) {
                    if (val.length < 1) {
                      return '휴대폰 번호는 필수 입력사항입니다.';
                    }

                    if (val.length == 12) {
                      return '올바른 휴대폰 번호를 입력해주세요.';
                    }

                    if (!RegExp('[0-9]').hasMatch(val)) {
                      return '숫자만 입력하여 주세요.';
                    }

                    return null;
                  },
                  maxLength: 11,
                  height: screenHeight * 0.025,
                ),
                Column(children: [
                  const Row(
                    children: [
                      Text(
                        '통신사',
                        style: TextStyle(
                          fontSize: 12.0,
                          // fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.07,
                    child: DropdownButtonFormField(
                      value: telecom,
                      icon: const Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(Icons.arrow_drop_down),
                      ),
                      iconSize: 35,
                      decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                width: 1.6,
                                color: Color.fromARGB(40, 158, 158, 158))),
                        focusedBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.green, width: 1.6),
                        ),
                      ),
                      items: telecom_items
                          .map((e) => DropdownMenuItem(
                                value: e, // 선택 시 onChanged 를 통해 반환할 value
                                child: Text(e),
                              ))
                          .toList(),
                      onChanged: (value) {
                        // items 의 DropdownMenuItem 의 value 반환
                        setState(() {
                          telecom = value!;
                        });
                      },
                    ),
                  ),
                ]),
                SizedBox(height: screenHeight * 0.025),
                Row(children: <Widget>[
                  Expanded(
                      flex: 4,
                      child: renderTextFormField(
                        label: '주민등록번호',
                        onSaved: (val) {
                          setState(() {
                            frist_number = val;
                          });
                        },
                        validator: (val) {
                          if (val.length < 1) {
                            return '주민번호는 필수 사항입니다.';
                          }
                          if (!RegExp('[0-9]').hasMatch(val)) {
                            return '숫자만 입력하여 주세요.';
                          }
                          return null;
                        },
                        maxLength: 6,
                        height: screenHeight * 0.025,
                      )),
                  const Expanded(flex: 1, child: Icon(Icons.remove)),
                  Expanded(
                      flex: 1,
                      child: renderTextFormField(
                        label: '',
                        onSaved: (val) {
                          setState(() {
                            second_number = val;
                          });
                        },
                        validator: (val) {
                          if (val.length < 1) {
                            return '';
                          }
                          if (!RegExp('[1-4]').hasMatch(val)) {
                            return '';
                          }
                          return null;
                        },
                        maxLength: 1,
                        height: screenHeight * 0.025,
                      )),
                  const Expanded(
                    flex: 3,
                    child: Text(""),
                  )
                ]),
                renderTextFormField(
                  label: '이름',
                  onSaved: (val) {
                    setState(() {
                      name = val;
                    });
                  },
                  validator: (val) {
                    if (val.length < 1) {
                      return '이름은 필수사항입니다.';
                    }
                    return null;
                  },
                  maxLength: 10,
                  height: screenHeight * 0.025,
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: renderButton(screenHeight * 0.07),
    );
  }
}
