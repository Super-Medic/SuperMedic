import 'dart:async';
import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일

class OtpTimer extends StatefulWidget {
  const OtpTimer({super.key});

  @override
  _OtpTimerState createState() => _OtpTimerState();
}

class _OtpTimerState extends State<OtpTimer> {
  final interval = const Duration(seconds: 1);

  final int timerMaxSeconds = 300;

  int currentSeconds = 0;

  String get timerText =>
      '${((timerMaxSeconds - currentSeconds) ~/ 60).toString().padLeft(2, '0')}:${((timerMaxSeconds - currentSeconds) % 60).toString().padLeft(2, '0')}';

  startTimeout([int? milliseconds]) {
    var duration = interval;
    Timer.periodic(duration, (timer) {
      if (mounted) {
        setState(() {
          currentSeconds = timer.tick;
          if (timer.tick >= timerMaxSeconds) {
            timer.cancel();
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return const PopUp();
              },
            );
          }
        });
      }
    });
  }

  @override
  void initState() {
    startTimeout();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width / 4,
        height: 30,
        decoration: BoxDecoration(
          color: const Color.fromARGB(208, 220, 220, 220),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Icon(
                Icons.access_alarms,
                color: Colors.grey,
              ),
              const SizedBox(
                width: 5,
              ),
              NanumBodyText(
                text: timerText,
                color: Colors.grey,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ));
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
            NanumTitleText(text: '인증 요청이 종료 되었습니다'),
            NanumBodyText(text: '다시 시도해주세요'),
          ],
        ),
      ),
      actions: [
        Center(
          child: TextButton(
            onPressed: () {
              var nav = Navigator.of(context);
              nav.pop();
              nav.pop();
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
