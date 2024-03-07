import 'package:flutter/material.dart';
import 'package:timer/home_page.dart';
import 'package:timer/setting_page.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // 기본색상 wihte 안됨 / 보통 색상표뜨면 쓸 수 있음
        primarySwatch: Colors.amber,
      ),
      home: const MainPage(), // MainPage 연결
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _pageindex = 1;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "images/tomato.jpg",
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // 메인 페이지위에 홈페이지를 겹쳐둔것
        body: PageView(
          scrollDirection: Axis.horizontal,
          onPageChanged: (value) => setState(() => _pageindex = value),
          children: const [HomePage(), SettingPage()],
        ),
      ),
    );
  }
}
