import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:super_medic/pages/homeIndex.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart';
//스타일
import 'package:super_medic/themes/common_color.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/bottom_navigation_provider.dart';
import 'package:super_medic/widgets/mainPage_widgets/present_time.dart';
import 'package:super_medic/provider/medicine_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeProvider _homeProvider;
  MedicineTake _medicineTake = MedicineTake();
  final storage = const FlutterSecureStorage();
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (_homeProvider.homeItems.isEmpty) {
        Provider.of<HomeProvider>(context, listen: false).homeItemsGet();
      }
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
      Provider.of<MedicineTake>(context, listen: false).fetchGet();
    });
  }

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    _medicineTake = context.watch<MedicineTake>();

    var screenHeight = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        toolbarHeight: 60,
        backgroundColor: Colors.transparent, //배경 색
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
          // IconButton(
          //   icon: const Icon(Icons.notifications_none),
          //   color: Colors.black,
          //   iconSize: 25,
          //   onPressed: () => {},
          // ),
          IconButton(
            icon: const Icon(Icons.menu),
            color: Colors.black,
            iconSize: 25,
            onPressed: () =>
                {context.read<BottomNavigationProvider>().updateCurrentPage(4)},
          ),
          const SizedBox(
            width: 10,
          ),
        ],
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15, sigmaY: 35),
            child: Container(
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        padding: AppTheme.totalpadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: screenHeight * 0.013,
            ),
            const PresentTime(), //날짜
            SizedBox(
              height: screenHeight * 0.013,
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: _homeProvider.homeItems.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      _homeProvider.homeItems[index],
                      SizedBox(
                        height: screenHeight * 0.013,
                      ),
                    ],
                  );
                }),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            ElevatedButton(
              onPressed: () {
                context.read<BottomNavigationProvider>().updateCurrentPage(2);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: CommonColor.buttoncolor,
                minimumSize: const Size.fromHeight(45),
                elevation: 0.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
              ),
              child:
                  const NanumTitleText(text: '나의 건강기록 보기', color: Colors.white),
            ),
            SizedBox(
              height: screenHeight * 0.01,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HomeIndex()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(50, 158, 158, 158),
                  elevation: 0.0,
                  // side: const BorderSide(
                  //   color: Color.fromARGB(128, 0, 0, 0),
                  //   width: 0,
                  // ),
                  padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                child: const NanumBodyText(
                  text: '순서편집',
                  color: Color.fromARGB(230, 158, 158, 158),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.013,
            ),
          ],
        ),
      )),
    ));
  }
}
