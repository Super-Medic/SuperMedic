import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/widgets/forAuth_widget/itemClass.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:webview_flutter/webview_flutter.dart';

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
              textAlign: TextAlign.left,
            ),
            trailing: const Icon(
              Icons.navigate_next,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Scaffold(
                    backgroundColor: CommonColor.background,
                    appBar: PreferredSize(
                      preferredSize: const Size.fromHeight(50.0),
                      child: AppBar(
                        backgroundColor: CommonColor.background,
                        elevation: 0.0,
                        title: NanumTitleText(
                          text: widget.item.data,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                        leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: const Color.fromRGBO(0, 0, 0, 1.0),
                          icon: const Icon(Icons.arrow_back_ios_new),
                          iconSize: 30,
                        ),
                      ),
                    ),
                    body: WebView(
                      initialUrl: widget.item.page,
                      javascriptMode: JavascriptMode.unrestricted,
                      gestureNavigationEnabled: true,
                      userAgent: "random",
                    ),
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
