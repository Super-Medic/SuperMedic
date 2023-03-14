import 'package:flutter/material.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_sugar_graph.dart';

class NestedTabBar extends StatefulWidget {
  const NestedTabBar({super.key});

  @override
  _NestedTabBarState createState() => _NestedTabBarState();
}

class _NestedTabBarState extends State<NestedTabBar>
    with TickerProviderStateMixin {
  late TabController _nestedTabController;

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
          child: SizedBox(
            child: TabBarView(
              controller: _nestedTabController,
              children: <Widget>[
                BloodSugarGraph(),
                BloodSugarGraph(),
              ],
            ),
          ),
        )
      ],
    );
  }
}
