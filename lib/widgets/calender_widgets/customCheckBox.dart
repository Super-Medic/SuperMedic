import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:dotted_line/dotted_line.dart';

class CustomCheckBox extends StatefulWidget {
  final Item item;
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
              onChanged: (value) {
                setState(() {
                  widget.item.isChecked = value;
                });
              },
              activeBgColor: Colors.green,
              activeIcon: const Icon(
                Icons.check,
                color: Colors.white,
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 5)),
            NanumText(
              text: widget.item.data,
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
