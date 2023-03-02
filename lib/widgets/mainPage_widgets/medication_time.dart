import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/provider/check_box_provider.dart';
import 'package:super_medic/themes/theme.dart'; //스타일 파일
import 'package:super_medic/themes/common_color.dart';

class MedicationTime extends StatelessWidget {
  const MedicationTime({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late CheckBoxProvider checkBoxProvider = context.watch<CheckBoxProvider>();
    return Column(
      children: [
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: CommonColor.widgetbackgroud,
              borderRadius: BorderRadius.circular(15),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: AppTheme.widgetpadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const NanumTitleText(
                        text: '다이그린',
                        color: Colors.green,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 15, left: 20),
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Transform.scale(
                                      scale: 2.5,
                                      child: Checkbox(
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                                (states) => const BorderSide(
                                                    width: 1,
                                                    color: Colors.grey)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        value: checkBoxProvider.medicine,
                                        onChanged: (value) {
                                          checkBoxProvider.set1(value!);
                                        },
                                        activeColor: Colors.green,
                                        checkColor: Colors.white,
                                      )),
                                  const NanumText(
                                    text: '오전8:00',
                                    fontSize: 10,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Transform.scale(
                                      scale: 2.5,
                                      child: Checkbox(
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                                (states) => const BorderSide(
                                                    width: 1,
                                                    color: Colors.grey)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        value: checkBoxProvider.surgery,
                                        onChanged: (value) {
                                          checkBoxProvider.set2(value!);
                                        },
                                        activeColor: Colors.green,
                                        checkColor: Colors.white,
                                      )),
                                  const NanumText(
                                    text: '오후12:30',
                                    fontSize: 10,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Transform.scale(
                                      scale: 2.5,
                                      child: Checkbox(
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                                (states) => const BorderSide(
                                                    width: 1,
                                                    color: Colors.grey)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        value: checkBoxProvider.obstetrics,
                                        onChanged: (value) {
                                          checkBoxProvider.set3(value!);
                                        },
                                        activeColor: Colors.green,
                                        checkColor: Colors.white,
                                      )),
                                  const NanumText(
                                    text: '오후5:30',
                                    fontSize: 10,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: AppTheme.widgetpadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const NanumTitleText(
                        text: '다이그린',
                        color: Colors.green,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 15, left: 20),
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Transform.scale(
                                      scale: 2.5,
                                      child: Checkbox(
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                                (states) => const BorderSide(
                                                    width: 1,
                                                    color: Colors.grey)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        value: checkBoxProvider.medicine,
                                        onChanged: (value) {
                                          checkBoxProvider.set1(value!);
                                        },
                                        activeColor: Colors.green,
                                        checkColor: Colors.white,
                                      )),
                                  const NanumText(
                                    text: '오전8:00',
                                    fontSize: 10,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Transform.scale(
                                      scale: 2.5,
                                      child: Checkbox(
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                                (states) => const BorderSide(
                                                    width: 1,
                                                    color: Colors.grey)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        value: checkBoxProvider.surgery,
                                        onChanged: (value) {
                                          checkBoxProvider.set2(value!);
                                        },
                                        activeColor: Colors.green,
                                        checkColor: Colors.white,
                                      )),
                                  const NanumText(
                                    text: '오후12:30',
                                    fontSize: 10,
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Transform.scale(
                                      scale: 2.5,
                                      child: Checkbox(
                                        side:
                                            MaterialStateBorderSide.resolveWith(
                                                (states) => const BorderSide(
                                                    width: 1,
                                                    color: Colors.grey)),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        value: checkBoxProvider.obstetrics,
                                        onChanged: (value) {
                                          checkBoxProvider.set3(value!);
                                        },
                                        activeColor: Colors.green,
                                        checkColor: Colors.white,
                                      )),
                                  const NanumText(
                                    text: '오후5:30',
                                    fontSize: 10,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
