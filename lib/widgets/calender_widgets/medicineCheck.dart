import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:super_medic/widgets/calender_widgets/customCheckBox.dart';

class MediCheck extends StatefulWidget {
  final List<Item> items;
  final String medicine;
  const MediCheck({super.key, required this.items, required this.medicine});

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
            text: widget.medicine,
            fontSize: 20,
            color: Colors.green,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 15, left: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 40),
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
