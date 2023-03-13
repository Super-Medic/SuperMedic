import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/theme.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_pressure.dart';
import 'package:super_medic/widgets/mainPage_widgets/medication_time.dart';
//스타일
import 'package:super_medic/themes/common_color.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/bottom_navigation_provider.dart';
import 'package:super_medic/widgets/mainPage_widgets/note.dart';
import 'package:super_medic/widgets/mainPage_widgets/blood_sugar.dart';
import 'package:super_medic/widgets/mainPage_widgets/present_time.dart';
import 'package:super_medic/widgets/mainPage_widgets/symptom.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeProvider _homeProvider;
  final storage = const FlutterSecureStorage();
  List<Widget> _items = [];

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      String? homeIndexKeyValue = await storage.read(key: 'HomeIndex');
      if (homeIndexKeyValue == null) {
        await storage.write(
            key: 'HomeIndex',
            value:
                '[MedicationTime, BloodSugar, BloodPressure, Symptom, Note]');
        homeIndexKeyValue = await storage.read(key: 'HomeIndex');
      }
      List<String> homeIndex = homeIndexKeyValue!
          .substring(1, homeIndexKeyValue.length - 1)
          .split(', ');
      _items = List.generate(homeIndex.length, (i) {
        switch (homeIndex[i]) {
          case 'MedicationTime': return const MedicationTime();
          case 'BloodSugar': return const BloodSugar();
          case 'BloodPressure': return const BloodPressure();
          case 'Symptom': return const Symptom();
          case 'Note': return const Note();
          default: return Container();
        }
      });

      print(_items);

      if (_homeProvider.bloodSugarValue.isEmpty) {
        Provider.of<HomeProvider>(context, listen: false).bloodSugargetData();
      }
      if (_homeProvider.bloodPressureValue.isEmpty) {
        Provider.of<HomeProvider>(context, listen: false)
            .bloodPressuregetData();
      }
      if (_homeProvider.symptomsValue.isEmpty) {
        Provider.of<HomeProvider>(context, listen: false).symptomgetData();
      }
      if (_homeProvider.noteTextValue.isEmpty) {
        Provider.of<HomeProvider>(context, listen: false).noteTextgetData();
      }

      if (_homeProvider.screeningValue == null) {
        Provider.of<HomeProvider>(context, listen: false).screeninggetData();
      }
      if (_homeProvider.medicineValue == null) {
        Provider.of<HomeProvider>(context, listen: false).medicinegetData();
      }
      if (_homeProvider.diagnosisValue == null) {
        Provider.of<HomeProvider>(context, listen: false).diagnosisgetData();
      }

      if (_homeProvider.loginValue == null) {
        Provider.of<HomeProvider>(context, listen: false).logingetData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          backgroundColor: CommonColor.background,
          appBar: AppBar(
            toolbarHeight: 60,
            backgroundColor: CommonColor.background, //배경 색
            elevation: 0.0, //그림자 효과 해제
            leading: Container(
              padding: const EdgeInsets.only(left: 10),
              child: Image.asset(
                'assets/images/home_logo.png',
                color: Colors.green,
              ),
            ),
            leadingWidth: 150,
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none),
                color: Colors.black,
                iconSize: 25,
                onPressed: () => {},
              ),
              IconButton(
                icon: const Icon(Icons.menu),
                color: Colors.black,
                iconSize: 25,
                onPressed: () => {
                  context.read<BottomNavigationProvider>().updateCurrentPage(4)
                },
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
          body: Container(
            padding: AppTheme.totalpadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const PresentTime(), //날짜
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Expanded(
                  child: ReorderableListView(
                    children: <Widget>[
                      for (int index = 0; index < _items.length; index++)
                        ListTile(
                            key: Key('$index'),
                            visualDensity: const VisualDensity(vertical: -4),
                            title: _items[index],
                            contentPadding:
                                const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                      // ListTile(
                      //     key: const Key('null'),
                      //     title: ElevatedButton(
                      //       onPressed: () {
                      //         context
                      //             .read<BottomNavigationProvider>()
                      //             .updateCurrentPage(2);
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: CommonColor.buttoncolor,
                      //         minimumSize: const Size.fromHeight(45),
                      //         elevation: 0.0,
                      //         shape: RoundedRectangleBorder(
                      //             borderRadius: BorderRadius.circular(15)),
                      //       ),
                      //       child: const Text('나의 건강기록 보기'),
                      //     ),
                      //     contentPadding:
                      //         const EdgeInsets.fromLTRB(0, 0, 0, 0)),
                    ],
                    onReorder: (int oldIndex, int newIndex) async {
                      setState(() {
                        if (oldIndex < newIndex) {
                          newIndex -= 1;
                        }
                        final Widget item = _items.removeAt(oldIndex);
                        _items.insert(newIndex, item);
                      });
                      await storage.write(key: 'HomeIndex', value: '$_items');
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context
                        .read<BottomNavigationProvider>()
                        .updateCurrentPage(2);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CommonColor.buttoncolor,
                    minimumSize: const Size.fromHeight(45),
                    elevation: 0.0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text('나의 건강기록 보기'),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
              ],
            ),
          )),
    );
  }
}
