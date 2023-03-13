import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart';
import 'package:super_medic/widgets/mainPage_widgets/present_time.dart';

// ignore: must_be_immutable
class NoteRecodePage extends StatelessWidget {
  NoteRecodePage({super.key});
  // ignore: unused_field
  late HomeProvider _homeProvider;
  // ignore: non_constant_identifier_names
  var NoteText = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final ButtonStyle style = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
          //모서리를 둥글게
          borderRadius: BorderRadius.circular(0)),
      minimumSize: Size(screenWidth, screenHeight * 0.07),
      backgroundColor: Colors.green,
      disabledBackgroundColor: Colors.grey,
      foregroundColor: Colors.green[900],
      elevation: 0.0,
    );

    return Scaffold(
      backgroundColor: NoteText.text != "" ? Colors.green : Colors.grey,
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
            toolbarHeight: 48,
            backgroundColor: Colors.white, //배경 색
            elevation: 0.0, //
          ),
          body: Container(
            padding: AppTheme.totalpadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // ignore: prefer_const_literals_to_create_immutables
              children: [
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                const Center(
                  child: NanumTitleText(
                    text: '노트 기록하기',
                    fontSize: 25,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.03,
                ),
                const PresentTime(),
                SizedBox(
                  height: screenHeight * 0.02,
                ),
                TextField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: NoteText,
                    decoration: const InputDecoration(
                      labelText: '오늘 하루를 기록해보세요',
                      floatingLabelStyle: TextStyle(color: Colors.greenAccent),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.greenAccent),
                      ),
                    ),
                    strutStyle: const StrutStyle())
              ],
            ),
          ),
          bottomSheet: TextButton(
            // style: style,
            style: style,
            onPressed: NoteText.text != ""
                ? () async {
                    if (NoteText.text != "") {
                      // print(NoteText.text);
                      await secure_storage(NoteText.text);
                      _homeProvider.noteTextgetData();
                      Navigator.pop(context);
                      // null;/
                    }
                  }
                : null,

            child: const NanumTitleText(text: '저장', color: Colors.white),
          ),
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
secure_storage(String NoteText) async {
  DateTime now = DateTime.now();
  final dateKey = DateFormat('yyyy년MM월dd일').format(DateTime.now());

  const storage = FlutterSecureStorage();

  dynamic Notes = await storage.read(key: "Notes");

  Notes ??= "{}"; // 저장된 Notes가 없을 경우
  Notes = jsonDecode(Notes as String);

  Notes[dateKey] = NoteText;
  storage.write(key: "Notes", value: jsonEncode(Notes));
}
