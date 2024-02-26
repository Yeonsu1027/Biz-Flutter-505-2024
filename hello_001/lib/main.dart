import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // 생성자가 여긴 const 라는 키워드로 시작한다
  const MyApp({super.key});

  // This widget is the root of your application.
  @override // 상속받아 재정의
  // Widget: 클래스, 빌드는 리턴타입이 위젯이어야한다. 여긴 모든타입이 위젯
  Widget build(BuildContext context) {
    // json 구조와 비슷하다
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '나의 플러터 프로젝트'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 실제 코딩할 곳
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    // react의 상태같은거
    setState(() {
      // 카운트변수 1씩 증가
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              '버튼을 클릭해 주세요',
            ),
            Text(
              '$_counter', // 카운트 라는 변수를 표시하라 js의 백틱같은거
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      // 액션버튼 누르면 인크리먼트 함수를 실행하라
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
