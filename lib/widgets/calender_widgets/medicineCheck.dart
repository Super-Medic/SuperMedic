import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:super_medic/widgets/calender_widgets/customCheckBox.dart';
import 'package:http/http.dart' as http;
import 'package:super_medic/provider/medicine_provider.dart';

class MediCheck extends StatefulWidget {
  final Map<bool, List<Check>> items;
  final double pad;

  const MediCheck({super.key, required this.items, required this.pad});

  @override
  State<MediCheck> createState() => _MediCheckState();
}

class _MediCheckState extends State<MediCheck> {
  MedicineTake _medicineTake = MedicineTake();

  @override
  Widget build(BuildContext context) {
    _medicineTake = context.watch<MedicineTake>();

    return widget.items.containsKey(true) == true
        ? Container(
            margin: widget.pad == 15
                ? const EdgeInsets.only(left: 15, right: 15)
                : widget.pad == 10
                    ? EdgeInsets.zero
                    : const EdgeInsets.only(top: 15, left: 15, right: 15),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                widget.pad == 10
                    ? Container()
                    : const Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: widget.pad == 10
                          ? const EdgeInsets.only(top: 8, left: 10)
                          : const EdgeInsets.only(top: 8, left: 30),
                      child: NanumTitleText(
                          text: widget.items[true]![0].medicine,
                          fontSize: 20,
                          color: Colors.green),
                    ),
                    Container(
                        padding: const EdgeInsets.only(right: 8),
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
                                          widget.items[true]![0].id)
                                      .then((val) {
                                    _medicineTake.fetchGet();
                                  });
                                  setState(() {
                                    widget.items.remove(true);
                                  });
                                },
                                height: 30,
                                value: 'delete',
                                child: const Center(
                                    child: Text('삭제',
                                        style: TextStyle(
                                            fontFamily: 'NotoSansKR'))),
                              )
                            ];
                          },
                        )),
                  ],
                ),
                Container(
                  padding: widget.pad == 10
                      ? const EdgeInsets.only(top: 8)
                      : const EdgeInsets.only(top: 15, left: 10, bottom: 10),
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
