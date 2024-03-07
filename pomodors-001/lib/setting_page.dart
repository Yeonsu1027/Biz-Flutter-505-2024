import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingPage extends StatefulWidget {
  // required this.onChange : onChange 함수를 반드시 전달 받겠다.
  // 현재 메인에서 보낸 onChange 는
  // onChangeSetting: 3개 넘개 입력하면 입력한게 스낵바로 나옴
  const SettingPage({super.key, required this.onChange});
  // state 로 보내기위해 한 번 더 그리고 쓸때는 (아래에) 위젯widget.onChange(value),
  final Function(String) onChange;

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
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
                // 사용할때 앞에 widget.
                onChanged: (value) => widget.onChange(value),
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
