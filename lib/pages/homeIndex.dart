import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart';
//폰트 설정 파일

class HomeIndex extends StatefulWidget {
  const HomeIndex({Key? key}) : super(key: key);

  @override
  State<HomeIndex> createState() => _HomeIndexState();
}

class _HomeIndexState extends State<HomeIndex> {
  late HomeProvider _homeProvider;
  final storage = const FlutterSecureStorage();
  List<String> homeItemsOder = [];
  int init = 0;
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (_homeProvider.homeIndex.isEmpty) {
        Provider.of<HomeProvider>(context, listen: false).homeItemsGet();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    if (init == 0) {
      homeItemsOder = [..._homeProvider.homeIndex];
      init = 1;
    }

    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final ButtonStyle style = TextButton.styleFrom(
      shape: RoundedRectangleBorder(
          //모서리를 둥글게
          borderRadius: BorderRadius.circular(0)),
      minimumSize: Size(screenWidth, screenHeight * 0.07),
      backgroundColor: Colors.green,
      foregroundColor: Colors.green[900],
      elevation: 0.0,
    );

    return Scaffold(
        backgroundColor: Colors.green,
        body: SafeArea(
          top: false,
          child: Scaffold(
            backgroundColor: CommonColor.background,
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(60.0),
              child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: AppBar(
                    toolbarHeight: 80,
                    backgroundColor: CommonColor.background,
                    elevation: 0.0,
                    leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      color: const Color.fromRGBO(0, 0, 0, 1.0),
                      icon: const Icon(Icons.arrow_back_ios_new),
                      iconSize: 30,
                    ),
                    title: const NanumTitleText(
                        text: '순서 편집',
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                  )),
            ),
            // ignore: prefer_const_constructors
            body: ReorderableListView(
              children: [
                for (int index = 0;
                    index < _homeProvider.homeIndex.length;
                    index++)
                  Column(key: Key('$index'), children: [
                    ListTile(
                      key: Key('$index'),
                      tileColor: const Color.fromARGB(0, 255, 255, 255),
                      minVerticalPadding: 20,
                      visualDensity: const VisualDensity(vertical: -4),
                      title: homeItemsOder[index] == 'MedicationTime'
                          ? const Text('복약 관리')
                          : homeItemsOder[index] == 'BloodPressure'
                              ? const Text('혈압 관리')
                              : homeItemsOder[index] == 'BloodSugar'
                                  ? const Text('혈당 관리')
                                  : homeItemsOder[index] == 'Symptom'
                                      ? const Text('증상 관리')
                                      : const Text('노트'),
                      trailing: ReorderableDragStartListener(
                          index: index, child: const Icon(Icons.drag_handle)),
                    ),
                    const Divider(thickness: 1),
                  ]),
              ],
              onReorder: (int oldIndex, int newIndex) async {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final String item = homeItemsOder.removeAt(oldIndex);
                  homeItemsOder.insert(newIndex, item);
                });
              },
            ),
            bottomSheet: TextButton(
              style: style,
              child: const NanumTitleText(
                text: '적용하기',
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
              onPressed: () async {
                try {
                  await storage.write(
                      key: 'HomeIndex', value: '$homeItemsOder');
                  // ignore: use_build_context_synchronously
                  Provider.of<HomeProvider>(context, listen: false)
                      .homeItemsGet();
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context);
                } catch (err) {
                  // ignore: avoid_print
                  print(err);
                }
              },
            ),
          ),
        ));
  }
}
