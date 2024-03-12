import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:todo2/model/todo.dart';
import 'package:todo2/survice/todo_service.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TodoHome(),
    );
  }
}

class TodoHome extends StatefulWidget {
  const TodoHome({
    super.key,
  });

// State<> 클래스를 생성하여 화면을 그리는 객체로 만들기
  @override
  State<TodoHome> createState() => _TodoHomeState();
}

//  State<> 화면에 변화되는 변수를 사용하거나, 여러가지 interactive 한
// 화면을 구현하는 Widget class
class _TodoHomeState extends State<TodoHome> {
  // TextField 에 ID(refs 레퍼런스)를 부착하기 위한 state
  final todoInputController = TextEditingController();
  String todo = "";

  getTodo(String todo) {
    return Todo(
      // flutter pub add uuid
      id: const Uuid().v4(),
      // 현재 디바이스의 날짜를 가져와서 (DateTime.now())
      // 문자열 형식으로 변환하라
      sdate: DateFormat("yyyy-MM-dd").format(DateTime.now()),
      stime: DateFormat("HH:ss:mm").format(DateTime.now()),
      edate: "",
      etime: "",
      content: todo,
      complete: false,
    );
    // return todoDto;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: const Text("TODO List"),
        ),
        // SafeArea 모양잡는용
        bottomSheet: bottomSheet(context),

        /// FutureBuilder
        /// 데이터베이스에서 가져온 List<Todo> 데이터를 화면에 표현하기 위한
        /// 빌더(생성자, 만들기함수)
        /// selectAll() 한 데이터를 future 속성에 주입
        /// 내부에서 가공되어 builder 의 snapshot 에 다시 데이터를 전달한다
        body: todoListBody(context));
  }

  Widget todoListBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        // width 최대값
        mainAxisSize: MainAxisSize.max,
        children: [
          FutureBuilder(
            future: TodoService().selectAll(),
            // future가 스냅샷거쳐 빌더에저장
            builder: (context, snapshot) {
              //  snapshot.data의 데이터를 List<Todo> type 으로 변환하여 todoList에 할당
              var todoList = snapshot.data as List<Todo>;

              // todoList snapshot data 를 가지고 실제 list 를 화면에 그리는 도구
              return ListView.builder(
                shrinkWrap: true,
                // 이 개수 만큼 화면을 그려라
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  // 리스트뷰를 이용하여 리스트를 보이게
                  return Text(todoList[index].content);
                },
              );
            },
          ),
        ],
      ),
    );
  }

// 모든함수는 리턴타입 위젯으로
  Widget bottomSheet(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          width: double.infinity,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20),
            // input
            child: TextField(
              // id 생성
              controller: todoInputController,
              onChanged: (value) => {
                setState(() {
                  todo = value;
                })
              },
              decoration: InputDecoration(
                  hintText: "할일을 입력하세요",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50)),
                  // 인풋박스안에 사이드 박스, 아이콘
                  // prefix 앞에
                  prefix: const SizedBox(
                    width: 20,
                  ),
                  // suffix 뒤에
                  suffix: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => {todoInputController.clear()},
                        icon: const Icon(Icons.clear),
                      ),
                      IconButton(
                        onPressed: () async {
                          // var : "동적타이핑" 얘가 알아서 타입을 정함 (개발자 책임, 다른 문제가 생길 수 있음)
                          // 타입 기억하기어려우면 적음됨
                          var snackbar = SnackBar(content: Text(todo));
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);

                          var todoDto = getTodo(todo);

                          // sw키보드 감추기
                          FocusScope.of(context).unfocus();
                          await TodoService().insert(todoDto);
                          todoInputController.clear(); // 입력하고 난후 지워라
                        },
                        icon: const Icon(Icons.send_outlined),
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

// class TodoListBody extends StatelessWidget {
//   const TodoListBody({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return const FutureBuilder();
//   }
// }
