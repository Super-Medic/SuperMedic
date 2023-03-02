import 'package:flutter/material.dart';
import 'package:super_medic/themes/common_color.dart';
import 'package:super_medic/themes/textstyle.dart'; //폰트 설정 파일
import 'package:super_medic/pages/tos.dart';
import 'package:super_medic/widgets/forAuth_widget/itemClass.dart';

class AuthPage extends StatefulWidget {
  final String healthDataType;
  const AuthPage({Key? key, required this.healthDataType}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPage();
}

class _AuthPage extends State<AuthPage> {
  List<Item> items = List.empty(growable: true);
  @override
  void initState() {
    super.initState();
    items.add(
        Item(data: "카카오톡", page: 'assets/images/kakao.png', isChecked: false));
    items.add(
        Item(data: "네이버", page: 'assets/images/naver.png', isChecked: false));
    items.add(
        Item(data: "통신사패스", page: 'assets/images/pass.png', isChecked: false));
    items.add(
        Item(data: "KB 모바일", page: 'assets/images/kb.png', isChecked: false));
    items
        .add(Item(data: "토스", page: 'assets/images/tos.png', isChecked: false));
    items.add(
        Item(data: "삼성패스", page: 'assets/images/ss.png', isChecked: false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CommonColor.background,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: CommonColor.background,
            elevation: 0.0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              color: const Color.fromRGBO(0, 0, 0, 1.0),
              icon: const Icon(Icons.arrow_back_ios_new),
              iconSize: 30,
            ),
          )),
      // ignore: prefer_const_constructors
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 25.0,
            ),
            const NanumTitleText(
              text: '인증서를 선택해주새요.',
              fontSize: 25.0,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(
              height: 32.0,
            ),
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.25,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                padding: const EdgeInsets.only(left: 28, right: 28, bottom: 58),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      setState(() {
                        for (var item in items) {
                          item.isChecked = false;
                        }
                        items[index].isChecked = true;
                      });
                    },
                    child: CustomRadio(items[index]),
                  );
                },
              ),
            ),
            SafeArea(
                child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  String data = getTrue();
                  data == ''
                      ? null
                      : Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => TOSPage(
                                    loginOrgCd: data,
                                    healthDataType: widget.healthDataType
                                  )));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: getTrue() == '' ? Colors.grey : Colors.green,
                  minimumSize: Size(MediaQuery.of(context).size.width - 80, 40),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const NanumTitleText(
                  text: '기록 가져오기',
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
            const Padding(
              padding: EdgeInsets.all(10),
            )
          ],
        ),
      ),
    );
  }

  String getTrue() {
    String result = "";
    for (var item in items) {
      if (item.isChecked == true) result = item.data;
    }
    return result;
  }
}

class CustomRadio extends StatelessWidget {
  final Item _item;
  const CustomRadio(this._item, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: _item.isChecked
          ? const Color.fromARGB(208, 220, 220, 220)
          : Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            _item.page,
            width: 80,
            height: 50,
          ),
          const SizedBox(
            height: 10,
          ),
          NanumBodyText(
            text: _item.data,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }
}
