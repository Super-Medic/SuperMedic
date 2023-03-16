import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:super_medic/themes/common_color.dart';
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
        width: 52,
        // margin: const EdgeInsets.only(left: 2),
        child: DottedLine(
          dashGapLength: 2.0,
          dashRadius: 10.0,
          lineThickness: 3,
          dashColor: widget.item.isChecked
              ? Colors.green
              : Colors.grey.withOpacity(0.3),
        ));
    return Row(
      children: [
        Column(
          children: [
            GFCheckbox(
              size: GFSize.LARGE,
              value: widget.item.isChecked,
              type: GFCheckboxType.circle,
              onChanged: (value) async {
                setState(() {
                  widget.item.isChecked = value;
                });
                await postRequest(widget.item.id, widget.item.time, value);
              },
              activeBgColor: Colors.green,
              activeIcon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
              activeBorderColor: Colors.green,
              inactiveBorderColor: Colors.grey.withOpacity(0.3),
              inactiveIcon: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    // border: Border.all(color: Colors.grey.withOpacity(0.3)),
                    color: Colors.grey.withOpacity(0.3)),
                child: Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            NanumText(
              text: _changeTime(widget.item.time) +
                  " " +
                  widget.item.time.substring(0, 5),
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

  _changeTime(time) {
    if (time == '12:00 AM') {
      return '오전';
    } else if (time == '12:00 PM') {
      return '오후';
    } else {
      return time.substring(5) == 'AM' ? '오전' : '오후';
    }
  }

  postRequest(id, time, value) async {
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
      body: {'email': userEmail, 'time': time, 'id': '$id', 'take': '$value'},
    );
  }
}
