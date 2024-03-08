import 'dart:async';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.workTimer}); // 자동완성되면 this.없으니추가
  final int workTimer;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// 변수의 late 초기화
  /// flutter(dart)에서는 변수를 반드시 초기화를 해야하는 원칙이 있다
  /// 즉 변수를 선언만 해서는 문법상 오류가 발생한다.
  /// 이 코드에서 _timer 는 이후 if() 명령문에서 조건에 따라 초기화를 늦게 시킬예정이다
  /// 처음 변수를 선언할때 초기값을 지정하지 않는다
  /// 이 코드는 flutter(dart)의 변수 초기화 원칙에 위배된다
  /// 이럴때 late 라는 키워드를 부착하여 조금있다가 아래 코드에서
  /// 변수를 꼭!! 초기화 할테니 일단 보류 해달라 라는 의미

// state 클래스 에서 선언된 변수는 state
// late 는 late 키워드는 변수가 선언된 곳보다 나중에 초기화가 이루어질 것임을 Dart 컴파일러에게 알리는 역할
// timer는 나중에 초기화될 것이며, 초기화 전까지는 사용되지 않을 것이라는 것을 보장
// Timer 클래스는 Dart에서 일정 시간 후에,
// 또는 일정 시간 간격으로 작업을 수행하도록 예약하는 데 사용
// 예를 들어, 특정 작업을 5초 후에 실행하거나,
// 매 1초마다 작업을 반복하는 등의 기능을 구현할 때 Timer 클래스를 사용
  late Timer _timer;
  // static const int wantTimer = 10;
  // 타이머의 현재 시간을 나타내는 _count 변수를 wantTimer로 초기화

  // main 으로 부터 전달받은 workTimer
  // workTimer 는 setting_page 에서 일할시간을 변경하면 그 값을 전달해주는
  // 전달자 state 이다.
  // 즉, setting_page 에서 일할시간을 변경하면 timer 의 전체시간이 변경되어야한다.
  // 일반적인 코드 형식이라면
  // int _count = workTimer 이라고 한다.

  // 하지만 Flutter의 State<> 에서는
  // int _count = widget.workTimer 라고 사용을 해야 한다
  // 문제는 State<> 클래스 영역에서는 widget 을 사용할 수 없다.
  // 따라서 _count 변수에 workTimer 값을 할당하기 위해서는
  // 별도의 방법을 사용해야 한다

  //  Flutter 의 State<> 클래스에는 initState() 라는 함수를 사용할 수 있다
  //  이 함수에서 _count 변수에 widget.workTimer 값을 할당하는
  //  코드를 사용해야 한다.         = init 내에서 사용해라~
  int _count = 5;
  // 타이머의 실행 상태
  bool _timerRun = false;

// init 자동완성..
// State<> class 가 mount 될때 자동으로 실행되는 함수
  @override
  void initState() {
    super.initState();
    _count = widget.workTimer;
  }

// 클릭하면 실행상태를 false 에서 반전해서 true 로 바꿔서 실행시키고
  void _onPressed() {
    // setState(() {})는 Flutter에서 상태 변경을 알리고 UI를 다시 그리라는 명령
    setState(() {
      // _timerRun의 상태를 반전시키고, 그 변경사항을 화면에 반영
      _timerRun = !_timerRun;
    });
    // timerRun이 true인 경우, 1초마다 _count 값을 1 감소시키는 타이머를 시작합니다.
    // _count 값이 1보다 작아지면, _count 값을 wantTimer 값으로 재설정하고,
    // _timerRun을 false로 설정하며, 타이머를 취소
    if (_timerRun) {
      // Timer.periodic() 특정 작업을 반복적으로 수행하도록 예약하는 데 사용
      _timer = Timer.periodic(
        // 1초에 한번씩 이 안의 함수를 실행하라
        const Duration(seconds: 1),
        // late Timer _timer; 였어서 _timer.cancle() 을 하고싶으면 초기화를하고 써야해서
        // timer 라는 매개변수를 만들면 불러와진 시점에서 초기화 된거라
        //  timer.cancel(); 로 사용
        (timer) {
          // 1초마다 1씩감소
          setState(() => _count--);
          // 1미만이되면
          if (_count < 1) {
            // 현재 시간을 다시 wantTimer (10) 으로 초기화
            _count = widget.workTimer;
            // 카운트 중지
            _timerRun = false;
            // 실행중인 타이머 취소
            timer.cancel();
          }
        },
      );
    } else {
      // 사용자가 다시 누르면 타이머가 중지되도록하게끔
      // 클릭할때 카운트 실행기가 값이 반전되니까
      _timer.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: TextButton(
        onPressed: _onPressed,
        child: Center(
          child: Text(
            "$_count",
            style: TextStyle(
              fontSize: 80,
              fontWeight: FontWeight.w900,
              // 글자모양
              foreground: Paint()
                ..style = PaintingStyle.stroke
                ..strokeWidth = 1
                ..color = Colors.white,
            ),
          ),
        ),
      ), // center로감싸서 버튼 가운데로
    );
  }
}
