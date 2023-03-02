import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //날짜 구하기
import 'package:timer_builder/timer_builder.dart'; //날짜 갱신

class PresentTime extends StatelessWidget {
  const PresentTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      child: TimerBuilder.periodic(
        const Duration(days: 1),
        builder: (context) {
          return Text(
            DateFormat('M월 d일 E요일', 'ko').format(DateTime.now()),
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
            ),
          );
        },
      ),
    );
  }
}
