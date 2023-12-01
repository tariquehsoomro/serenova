import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];
  final _todotaskbox = Hive.box("todolistbox");

  // first time opening app will run this method
  void createInitialData() {
    toDoList = [
      ["Default ToDo", false]
    ];
  }

  void loadData() {
    toDoList = _todotaskbox.get("TODOLIST");
  }

  void updateData() {
    _todotaskbox.put("TODOLIST", toDoList);
  }
}