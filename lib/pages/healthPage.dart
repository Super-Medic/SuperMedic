import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:super_medic/provider/bottom_navigation_provider.dart';
import 'package:super_medic/themes/theme.dart'; //스타일
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/widgets/healthPage_widgets/health_screenings.dart';
import 'package:super_medic/widgets/healthPage_widgets/immunization_history.dart';
import 'package:super_medic/widgets/healthPage_widgets/linked_health_data.dart';
import 'package:super_medic/widgets/healthPage_widgets/recent_medical_records.dart';
import 'package:super_medic/widgets/healthPage_widgets/recent_medication_history.dart';
// import 'package:super_medic/widgets/server_widgets/server_test.dart';

// ignore: must_be_immutable
class HealthPage extends StatefulWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  State<HealthPage> createState() => _HealthPage();
}

class _HealthPage extends State<HealthPage> {
// class HealthPage extends StatelessWidget {
//   HealthPage({Key? key}) : super(key: key);
  var i = 0;
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

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
        body: SingleChildScrollView(
            child: Container(
          padding: AppTheme.totalpadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.01,
              ),
              // ignore: unrelated_type_equality_checks
              const HealthScreenings(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const RecentMedicationHistory(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const RecentMedicalRecords(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const ImmunizationHistory(),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const LinkedHealthData(),
              SizedBox(
                height: screenHeight * 0.03,
              ),
            ],
          ),
        )),
      ),
    );
  }
}
