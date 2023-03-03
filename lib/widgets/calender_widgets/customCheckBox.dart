import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/function/model.dart';

class CustomCheckBox extends StatefulWidget {
  final Check item;
  final bool last;
  const CustomCheckBox({
    super.key,
    required this.item,
    required this.last,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  String? userEmail;
  @override
  Widget build(BuildContext context) {
    final dot = Container(
        height: 20,
        width: 81,
        // margin: const EdgeInsets.only(left: 2),
        child: DottedLine(
          dashGapLength: 3.0,
          dashRadius: 10.0,
          lineThickness: 2,
          dashColor: widget.item.isChecked
              ? Colors.green
              : Color.fromARGB(255, 110, 110, 110),
        ));
    return Row(
      children: [
        Column(
          children: [
            GFCheckbox(
              size: 40,
              value: widget.item.isChecked,
              type: GFCheckboxType.circle,
              onChanged: (value) async {
                print(value);
                print(value.runtimeType);
                setState(() {
                  widget.item.isChecked = value;
                });
                await postRequest(widget.item.id, value);
              },
              activeBgColor: Colors.green,
              activeIcon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            NanumText(
              text: widget.item.time,
              fontSize: 11,
              color: widget.item.isChecked
                  ? Colors.green
                  : Color.fromARGB(255, 110, 110, 110),
            )
          ],
        ),
        if (widget.last == false) dot,
      ],
    );
  }

  postRequest(id, value) async {
    const storage = FlutterSecureStorage();
    String? val = await storage.read(key: 'LoginUser');
    if (val != null) {
      userEmail = LoginModel.fromJson(jsonDecode(val)).email;
    }
    http.Response response = await http.post(
      Uri.parse('https://mypd.kr:5000/medicine/check'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'email': userEmail,
        'id': '$id',
        'take': (value == true) ? '1' : '0'
      },
    );
  }
}
