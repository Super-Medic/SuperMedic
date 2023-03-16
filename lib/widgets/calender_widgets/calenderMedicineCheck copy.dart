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

class CalMediCheck extends StatefulWidget {
  final Map<bool, List<Check>> items;
  final double pad;
  const CalMediCheck({super.key, required this.items, required this.pad});

  @override
  State<CalMediCheck> createState() => _CalMediCheckState();
}

class _CalMediCheckState extends State<CalMediCheck> {
  @override
  Widget build(BuildContext context) {
    return widget.items.containsKey(true) == true
        ? Container(
            margin: EdgeInsets.only(top: 15, left: 15, right: 15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 8, left: 30),
                      child: NanumTitleText(
                        text: widget.items[true]![0].medicine,
                        fontSize: 20,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(top: 15, left: 10, bottom: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.only(left: widget.pad),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        for (var i = 0; i < widget.items[true]!.length; i++)
                          CustomCheckBox(
                            item: widget.items[true]![i],
                            last: widget.items[true]!.length - 1 == i
                                ? true
                                : false,
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
