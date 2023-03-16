import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:super_medic/themes/textstyle.dart';

class PickerInput extends StatefulWidget {
  const PickerInput({Key? key}) : super(key: key);

  @override
  State<PickerInput> createState() => _PickerInputState();
}

class _PickerInputState extends State<PickerInput> {
  // for(int i = 121; i< 200; i++ ){
  //   time.add(i.toString());
  // }

  List<String> colorItem = [
    "147",
    "148",
    "149",
    "150",
    "151",
    "152",
    "153",
    "154",
    "155"
  ];
  final FixedExtentScrollController controller =
      FixedExtentScrollController(initialItem: 1);

  String colorString = "0";
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(colorString,
                    style: const TextStyle(fontFamily: "NotoSansKR", color: Colors.green, fontSize: 32)),
                const NanumText(text: "mg/dL")
              ],
            ),
          ),
          Container(
            width: screenWidth * 0.8,
            height: screenHeight * 0.25,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.transparent),
            child: CupertinoPicker(
                itemExtent: 75,
                onSelectedItemChanged: (i) {
                  setState(() {
                    colorString = colorItem[i];
                  });
                },
                children: [
                  ...colorItem.map((e) => Text(
                        e,
                        style:
                            const TextStyle(
                              fontFamily: "NotoSansKR",
                              color: Colors.grey, fontSize: 32),
                      ))
                ]),
          ),
        ],
      ),
    );
  }
}
