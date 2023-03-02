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
          if (timer.tick >= timerMaxSeconds) timer.cancel();
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
