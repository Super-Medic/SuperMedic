import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/widgets/forAuth_widget/itemClass.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일

class CustomCheckBox extends StatefulWidget {
  final Item item;
  final Function func;
  const CustomCheckBox({
    super.key,
    required this.item,
    required this.func,
  });

  @override
  State<CustomCheckBox> createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(40, 0, 0, 35),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 13, 0, 0),
          child: GFCheckbox(
            size: 25,
            type: GFCheckboxType.circle,
            onChanged: (value) {
              setState(() {
                widget.item.isChecked = value;
                widget.func(value);
              });
            },
            value: widget.item.isChecked,
            activeBgColor: CommonColor.background,
            inactiveBgColor: CommonColor.background,
            activeBorderColor: CommonColor.background,
            inactiveBorderColor: CommonColor.background,
            // ignore: prefer_const_constructors
            inactiveIcon: Icon(
              Icons.check,
              size: 20,
              color: Colors.grey,
            ),
            activeIcon: const Icon(
              Icons.check,
              size: 20,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 70,
          height: 40,
          child: ListTile(
            title: NanumBodyText(
              text: widget.item.data,
              color: Colors.black,
            ),
            trailing: const Icon(
              Icons.navigate_next,
              color: Colors.grey,
            ),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => FirstScreen(),
              //   ),
              // );
            },
          ),
        )
      ],
    );
  }
}
