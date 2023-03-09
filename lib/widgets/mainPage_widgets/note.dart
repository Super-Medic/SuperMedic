import 'package:flutter/material.dart';
import 'package:super_medic/pages/note_recordPage.dart';
import 'package:super_medic/themes/textstyle.dart';
//폰트 설정 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/theme.dart';

class Note extends StatelessWidget {
  const Note({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: CommonColor.widgetbackgroud,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: CommonColor.boxshadowcolor.withOpacity(0.02),
              spreadRadius: 3,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: AppTheme.widgetpadding,
              padding: const EdgeInsets.only(left: 15, top: 8),
              child: const InkWell(
                child: Row(
                  children: [
                    NanumTitleText(
                      text: '노트',
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                    // Icon(
                    //   Icons.chevron_right,
                    //   weight: 900,
                    //   color: Colors.black,
                    // ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 20),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NoteRecodePage()),
                  );
                },
                style: TextButton.styleFrom(
                  backgroundColor: CommonColor.buttoncolor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                ),
                child: const Row(
                  //spaceEvenly: 요소들을 균등하게 배치하는 속성
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 18,
                    ),
                    NanumTitleText(
                      text: '오늘기록  ',
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
