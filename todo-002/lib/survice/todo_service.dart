// 변수이름 대문자..
// ignore: constant_identifier_names

// ignore_for_file: unused_local_variable

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
// import 'package:todo2/main.dart';
import 'package:todo2/model/todo.dart';

// ignore: constant_identifier_names
const TBL_TODO = "tbl_todolist";
// """ 3개 연속된 문자열
const createrTodoTable = """
CREATE TABLE $TBL_TODO(id TEXT,
     sdate TEXT,
      stime TEXT,
       edate TEXT,
        etime TEXT,
        content TEXT, 
        complete INTEGER
        )
        """;

class TodoService {
  // ignore: unused_field
  late Database _databse;
//   Future<Database> get database() async {
// _databse = await
//   }

  onCreateTable(db, version) async {
    return db.execute(createrTodoTable);
  }

// 기존 테이블 제거 하고 새 테이블 생성
// initData / openDatabase 가 실행될때
// version 번호를 비교하여 새로운 version 번호가 있으면
// Table 의 구조를 변경한다.
  onUpgradeTable(db, oldVersion, newVersion) async {
    // 새 버전이나오면 업그레이드
    if (newVersion > oldVersion) {
      debugPrint("$oldVersion > $newVersion");
      final batch = db.batch();
      await batch.execute("DROP TABLE $TBL_TODO");
      await batch.execute(createrTodoTable);
      await batch.commit();
    }
  }

// 리턴타입 Database
  Future<Database> initDatabase() async {
    // 스마트 기기의 DB 저장소의 위치를 가져오는 함수
    String dbPath = await getDatabasesPath();
    // 저장소에 todo.dbf 란 이름으로 하나 만들어쓰겠다
    // 만약 폴더1/폴더2/폴더3/todo.dbf 라는 폴더 경로를 설정할때
    // 운영체제마다 dir seperatot 문자가 다르다
    // 어떤 운영체제는 슬래시(/)를 사용하고,
    // 어떤 운영체제는 역슬래시(\)를 사용한다.
    // "폴더1"+"/"+"폴더2"+"/"+"폴더3"
    // "폴더1"+"\"+"폴더2"+"\"+"폴더3"    윈도우 \ 역슬래시
    //
    // 이때 path.join() 이라는 함수를 사용하여 폴더를 결합하면
    // 자동으로 운영체제에 맞는 구분자 (dir seperator)를 만들어 준다
    // join 은 운영체제에 맞춰 자동으로 변환해준다.
    String dbFile = join(dbPath, "todo.dbf");

// todo db 파일오픈, 없으면 만들고, 있으면 업그레이드하라
    return await openDatabase(dbFile,
        onCreate: onCreateTable, onUpgrade: onUpgradeTable, version: 3);
  }

// DB를 사용할 수 있도록 open 하고 연결정보가 담긴 _database 변수를 초기화 한다
// flutter 에서 사용하는 다소 특이한 getter method
// 이 함수는 () 가 없고, 함수 이름 앞에 get 키워드가 있다
// 이 함수이름과 연관된 로컬변수 _함수 와 같은 형식의 변수가 있어야 한다.
  Future<Database> get database async {
    _databse = await initDatabase();
    return _databse;
  }

// Todo import
  insert(Todo todo) async {
    final db = await database;
    debugPrint("INSERT TO : ${todo.toString()}");
    var result = await db.insert(
      TBL_TODO,
      // todo.dart의 toMap()에서만든 제이슨 형식데이터를 insert하라
      todo.toMap(),
    );
  }

// future : 데이터를 준비해서 보내주겠단 약속
// 동적데이터에 대한 약속
// selectAll() 함수를 호출하면 반드시 List<Todo> 데이터 타입을 return 하겠다
  Future<List<Todo>> selectAll() async {
    final db = await database;
    // final todoList = await db.query((TBL_TODO));
    final List<Map<String, dynamic>> todoList =
        await db.query(TBL_TODO); // de.query로 가져오는거의 타입을 모르면 final만써도 인정해줌
    // lengt 만큼 반복하면서 함수 실행
    final result = List.generate(
      todoList.length,
      (index) => Todo.fromMap(todoList[index]),
    );
    return result;
  }
}
