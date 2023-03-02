import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import "package:flutter/material.dart";
import 'package:super_medic/themes/textstyle.dart'; //폰
import 'package:super_medic/widgets/calender_widgets/calender_widgets.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:super_medic/widgets/calender_widgets/medicineCheck.dart';
import 'package:super_medic/pages/add_medicine.dart';

class MedicinePage extends StatefulWidget {
  const MedicinePage({super.key});

  @override
  State<MedicinePage> createState() => _MedicinePageState();
}

class _MedicinePageState extends State<MedicinePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Item> items = List.empty(growable: true);
    items.add(Item(data: "전체동의", isChecked: false));
    items.add(Item(data: "전체동의", isChecked: false));
    items.add(Item(data: "전체동의", isChecked: false));
    items.add(Item(data: "전체동의", isChecked: false));
    items.add(Item(data: "전체동의", isChecked: false));
    items.add(Item(data: "전체동의", isChecked: false));
    items.add(Item(data: "전체동의", isChecked: false));
    items.add(Item(data: "전체동의", isChecked: false));
    items.add(Item(data: "전체동의", isChecked: false));

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          child: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              backgroundColor: Colors.transparent,
              isScrollControlled: true,
              builder: (BuildContext context) {
                return Container(
                  height: MediaQuery.of(context).size.height * 0.9,
                  decoration: const BoxDecoration(
                    color: Colors.white, // 모달 배경색
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: AddMedicinePage(),
                );
              },
            );
          },
        ),
        backgroundColor: Colors.white,
        appBar: AppBar(
          toolbarHeight: 65,
          backgroundColor: Colors.white,
          elevation: 0.0,
          title: const NanumTitleText(
            text: "복약 알림",
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        body: ContainedTabBarView(
          tabBarProperties: TabBarProperties(
              width: 180,
              height: 42,
              alignment: TabBarAlignment.start,
              labelColor: Colors.black,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.black,
              indicatorPadding: const EdgeInsets.all(0.0),
              unselectedLabelColor: Colors.grey[700]),
          tabs: const [
            NanumBodyText(
              text: '복약알림',
              fontWeight: FontWeight.bold,
            ),
            NanumBodyText(
              text: '복용기록',
              fontWeight: FontWeight.bold,
            )
          ],
          views: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MediCheck(items: items, medicine: '다이그린'),
                  MediCheck(items: items, medicine: '다이그린'),
                ],
              ),
            ),
            TableEventsExample()
          ],
        ),
      ),
    );
  }
}
