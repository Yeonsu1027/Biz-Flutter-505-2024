import 'package:flutter/material.dart';
import 'package:timer/dash_page.dart';
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
  int _pageIndex = 1;
  int wantTimer = 20;

  void onChangeSetting(String value) {
    // 3개넘게 입력하면 스낵바에 표시
    if (value.length > 3) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(value)));
    }
  }

// flutter dart에서 변수를 선언할때 final, const 키워드가 있으면
// 변수의 type 을 명시하지 않아도 된다
// 단, 이때 반드시 값이 초기화 되어야 한다

// PageController type 의 변수 선언
// HTML tag 에 id 를 적용하는 것처럼 flutter 에서 화면에 표시되는
// coponent 에 id를 부착하기 위해 선언하는 변수
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "images/tomato.jpg",
          ),
          // 이미지 전체보여주기
          fit: BoxFit.cover,
        ),
      ),
      // Scaffold : 앱의 기본 뼈대
      child: Scaffold(
        backgroundColor: Colors.transparent,
        // 메인 페이지위에 홈페이지를 겹쳐둔것
        // PageView : 슬라이드 형식으로 페이지를 넘길 수 있게함
        body: PageView(
          controller: _pageController,
          // 수평 스크롤 (좌우로 화면넘김) // 상하 : Axis.vertical
          scrollDirection: Axis.horizontal,
          // 페이지가 바뀌면 value가 pageIndex에 담김
          onPageChanged: (value) => setState(() => _pageIndex = value),
          // 이 순서대로 화면나오게 됨
          children: [
            const HomePage(),
            const DashPage(),
            SettingPage(
            // onChangeSetting 함수를 onChange 이름으로 전달
            // 3개 넘개 입력하면 입력한게 스낵바로 나옴
              onChange: onChangeSetting,
            ),
          ],
        ),

        bottomNavigationBar: BottomNavigationBar(
          // 현재 페이지 번호에따라 아이콘 색상변경
          //  currentIndex: _pageIndex // 현재 탭의 인덱스지정
          currentIndex: _pageIndex,
          onTap: (value) {
            // 눌린탭 인덱스_pageIndex 에 저장
            _pageIndex = value;
            // _pageController 로 해당페이지로 애니메이션으로 넘어감
            _pageController.animateToPage(
              value,
              // 애니메이션기능
              duration: const Duration(milliseconds: 500), // 0.5초 지속
              curve: Curves.ease, // 애니메이션 속도
            );
            // setState 상태를 업데이트하여 위젯을 다시빌드
            setState(() => {});
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.dashboard_sharp),
              label: "DashBoard",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: "setting",
            )
          ],
        ),
      ),
    );
  }
}
