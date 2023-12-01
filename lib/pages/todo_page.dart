import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:serenova/components/todo_list_dialog_box.dart';
import 'package:serenova/components/todo_tile.dart';
import 'package:serenova/data/database.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _todotaskbox = Hive.box("todolistbox");
  final _controller = TextEditingController();

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    if (_todotaskbox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }

    super.initState();
  }

  // check box was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });

    db.updateData();
  }

  void saveNewTask() {
    setState(() {
      if (_controller.text != "") {
        db.toDoList.add([_controller.text, false]);
        _controller.clear();
      }
    });

    Navigator.of(context).pop();

    db.updateData();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return ToDoListDialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.of(context).pop()
        );
      }
    );
  }

  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });

    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "TO DO",
          style: TextStyle(
            color: Color.fromARGB(255, 31, 31, 31),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.yellow[500],
        elevation: 0,
      ),
      backgroundColor: Colors.yellow[300],
      floatingActionButton: FloatingActionButton (
        backgroundColor: Colors.yellow[500],
        onPressed: createNewTask,
        child: const Icon(Icons.add, color: Color.fromARGB(255, 31, 31, 31)),
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteTile: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}