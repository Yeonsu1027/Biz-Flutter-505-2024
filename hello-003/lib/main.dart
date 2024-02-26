import 'package:flutter/material.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp 에서 전체적인 어플의 테마 변경
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 화면오른쪽에있던 디버그 없앰
      debugShowMaterialGrid: false, // 격자무늬 배치확인용
      // 작성했을때 the cons~~ 오류나오면 감싸고있는 위젯의 const 지움
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

// s 입력하고 state위젯~ 클릭하고 그상태에서 HomePage 입력
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // State<> 클래스에 선언된 변수중 final, const 가 부착되지 않으면
  // 이 변수는 >자동<으로 state 변수가 된다.
  // setState() 라는 함수를 통하여 값을 변경하고,
  // 변경된 변수는 필요한 곳에서 변화되어 표시된다
  int _nums = 0;
  void clickHandler() {
    // 클릭하면 nums 값증가
    setState(() => _nums++);
  } // 출력할 곳을 지정안했음 : 선언형 코드

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "안녕하세요",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        centerTitle: true, // 타이틀 중앙정렬
      ),
      body: Center(
        child: Column(
          // 메인~클래스에 센터변수 선언
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // nums 변수값 출력
            Text("$_nums",
                style: const TextStyle(
                  fontSize: 30,
                )),
            const Text("대한민국"),
            const Text("우리나라"),
            const Text("Republic of Korea"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: clickHandler,
        child: const Icon(Icons.add),
      ),
    );
  }
}
