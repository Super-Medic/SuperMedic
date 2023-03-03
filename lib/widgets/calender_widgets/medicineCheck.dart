import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:super_medic/widgets/calender_widgets/customCheckBox.dart';

class MediCheck extends StatefulWidget {
  final List<Check> items;
  final double pad;
  const MediCheck({super.key, required this.items, required this.pad});

  @override
  State<MediCheck> createState() => _MediCheckState();
}

class _MediCheckState extends State<MediCheck> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(top: 25, left: 30),
          child: NanumTitleText(
            text: widget.items[0].medicine,
            fontSize: 20,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15, left: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.only(left: widget.pad),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                for (var i = 0; i < widget.items.length; i++)
                  CustomCheckBox(
                    item: widget.items[i],
                    last: widget.items.length - 1 == i ? true : false,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
