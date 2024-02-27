import 'dart:async';

import 'package:flutter/material.dart';

// ctrl spacebar : 쓸 수있는거 나옴

void main() {
  runApp(const MainApp());
}

// 리스위젯 호출용도
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  // 생성자 호출할땐 const
  const HomePage({super.key});

  @override
  //리턴해서 위의 MaterialApp 에 보내준다 // js와 비슷한데 리턴문이 생략되어있다
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // 스캐폴더는 바디를 통해다른위젯을 연결한다
    return Scaffold(
      // const~ 오류나면 const 제거 : 변수는 const 못쓰므로 생김
      appBar: AppBar(
        title: const Text(
          "Simple",
          style: TextStyle(color: Colors.white), // 글자색 하양
        ),
        backgroundColor: Colors.blue, // 바탕색파랑
        // elevation: 12, // 앱바에 그림자(크롬에서안보임)
      ),
      body: const AppBody(),
      // 화면에 둥둥 떠있는 버튼
      floatingActionButton: actionbutton(), // text위에서 ctrl . center
      floatingActionButtonLocation: FloatingActionButtonLocation
          .centerFloat, // 버튼위치조정 centerFloat:가운데에있고 아래살짝떠있음
    );
  }

  /// context : 현재 보고 있는 화면 (App)
  /// 기본 Wedget 이 아닌 Alert 등을 띄울때는 어떤 context 를 대상으로
  /// 실행할 것인지를 명시해 주어야 한다.
  /// flutter 에서는 context 라는 대상이 많이 나온다
  // return type Future
  // dialog 만들고
  Future<void> _showDialog() async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("안녕"), // title 필수항목
          content: const Text("반갑습니다"), // content : 구체적내용
          actions: [
            // 창에있는버튼들
            TextButton(
              onPressed: () =>
                  // pop:누르면 현재창(다이어로그)닫음
                  // (context, 리턴값("취소"))
                  Navigator.pop(context, "취소"),
              child: const Text("취소"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, "확인"),
              child: const Text("확인"),
            ),
          ],
        );
      },
    );
  }

// floatingActionButton : method 분리 : state 클래스내부의 별도 함수
  FloatingActionButton actionbutton() {
    // 버튼에서 확장한 기능
    return FloatingActionButton.extended(
      // 버튼눌렀을때
      onPressed: () => {_showDialog()}, // 오류안나게 비어있는함수 선언해둬야함 / 만든함수넣기
      // child: const Icon(Icons.add_a_photo), // Icons.add~~ 여러아이콘 사용가능
      label: const Text("Clcik"), // 텍스트가 적힌 버튼으로
      isExtended: true,
      // + 아이콘도 같이붙임
      icon: const Icon(
        Icons.add, // <<< 왼쪽에 아이콘 모양보임 & add끝에두고 ctrl spacebar 하면 모양보고 선택가능
        size: 30,
      ),
      // 글자색 바탕색변경
      foregroundColor: Colors.white,
      backgroundColor: Colors.red,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 30, // 버튼에 그림자
    );
  }
}

// body 위젯으로 분리 : 별도의 클래스(권장)
class AppBody extends StatelessWidget {
  const AppBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, //이게 화면 (세로)가운데로
        // children 여러개 포함가능하단 뜻
        children: [
          Text(
            "대한민국",
            style: TextStyle(fontSize: 30, color: Colors.blue),
          ),
          Text("우리나라만세"),
          Text("Repulbic of Korea"),
        ],
      ),
    );
  }
}
