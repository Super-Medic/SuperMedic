import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart';
import 'package:super_medic/themes/theme.dart';
import 'package:super_medic/widgets/mainPage_widgets/present_time.dart';

// ignore: must_be_immutable
class SymptomRecordList extends StatefulWidget {
  const SymptomRecordList({super.key});

  @override
  State<SymptomRecordList> createState() => _SymptomRecordListState();
}

class _SymptomRecordListState extends State<SymptomRecordList> {
  final List<Map<String, dynamic>> symptomHead = [
    {'state': '두통', 'isCheck': false},
    {'state': '편두통', 'isCheck': false},
    {'state': '발열', 'isCheck': false},
    {'state': '어지러움', 'isCheck': false},
  ];

  final List<Map<String, dynamic>> symptomBody = [
    {'state': '피로감', 'isCheck': false},
    {'state': '가슴두근', 'isCheck': false},
    {'state': '근육통', 'isCheck': false},
    {'state': '뒷골', 'isCheck': false},
    {'state': '코피', 'isCheck': false},
    {'state': '혈`뇨`', 'isCheck': false},
    {'state': '시력저하', 'isCheck': false},
    {'state': '오한', 'isCheck': false},
    {'state': '손발저림', 'isCheck': false},
    {'state': '부종', 'isCheck': false},
    {'state': 'PMS', 'isCheck': false},
    {'state': '성욕감퇴', 'isCheck': false},
  ];
  final List<Map<String, dynamic>> symptomSkin = [
    {'state': '여드름', 'isCheck': false},
    {'state': '안면홍조', 'isCheck': false},
    {'state': '식은땀', 'isCheck': false},
    {'state': '각질', 'isCheck': false},
    {'state': '가려움', 'isCheck': false},
  ];
  final List<Map<String, dynamic>> symptomStomach = [
    {'state': '변비', 'isCheck': false},
    {'state': '소화불량', 'isCheck': false},
    {'state': '속쓰림', 'isCheck': false},
    {'state': '설사', 'isCheck': false},
    {'state': '경련', 'isCheck': false},
    {'state': '복통', 'isCheck': false},
    {'state': '메스꺼움', 'isCheck': false},
    {'state': '복부팽만', 'isCheck': false},
  ];

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    final ButtonStyle style = ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(
          //모서리를 둥글게
          borderRadius: BorderRadius.circular(0)),
      minimumSize: Size(screenWidth, screenHeight * 0.07),
      backgroundColor: Colors.green,
      foregroundColor: Colors.green[900],
      elevation: 0.0,
      // foregroundColor: Colors.greenAccent,
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          //replace with our own icon data.
        ),
        toolbarHeight: 48,
        backgroundColor: Colors.white, //배경 색
        elevation: 0.0, //
      ),
      body: SafeArea(
        child: Container(
          padding: AppTheme.totalpadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: screenHeight * 0.01,
              ),
              const Center(
                child: NanumTitleText(
                  text: '증상 기록하기',
                  fontSize: 25,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: screenHeight * 0.03,
              ),
              const PresentTime(),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const NanumTitleText(
                text: "머리",
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              SymptomButton(symptomList: symptomHead),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const NanumTitleText(
                text: "몸 상태",
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              SymptomButton(symptomList: symptomBody),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const NanumTitleText(
                text: "피부",
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              SymptomButton(symptomList: symptomSkin),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              const NanumTitleText(
                text: "복부",
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
              SizedBox(
                height: screenHeight * 0.01,
              ),
              SymptomButton(symptomList: symptomStomach)
            ],
          ),
        ),
      ),
      bottomSheet: ElevatedButton(
        // style: style,
        style: style,

        child: const NanumTitleText(
          text: '저장',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}

class SymptomButton extends StatefulWidget {
  SymptomButton({super.key, required this.symptomList});
  List<Map<String, dynamic>>? symptomList;

  @override
  State<SymptomButton> createState() => _SymptomButtonState();
}

class _SymptomButtonState extends State<SymptomButton> {
  // var l = super.getSymptomList();
  Widget buildTags(BuildContext context, index, tag) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return ChoiceChip(
        // backgroundColor: const Color.fromRGBO(244, 244, 244, 0.9),
        backgroundColor: const Color.fromARGB(200, 244, 244, 244),
        labelPadding: const EdgeInsets.all(0.0),
        pressElevation: 0,
        label: Container(
          alignment: const Alignment(0, 0),
          width: screenWidth * 0.17,
          height: screenHeight * 0.02,
          child: Text(
            tag[index]['state'],
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: tag[index]['isCheck']
                    ? Colors.white
                    : const Color.fromRGBO(96, 96, 96, 1),
                fontSize: 11,
                fontFamily: "NanumSqaureB",
                fontWeight: FontWeight.bold),
          ),
        ),
        selected: tag[index]['isCheck'] == true,
        selectedColor: Colors.green,
        onSelected: (value) {
          setState(() {
            tag[index]['isCheck'] = !tag[index]['isCheck'];
          });
        },
        elevation: 0);
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>>? symptomList = widget.symptomList;
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Container(
      alignment: const Alignment(0, 0),
      child: Wrap(
        direction: Axis.horizontal,
        // alignment: WrapAlignment.start,
        spacing: screenWidth * 0.03,
        // runSpacing: screenHeight * 0.005,

        alignment: WrapAlignment.spaceBetween,
        children: List.generate(
          symptomList!.length,
          (index) {
            return buildTags(context, index, symptomList);
          },
        ),
      ),
    );
  }
}
