import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_sugar_graph.dart';

class BloodSugarTotalGraph extends StatefulWidget {
  const BloodSugarTotalGraph({super.key});

  @override
  _BloodSugarTotalGraphState createState() => _BloodSugarTotalGraphState();
}

class _BloodSugarTotalGraphState extends State<BloodSugarTotalGraph>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;
  late HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    _nestedTabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _nestedTabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TabBar(
              controller: _nestedTabController,
              indicatorColor: Colors.green,
              labelColor: Colors.green,
              unselectedLabelColor: Colors.black54,
              isScrollable: true,
              tabs: const <Widget>[
                Tab(
                  text: "식전혈당",
                ),
                Tab(
                  text: "식후혈당",
                ),
              ],
            ),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _nestedTabController,
            children: <Widget>[
              BloodSugarGraph(),
              BloodSugarGraph(),
            ],
          ),
        ),
      ],
    );
  }
}
