import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/bottom_navigation_provider.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart';

class MeditalkPage extends StatelessWidget {
  const MeditalkPage({super.key});

  @override
  Widget build(BuildContext context) {
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
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              child: Image.asset('assets/images/meditalking.png'),
            ),
            const NanumTitleText(text: '슈메톡 서비스가\n곧 찾아옵니다!'),
            const SizedBox(
              height: 10,
            ),
            const NanumBodyText(text: '새로운 경험을 선물할게요!')
          ],
        )),
      ),
    );
  }
}
