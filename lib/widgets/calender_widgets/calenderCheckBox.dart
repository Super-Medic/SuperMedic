import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:super_medic/function/model.dart';

class CalCustomCheckBox extends StatefulWidget {
  final Check item;
  final bool last;
  const CalCustomCheckBox({
    super.key,
    required this.item,
    required this.last,
  });

  @override
  State<CalCustomCheckBox> createState() => _CalCustomCheckBoxState();
}

class _CalCustomCheckBoxState extends State<CalCustomCheckBox> {
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
              onChanged: (val) {},
              activeBgColor: Colors.green,
              activeIcon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
              activeBorderColor: Colors.green,
              inactiveBorderColor: Colors.redAccent,
              inactiveIcon: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.white),
                child: Icon(
                  Icons.close,
                  color: Colors.red,
                ),
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
}
