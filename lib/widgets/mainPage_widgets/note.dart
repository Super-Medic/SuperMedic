import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/pages/note_recordPage.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/textstyle.dart';
//폰트 설정 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/theme.dart';

class Note extends StatefulWidget {
  const Note({
    Key? key,
  }) : super(key: key);

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  late HomeProvider _homeProvider;

  bool isCheckTodayNote(List<NoteTextModel> noteValue) {
    DateTime now = DateTime.now();
    final dateKey = DateFormat('yyyy년MM월dd일').format(DateTime.now());
    bool exist = false;

    if (noteValue.isEmpty == true) {
      return exist;
    } else if (noteValue.isEmpty == false) {
      for (int i = 0; i < noteValue.length; i++) {
        if (noteValue[i].DateTime == dateKey) {
          exist = true;
          break;
        }
      }
    }
    return exist;
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: AppTheme.widgetpadding,
                  padding: const EdgeInsets.only(left: 5, top: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Image.asset(
                        'assets/images/note.png',
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(width: 7),
                      const NanumTitleText(
                        text: '노트',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      // const Icon(
                      //   Icons.chevron_right,
                      //   weight: 900,
                      //   color: Colors.black,
                      // ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(right: 20),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoteRecodePage()),
                      );
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: const Color.fromARGB(30, 76, 175, 79),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13)),
                      padding: const EdgeInsets.symmetric(
                          vertical: 7, horizontal: 7),
                    ),
                    child: const Row(
                      //spaceEvenly: 요소들을 균등하게 배치하는 속성
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.green,
                          size: 20,
                        ),
                        NanumTitleText(
                          text: '오늘기록  ',
                          fontSize: 12,
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          isCheckTodayNote(_homeProvider.noteTextValue)
              ? Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.075,
                      vertical: screenHeight * 0.02),
                  child: noteList(
                      context,
                      _homeProvider
                          .noteTextValue[_homeProvider.noteTextValue.length - 1]
                          .note))
              : Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: const Center(
                      child: NanumBodyText(
                    text: '오늘의 노트를 기록해보세요!',
                    color: Colors.grey,
                  )))
        ],
      ),
    );
  }

  Widget noteList(BuildContext context, String note) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    // print(symptomList);
    return Container(
      // alignment: const Alignment(0, 0),
      child: Text(note, style: const TextStyle(fontFamily: "NotoSansKR")),
    );
  }
}
