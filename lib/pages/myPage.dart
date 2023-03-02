import 'package:flutter/material.dart';
//스타일

class MyPage extends StatefulWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  State<MyPage> createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 18,
                  ),
                  _heading("스키/보드 정보"),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.newspaper),
                          title: Text(
                            "스키-보드 컨텐츠 / 뉴스",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.menu),
                          title: Text(
                            "스키장 정보",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  _heading("관심 매장"),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.timer),
                          title: Text(
                            "최근 본 매장",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.favorite),
                          title: Text(
                            "즐겨 찾는 매장",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  _heading("이벤트"),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: const [
                        ListTile(
                          leading: Icon(Icons.person_add),
                          title: Text(
                            "친구 초대하기",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        ListTile(
                          leading: Icon(Icons.menu),
                          title: Text(
                            "쿠폰북",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  _heading("고객센터 및 설정"),
                  Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {},
                          child: const ListTile(
                            leading: Icon(Icons.announcement),
                            title: Text(
                              "공지사항",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                        const ListTile(
                          leading: Icon(Icons.question_answer),
                          title: Text(
                            "자주 묻는 질문",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        const ListTile(
                          leading: Icon(Icons.support_agent),
                          title: Text(
                            "1:1 문의하기",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        const ListTile(
                          leading: Icon(Icons.notifications),
                          title: Text(
                            "알림 내역 및 설정",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _heading(String heading) {
    return Container(
      padding: const EdgeInsets.only(left: 10),
      margin: const EdgeInsets.only(bottom: 5),
      width: MediaQuery.of(context).size.width,
      child: Text(
        heading,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.w600, color: Colors.grey),
      ),
    );
  }

  Widget _footerContent(String text) {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 60),
          width: MediaQuery.of(context).size.width,
          child: Text(
            text,
            style: const TextStyle(
                fontSize: 11.5,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}
