import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/function/model.dart';
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
    final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
          //모서리를 둥글게
          borderRadius: BorderRadius.circular(0)),
      minimumSize: Size(screenWidth, screenHeight * 0.07),
      backgroundColor: Colors.green,
      foregroundColor: Colors.green[900],
      elevation: 0.0,
    );

    return SafeArea(
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
                  controller: NoteText,
                  decoration: const InputDecoration(
                    labelText: 'NoteText',
                    floatingLabelStyle: TextStyle(color: Colors.greenAccent),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.greenAccent),
                    ),
                  ),
                  strutStyle: const StrutStyle())
            ],
          ),
        ),
        bottomSheet: ElevatedButton(
          // style: style,
          style: style,

          child: const NanumTitleText(text: '저장', color: Colors.white),
          onPressed: () async {
            if (NoteText.text == "") {
              null;
            } else {
              if (await secure_storage(DateTime.now(), NoteText.text) == true) {
                // ignore: use_build_context_synchronously
                Provider.of<HomeProvider>(context, listen: false)
                    .noteTextgetData();
                // ignore: use_build_context_synchronously
                Navigator.pop(context);
              } else {
                null;
              }
            }
          },
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
secure_storage(DateTime DateTime, String NoteText) async {
  const storage = FlutterSecureStorage();
  var val = jsonEncode(NoteModel(
      DateFormat('yyyy년 M월 d일 E요일', 'ko').format(DateTime),
      DateFormat('h:m', 'ko').format(DateTime),
      NoteText));
  try {
    // 데이터 저장
    await storage.write(
        key: 'Note_${DateFormat('yyyy-M-d-h-m-s', 'ko').format(DateTime)}',
        value: val);
    String? keyValue = await storage.read(key: 'NoteText');
    if (keyValue == null) {
      await storage.write(
          key: 'NoteText',
          value: 'Note_${DateFormat('yyyy-M-d-h-m-s', 'ko').format(DateTime)}');
    } else {
      keyValue +=
          // ignore: prefer_adjacent_string_concatenation
          ',' + 'Note_${DateFormat('yyyy-M-d-h-m-s', 'ko').format(DateTime)}';
      await storage.write(key: 'NoteText', value: keyValue);
    }
    return true;
  } catch (_) {
    return false;
  }
}
