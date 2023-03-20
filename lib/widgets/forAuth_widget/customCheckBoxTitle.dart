import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:super_medic/widgets/forAuth_widget/itemClass.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일

class CustomCheckBoxTitle extends StatefulWidget {
  final Item item;
  final Function func;
  const CustomCheckBoxTitle({
    super.key,
    required this.item,
    required this.func,
  });

  @override
  State<CustomCheckBoxTitle> createState() => _CustomCheckBoxTitleState();
}

class _CustomCheckBoxTitleState extends State<CustomCheckBoxTitle> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.item.isChecked ? Colors.black : Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        width: MediaQuery.of(context).size.width - 30,
        child: GFCheckboxListTile(
          title: NanumTitleText(text: widget.item.data, color: Colors.white),
          position: GFPosition.start,
          size: 25,
          type: GFCheckboxType.circle,
          onChanged: (value) {
            setState(() {
              widget.item.isChecked = value;
              widget.func(value);
            });
          },
          value: widget.item.isChecked,
          activeBgColor: Colors.black,
          inactiveBgColor: Colors.grey,
          activeBorderColor: Colors.black,
          inactiveBorderColor: Colors.grey,
          // ignore: prefer_const_constructors
          inactiveIcon: Icon(
            Icons.check,
            size: 25,
            color: Colors.white,
          ),
          activeIcon: const Icon(
            Icons.check,
            size: 25,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
