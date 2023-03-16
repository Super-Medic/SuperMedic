import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/bottom_navigation_provider.dart';
//폰트 설정 파일
//스타일 파일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/provider/home_provider.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart';

import 'package:super_medic/widgets/calender_widgets/medicineCheck.dart';
import 'package:super_medic/widgets/calender_widgets/itemClass.dart';
import 'package:super_medic/provider/medicine_provider.dart';

class MedicationTime extends StatefulWidget {
  const MedicationTime({
    Key? key,
  }) : super(key: key);

  @override
  State<MedicationTime> createState() => _MedicationTimeState();
}

class _MedicationTimeState extends State<MedicationTime> {
  MedicineTake _medicineTake = MedicineTake();

  final HomeProvider provider = HomeProvider();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    _medicineTake = context.watch<MedicineTake>();
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: screenHeight * _medicineTake.inputHeight,
            decoration: BoxDecoration(
              color: CommonColor.widgetbackgroud,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: CommonColor.boxshadowcolor.withOpacity(0.02),
                  spreadRadius: 3,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                Container(
                  margin: AppTheme.widgetpadding,
                  padding: const EdgeInsets.only(left: 5, top: 8),
                  child: InkWell(
                    onTap: () {
                      context
                          .read<BottomNavigationProvider>()
                          .updateCurrentPage(1);
                    },
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/images/medication.png',
                          width: 30,
                          height: 30,
                        ),
                        const SizedBox(width: 7),
                        const NanumTitleText(
                          text: '복약',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        const Icon(
                          Icons.chevron_right,
                          weight: 900,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var check in _medicineTake.checkList)
                          MediCheck(
                              items: check as Map<bool, List<Check>>, pad: 15),
                        SizedBox(height: screenHeight * 0.05),
                      ],
                    ),
                  ),
                ),
              ],
            )
            // Scrollbar(
            //   thumbVisibility: true,
            //   child:

            // ),
            ),
      ],
    );
  }
}
