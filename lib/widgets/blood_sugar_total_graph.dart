import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/function/model.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_sugar_graph.dart';

class BloodSugarTotalGraph extends StatefulWidget {
  const BloodSugarTotalGraph({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BloodSugarTotalGraphState createState() => _BloodSugarTotalGraphState();
}

class _BloodSugarTotalGraphState extends State<BloodSugarTotalGraph>
    with TickerProviderStateMixin {
  late HomeProvider _homeProvider;

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    List<BloodSugarModel> bloodsugarBefore = [];
    List<BloodSugarModel> bloodsugarAfter = [];
    List<Widget> tabsIndex = [];

    for (int i = 0; i < _homeProvider.bloodSugarValue.length; i++) {
      if (_homeProvider.bloodSugarValue[i].checkbutton == '공복') {
        bloodsugarBefore.add(_homeProvider.bloodSugarValue[i]);
      } else {
        bloodsugarAfter.add(_homeProvider.bloodSugarValue[i]);
      }
    }

    if (bloodsugarBefore.isNotEmpty && bloodsugarAfter.isNotEmpty) {
      tabsIndex.add(const Tab(
        text: "식전혈당",
      ));
      tabsIndex.add(const Tab(
        text: "식후혈당",
      ));
    } else if (bloodsugarBefore.isNotEmpty && bloodsugarAfter.isEmpty) {
      tabsIndex.add(const Tab(
        text: "식전혈당",
      ));
    } else if (bloodsugarBefore.isEmpty && bloodsugarAfter.isNotEmpty) {
      tabsIndex.add(const Tab(
        text: "식후혈당",
      ));
    }
    return DefaultTabController(
      length: tabsIndex.length,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          tabsIndex.isEmpty
              ? const SizedBox.shrink()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TabBar(
                        indicatorColor: Colors.green,
                        labelColor: Colors.green,
                        unselectedLabelColor: Colors.black54,
                        isScrollable: true,
                        tabs: tabsIndex),
                  ],
                ),
          _homeProvider.bloodSugarValue.isEmpty
              ? const SizedBox(
                  height: 40,
                  child: Center(child: NanumBodyText(text: '오늘의 혈당을 기록해보세요!')),
                )
              : SizedBox(
                  height: 280,
                  child: TabBarView(
                    physics: const NeverScrollableScrollPhysics(),
                    children: <Widget>[
                      BloodSugarGraph(
                          bloodsugarValue: bloodsugarBefore, flag: 0),
                      BloodSugarGraph(
                          bloodsugarValue: bloodsugarAfter, flag: 1),
                    ],
                  ),
                )
        ],
      ),
    );
  }
}
