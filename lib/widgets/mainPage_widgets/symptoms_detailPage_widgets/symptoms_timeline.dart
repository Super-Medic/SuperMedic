// import 'package:flutter/material.dart';
// import 'package:timelines/timelines.dart';

// // ignore: must_be_immutable
// class SymptomsTimeline extends StatefulWidget {
//   const SymptomsTimeline({super.key, required this.timeLineValue});
//   final timeLineValue;

//   @override
//   State<SymptomsTimeline> createState() => _SymptomsTimelineState();
// }

// class _SymptomsTimelineState extends State<SymptomsTimeline> {
//   @override
//   Widget build(BuildContext context) {
//     final data = _sugardata(timeLineValue);
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(color: CommonColor.widgetbackgroud),
//       child: Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             _DeliveryProcesses(processes: data.deliveryProcesses),
//           ],
//         ),
//       ),
//     );
//   }
// }
