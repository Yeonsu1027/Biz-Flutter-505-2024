import 'package:flutter/material.dart';

void main() {
  // App 클래스 호출한게 아니고 생성자 호출
  // runApp : App 이라는 클래스를 만들어 나에게줘!
  runApp(const App());
}

/// App 화면의 전체적인 Layout 을 구성하는 class
/// 변화가 없는 text, 이미지 등을 표현하거나
/// StatefulWedget 을 포함하는 layout class 이다.
///
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // throw UnimplementedError(); // 강제로 익셉션 발생시키는 코드
    return const MaterialApp(
      title: "안녕하세요",
      home: Scaffold(
        // collum : 세로 나열
        // row : 가로 나열
        body: Row(
          children: [
            Text(
              "우리나라만세",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              "대한민국만세",
              style: TextStyle(fontSize: 30),
            ),
            Text(
              "Rebulic of Korea",
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
    );
  }
}

// 화면에 구체적인 기능을 수행할 Wedget 을 포함하는 class
// State 클래스를 생성하는 일을 수행
// State 클래스들을 관리하는 역할 수행
class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override

  // State<StatefulWidget> createState() => _Homepage();
  State<StatefulWidget> createState() => _Homepage();
}

/// 화면을 구현하는 구체적인 역할 수행
/// 변화하는 Text, 이미지 등을 표현한다.
/// 언더바(_) 가 부착된 함수, 변수, 클래스 등은 private 특성을 갖는다
/// 위의 코드랑 같이있어야 쓸 수 있음!!
class _Homepage extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    // Scaffold(); : 위젯의 가장 기본코드
    return const Scaffold(
      // Center 라는 위젯박스의
      body: Center(
        // 텍스트 함수
        child: Text(
          "반갑습니다",
          style: TextStyle(
            fontSize: 50,
            color: Colors.blue,
          ),
        ), // 문자하나도 위젯써야함
      ),
    );
  }
}
