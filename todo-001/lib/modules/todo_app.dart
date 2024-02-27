import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models/todo.dart';

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  // Todo 리스트를 빈배열로 선언 <>에서 ctrl space bar import

  Todo getTodo(String content) {
    return Todo(
      sdate: DateFormat("yyyy-MM-dd").format(
        // 현재날짜와시간을 문자열로
        DateTime.now(),
      ),
      stime: DateFormat("HH:mm:ss").format(
        DateTime.now(),
      ),
      content: content,
      complete: false,
    );
  }

  List<Todo> todoList = [];

  @override
  void initState() {
    super.initState();
    // todoList.add(getTodo("Start"));
    // todoList.add(getTodo("Second"));
    // todoList.add(getTodo("Third"));
  }

  @override
  // 리스트 보여주는 박스
  Widget build(BuildContext context) {
    // 한개씩의 리스트
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        // leading : text 앞에 이미지 붙여라
        leading: Image.asset(
          "assets/user.png",
          // Box에 가득채워서
          fit: BoxFit.fill,
        ),
        title: const Text("TODO"),
        // actions 배열:여러개버튼
        actions: [
          IconButton(
            // 방법2 : 그냥쓸때
            onPressed: _showTodoInputDialog,
            icon: const Icon(
              Icons.add_alarm,
              color: Colors.white,
            ),
          ),
          IconButton(
            // 방법1 : 쇼~ 이벤트에 값을 넘겨줄때
            onPressed: () => {_showTodoInputDialog()},
            icon: const Icon(
              Icons.add_alarm,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () => {},
            icon: const Icon(
              Icons.add_alarm,
              color: Colors.white,
            ),
          )
        ],
      ),

      // ListView : builder함수를써서 list 담긴 데이터를 화면에 출력
      body: ListView.builder(
        itemCount: todoList.length, //리스트 개수만큼, 이게있어야 빨갛게x..
        itemBuilder: (context, index) {
          // return Dismissible(
          // key: UniqueKey(),  화면에서 밀면 사라짐
          return Dismissible(
              key: UniqueKey(),
              // 배경상자
              background: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                color: Colors.green,
                // 아이콘왼쪽
                alignment: Alignment.centerLeft,
                child: const Icon(
                  Icons.save_alt_sharp,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              // 세컨더리백그라운드
              secondaryBackground: Container(
                margin: const EdgeInsets.all(8),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                // 왼쪽으로밀면 빨간색에 쓰레기통아이콘
                color: Colors.red,
                alignment: Alignment.centerRight,
                child: const Icon(
                  Icons.delete_outline,
                  size: 36,
                  color: Colors.white,
                ),
              ),
              child: Material(
                child: InkWell(
                  onTap: () => {},
                  highlightColor: Colors.red.withOpacity(0.3), // 꾹눌렀을때
                  splashColor: Colors.blueAccent.withOpacity(0.3), // 잠깐눌렀을때
                  // 화면에 그림그리는 부분
                  // 타일안에 로우, 로우안에 칼럼과 패딩박스
                  // 칼럼안에 날짜, 시간, 로우안에 칼럼, 리스트
                  child: ListTile(
                    title: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              // 날짜 회색,크기12
                              todoList[index].sdate,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            Text(
                              todoList[index].stime,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            // Text(todoList[index].content),
                          ],
                        ),
                        Expanded(
                          // 감싸는법 : 패딩에서 컨트롤 . 위젯하고 이름바꿈
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text(
                              todoList[index].content,
                              style: const TextStyle(
                                fontSize: 20,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),

              /// 사라지기전에 실행할 event
              confirmDismiss: (direction) {
                if (direction == DismissDirection.endToStart) {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("삭제할까요?"),
                        actions: [
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text("예"),
                          ),
                          ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text("취소"),
                          )
                        ],
                      );
                    },
                  );
                } else {
                  return Future.value(false);
                }
              },

              /// 사라진 후에 실행할 event
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  setState(() {
                    todoList.removeAt(index);
                  });
                }
              });
        },
      ),
    );
  }

  Future<void> _showTodoInputDialog() {
    // build : ctrl spacebar / (context){} 자동생성
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("할일등록"),
          // TextField() : input box
          actions: [
            _todoInputBox(context),
          ],
        );
      },
    );
  }

// Expanded Widget
// Column, Row 등으로 Widget 을 감싸면 content 가 없는 경우
  /// Widget 이 화면에서 사라져버리는 경우가 있다
  /// 이때는 그 Wieget 을 Expanded Widget 으로 감싸주면 해결된다.
  Widget _todoInputBox(BuildContext context) {
    return Padding(
      // 테두리를 8.0 만큼안으로 들여쓰기하라
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Row(
            children: [
              /// Expanded Widget
              /// coolumn, row 등으로 widget 을 감싸면 content 가 없는경우
              /// widget 이 화면에서 사라져 버리는 경우가 있다
              /// 이 때는 그 widget 을 Expanded Widget으로 감싸주면 해결
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.go,
                  // hintText: placeholder
                  decoration: const InputDecoration(hintText: "할 일을 입력해 주세요"),
                  // onssubmitt 이 이루어지면 입력값이 value 변수에담기고
                  onSubmitted: (value) {
                    setState(() {
                      // 그 value 값을 todoList 에 추가
                      todoList.add(getTodo(value));
                    });
                    // SnackBar 를 띄우기 위해 snackBar 객체(변수) 선언
                    SnackBar snackBar = const SnackBar(
                      content: Text("할일이 등록됨"),
                    );
                    // ScaffoldMessenger 에게 snackBar 를 표시해줘 라고 요청
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // alert dialog 를 닫아라
                    Navigator.of(context).pop();
                  },
                ),
              ),
              IconButton(
                onPressed: () => {},
                icon: const Icon(
                  Icons.send_outlined,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
} // todo state end
