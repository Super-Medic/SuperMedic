import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:super_medic/widgets/calender_widgets/customCheckBox.dart';
import 'package:http/http.dart' as http;
import 'package:super_medic/pages/medicinePage.dart';

class MediCheckForNotToday extends StatefulWidget {
  final Map<bool, List<Check>> items;
  final double pad;
  const MediCheckForNotToday(
      {super.key, required this.items, required this.pad});

  @override
  State<MediCheckForNotToday> createState() => _MediCheckForNotTodayState();
}

class _MediCheckForNotTodayState extends State<MediCheckForNotToday> {
  @override
  Widget build(BuildContext context) {
    return widget.items.containsKey(true) == true
        ? Container(
            margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 25, left: 30),
                      child: NanumTitleText(
                          text: widget.items[true]![0].medicine,
                          fontSize: 20,
                          color: Colors.green),
                    ),
                    Container(
                        padding: const EdgeInsets.only(right: 15),
                        child: PopupMenuButton(
                          offset: const Offset(10, 30),
                          constraints:
                              const BoxConstraints(minWidth: 30, maxWidth: 70),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          elevation: 0.0,
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.grey,
                          ),
                          color: CommonColor.background,
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                onTap: () async {
                                  await deleteMedicine(
                                      widget.items[true]![0].id);
                                  setState(() {
                                    widget.items.remove(true);
                                  });
                                },
                                height: 30,
                                value: 'delete',
                                child: const Center(
                                    child: Text('삭제',
                                        style: TextStyle(
                                            fontFamily: "NotoSansKR"))),
                              )
                            ];
                          },
                        )),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
                  child: const Center(
                    child: NanumBodyText(
                      text: "오늘은 복용요일이 아닙니다",
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  deleteMedicine(int id) async {
    try {
      String? userEmail;
      const storage = FlutterSecureStorage();
      String? val = await storage.read(key: 'LoginUser');
      if (val != null) {
        userEmail = LoginModel.fromJson(jsonDecode(val)).email;
      }
      final response = await http.post(
        Uri.parse('https://mypd.kr:5000/medicine/delete'),
        body: {"email": userEmail, "id": '$id'},
      );
    } catch (error) {
      print(error);
    }
  }
}
