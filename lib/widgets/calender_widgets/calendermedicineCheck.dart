import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:super_medic/widgets/calender_widgets/calenderCheckBox.dart';
import 'package:http/http.dart' as http;

class CalMediCheck extends StatefulWidget {
  final List<Check> items;
  final double pad;

  const CalMediCheck({super.key, required this.items, required this.pad});

  @override
  State<CalMediCheck> createState() => _CalMediCheckState();
}

class _CalMediCheckState extends State<CalMediCheck> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.pad == 15
          ? EdgeInsets.only(left: 15, right: 15)
          : EdgeInsets.only(top: 15, left: 15, right: 15),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(padding: EdgeInsets.only(top: 10)),
          Container(
            padding: const EdgeInsets.only(top: 8, left: 30),
            child: NanumTitleText(
              text: widget.items[0].medicine,
              fontSize: 20,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          Container(
            padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.only(left: widget.pad),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  for (var i = 0; i < widget.items.length; i++)
                    CalCustomCheckBox(
                      item: widget.items[i],
                      last: widget.items.length - 1 == i ? true : false,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
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
