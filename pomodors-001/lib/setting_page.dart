import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  // required this.onChange : onChange 함수를 반드시 전달 받겠다.
  // 현재 메인에서 보낸 onChange 는
  // onChangeSetting: 3개 넘개 입력하면 입력한게 스낵바로 나옴

  // required this.onChange
  // main 으로 부터 onChange 라는 props 를 반드시 받도록 선언하기
  const SettingPage(
      {super.key, required this.onChange, required this.workTimer});
  final int workTimer;
  // state 로 보내기위해 한 번 더 그리고 쓸때는 (아래에) 위젯widget.onChange(value),

  // State 에서 onChange 를 사용할 수 있도록 선언하기
  // onChange 라는 props 는 함수이다(Function)
  // 또한 문자열형 매개변수를 통하여 값을 전달할 수 있다.
  // onChange 함수를 사용하는 곳에서 문자열을 전달하면 그 문자열이
  // main 으로 전달된다
  final Function(String) onChange;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  final workTimeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    workTimeController.text = widget.workTimer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // settings_ui에 들어있는 것 SettingsList
        body: SettingsList(
      sections: [
        SettingsSection(
          title: const Text("타이머설정"),
          tiles: [
            // 이거 하나가 섹션(Tile 이 하나의 그룹)
            SettingsTile(
              leading: const Icon(Icons.timer_outlined),
              title: TextField(
                // TextField 에 id(ref) 부착하기
                controller: workTimeController,

                /// StateFull 에서 선언한 props 를 사용할때는
                /// widget.Props 형태로 사용한다
                /// StateFull 에서 선언한 onChange 함수를
                /// widget.onChange() 라는 형식으로 사용한다.
                /// 만약 이 함수에 전달할 값이 필요없다면
                /// onChanged : widget.onChange 형식으로 사용하면 된다
                /// 하지만 현재 widget.onChange 함수는 문자열형 매개변수를
                /// 필요로 하도록 선언되어 있다 : final Function(String) onChange
                ///
                /// 필요한 값을 전달하기 위하여 함수 선언형으로 event 핸들러를
                /// 사용한다.
                // 사용할때 앞에 widget.
                onChanged: (value) => widget.onChange(value), // 입력내용 메인에 전달
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "일할시간",
                    contentPadding: EdgeInsets.all(0),
                    hintText: "타이머 작동시간을 입력하세요",
                    hintStyle: TextStyle(
                      color: Colors.blue,
                    )),
              ),
            ),
            SettingsTile(
              leading: const Icon(Icons.timer_outlined),
              title: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "휴식시간",
                ),
              ),
            ),
            SettingsTile(
              leading: const Icon(Icons.timer_outlined),
              title: const TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "반복횟수",
                ),
              ),
            ),
            // 온오프(?)버튼 만들기
            SettingsTile.switchTile(
              // 기본값을 켜진걸로 // false 꺼진거
              initialValue: true,
              onToggle: (value) => {},
              title: const Text("알람"),
            )
          ],
        ),
      ],
    ));
  }
}
