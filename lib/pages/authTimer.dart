import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/widgets/forAuth_widget/timer.dart';
import 'package:super_medic/widgets/server_widgets/requestHealthData.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../provider/home_provider.dart';

class AuthTimer extends StatefulWidget {
  final String loginOrgCd;
  final String healthDataType;
  final String step;
  final String step_data;
  const AuthTimer(
      {Key? key,
      required this.loginOrgCd,
      required this.healthDataType,
      required this.step,
      required this.step_data})
      : super(key: key);

  @override
  State<AuthTimer> createState() => _AuthTimer();
}

class _AuthTimer extends State<AuthTimer> {
  late HomeProvider _homeProvider;
  String tmp = "500";
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    _homeProvider = context.watch<HomeProvider>();
    return Scaffold(
      backgroundColor: CommonColor.background,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
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
          )),
      // ignore: prefer_const_constructors
      body: Stack(
        children: [
          Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 25.0,
                ),
                NanumTitleText(
                  text: '${widget.loginOrgCd} 앱으로\n 간편인증 요청을 보냈어요.',
                  fontSize: 25.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 10,
                ),
                NanumBodyText(
                  text: '${widget.loginOrgCd} 앱을 열고 인증해주세요',
                  fontSize: 18.0,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 32.0,
                ),
                const OtpTimer(),
                Expanded(
                  // height: (MediaQuery.of(context).size.height - 600) / 2,
                  child: Center(
                      child: Image.asset(
                    'assets/images/naverAuth.png',
                    width: 130,
                  )),
                ),
                const Padding(
                  padding: EdgeInsets.all(50),
                ),
                SafeArea(
                    child: Align(
                  alignment: Alignment.bottomCenter,
                  child: TextButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      tmp = await requestHealthData(
                          widget.loginOrgCd, widget.healthDataType, widget.step,
                          step_data: widget.step_data);
                      setState(() {
                        isLoading = false;
                      });
                      if (tmp != "200") {
                        // ignore: use_build_context_synchronously
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) {
                            return const PopUp();
                          },
                        );
                      } else {
                        if (widget.healthDataType == "Screenings") {
                          _homeProvider.screeninggetData();
                        }
                        if (widget.healthDataType == "Medicine") {
                          _homeProvider.medicinegetData();
                        }
                        if (widget.healthDataType == "Diagnosis") {
                          _homeProvider.diagnosisgetData();
                        }
                        if (mounted) {
                          var nav = Navigator.of(context);
                          nav.pop();
                          nav.pop();
                          nav.pop();
                        }
                      }

                      // context.read<BottomNavigationProvider>().updateCurrentPage(2);
                      // sign 호출 후 데이터 저장 및 홈으로 이동 또는 팝업창
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.green,
                      minimumSize:
                          Size(MediaQuery.of(context).size.width - 30, 50),
                      elevation: 0.0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: const NanumTitleText(
                      text: '인증 완료 및 데이터 불러오기',
                      color: Colors.white,

                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
                const Padding(
                  padding: EdgeInsets.all(10),
                )
              ],
            ),
          ),
          Stack(children: <Widget>[
            Opacity(
              opacity: 0.5,
              child: isLoading
                  ? ModalBarrier(dismissible: false, color: Colors.black)
                  : null, //클릭 못하게~
            ),
            Center(
              child: isLoading
                  ? SpinKitSpinningCircle(
                      itemBuilder: (context, index) {
                        return Center(
                            child: Image.asset(
                          'assets/images/loading.png',
                        ));
                      },
                    )
                  : null,
            ),
          ]),
        ],
      ),
    );
  }
}

class PopUp extends StatelessWidget {
  const PopUp({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: const Icon(
        Icons.error_outline,
        size: 35,
      ),
      content: const SizedBox(
        height: 50,
        child: Column(
          children: [
            NanumTitleText(
              text: '인증이 완료되지 않았어요',
              fontWeight: FontWeight.bold,
            ),
            NanumBodyText(
              text: '인증이 완료된 후 다시 시도해주세요',
            ),
          ],
        ),
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              minimumSize: Size(MediaQuery.of(context).size.width - 180, 40),
              backgroundColor: Colors.green,
            ),
            child: const NanumBodyText(
              text: '확인',
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
