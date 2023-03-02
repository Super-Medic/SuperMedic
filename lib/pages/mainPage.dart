import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:super_medic/pages/healthPage.dart';
import 'package:super_medic/pages/HomePage.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/pages/medicinePage.dart';
import 'package:super_medic/pages/myPage.dart';
import 'package:super_medic/provider/bottom_navigation_provider.dart';

// ignore: must_be_immutable
class MainPage extends StatelessWidget {
  late BottomNavigationProvider _bottomNavigationProvider;
  DateTime? currentBackPressTime; //뒤로가기 버튼 클릭 시 앱 종료 구현
  MainPage({super.key});

  // 권한 요청
  Future<bool> requestCameraPermission(BuildContext context) async {
    PermissionStatus statusStorage = await Permission.storage.request();
    PermissionStatus statusCamera = await Permission.camera.request();

    // 결과 확인
    if (!statusStorage.isGranted || !statusCamera.isGranted) {
      // 허용이 안된 경우
      // ignore: use_build_context_synchronously
      showDialog(
          context: context,
          builder: (BuildContext context) {
            // 권한없음을 다이얼로그로 알림
            return AlertDialog(
              content: const Text("권한 설정을 확인해주세요!!!"),
              actions: [
                TextButton(
                    onPressed: () {
                      openAppSettings(); // 앱 설정으로 이동
                    },
                    child: const Text('설정하기')),
              ],
            );
          });
      return false;
    }
    return true;
  }

  // 네비게이션바 UI Widget
  Widget _navigationBody() {
    // switch를 통해 currentPage에 따라 네비게이션을 구동시킨다.
    switch (_bottomNavigationProvider.currentPage) {
      case 0:
        return const HomePage();
      case 1:
        return const MedicinePage();
      case 2:
        return const HealthPage();
      case 4:
        return const MyPage();
    }
    return Container();
  }

  // 네비게이션바 Widget
  Widget _bottomNavigationBarWidget() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed, // item이 4개 이상일 경우 추가
      // ignore: prefer_const_literals_to_create_immutables
      items: [
        BottomNavigationBarItem(
            icon: Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset(
                  'assets/images/home_icon1.png',
                  width: 22.5,
                  height: 22.5,
                  color: const Color.fromARGB(160, 158, 158, 158),
                )),
            activeIcon: Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: Image.asset('assets/images/home_icon1.png',
                    width: 22.5, height: 22.5)),
            label: '홈'),
        BottomNavigationBarItem(
          icon: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/images/home_icon2.png',
                width: 22.5,
                height: 22.5,
                color: const Color.fromARGB(160, 158, 158, 158),
              )),
          activeIcon: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset('assets/images/home_icon2.png',
                  width: 22.5, height: 22.5)),
          label: '복약관리',
        ),
        BottomNavigationBarItem(
          icon: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/images/home_icon3.png',
                width: 22.5,
                height: 22.5,
                color: const Color.fromARGB(160, 158, 158, 158),
              )),
          activeIcon: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset('assets/images/home_icon3.png',
                  width: 22.5, height: 22.5)),
          label: '마이데이터',
        ),
        BottomNavigationBarItem(
          icon: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset(
                'assets/images/home_icon4.png',
                width: 22.5,
                height: 22.5,
                color: const Color.fromARGB(160, 158, 158, 158),
              )),
          activeIcon: Container(
              padding: const EdgeInsets.only(bottom: 5),
              child: Image.asset('assets/images/home_icon4.png',
                  width: 22.5, height: 22.5)),
          label: '메디톡',
        ),
        BottomNavigationBarItem(
            icon: Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: const Icon(Icons.menu)),
            label: '전체')
      ],

      // 현재 페이지 : _bottomNavigationProvider의 currentPage
      currentIndex: _bottomNavigationProvider.currentPage,
      selectedItemColor: Colors.black,
      unselectedLabelStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 9,
        color: Color.fromARGB(160, 158, 158, 158),
      ),
      selectedLabelStyle:
          const TextStyle(fontWeight: FontWeight.bold, fontSize: 9),
      // _bottomNavigationProvider에 updateCurrentPage를 통해 index를 전달
      onTap: (index) {
        _bottomNavigationProvider.updateCurrentPage(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Provider를 호출해 접근
    //_bottomNavigationProvider = Provider.of<BottomNavigationProvider>(context); //옛날 방법
    _bottomNavigationProvider = context.watch<BottomNavigationProvider>();

    requestCameraPermission(context); //권한 표시

    //뒤로 가기 두 번 클릭 시 어플 종료
    Future<bool> onWillPop() async {
      DateTime now = DateTime.now();
      if (currentBackPressTime == null ||
          now.difference(currentBackPressTime!) > const Duration(seconds: 2)) {
        currentBackPressTime = now;
        Fluttertoast.showToast(
            msg: "'뒤로' 버튼을 한번 더 누르시면 종료됩니다.",
            gravity: ToastGravity.BOTTOM,
            backgroundColor: const Color(0xff6E6E6E),
            fontSize: 12,
            toastLength: Toast.LENGTH_SHORT);
        return Future.value(false);
      }
      SystemNavigator.pop();
      return Future.value(true);
    }

    return Scaffold(
      body: WillPopScope(
        onWillPop: onWillPop,
        child: SafeArea(
          child: _navigationBody(),
        ),
      ),
      bottomNavigationBar: _bottomNavigationBarWidget(),
    );
  }
}
