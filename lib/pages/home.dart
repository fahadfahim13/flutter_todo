import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo/data/database.dart';
import 'package:todo/utils/add_todo.dart';
import 'package:todo/utils/todo_tile.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _todoBox = Hive.box('todoBox');
  final textController = TextEditingController();
  TodoDatabase db = TodoDatabase();

  @override
  void initState() {
    if(_todoBox.get('TODOLIST') == null) {
      db.createInitialdata();
    } else{
      db.loaddata();
    }
    super.initState();
  }

  void checkBoxChanged(bool val, int idx) {
    setState(() {
      db.toDoList[idx]['taskCompleted'] = !db.toDoList[idx]['taskCompleted'];
    });
    db.updateData();
  }

  void addTodo() {
    var newVal = {'taskName': textController.text, 'taskCompleted': false};
    setState(() {
      db.toDoList = [...db.toDoList, newVal];
      textController.clear();
    });
    db.updateData();
    Navigator.of(context).pop();
  }

  void deleteTodo(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateData();
  }

  void onCancel() {
    setState(() {
      textController.clear();
    });
    Navigator.of(context).pop();
  }

  void createNewTask(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AddTodo(
            controller: textController,
            onSave: addTodo,
            onCancel: onCancel,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: const Text('TO DO'),
        backgroundColor: Colors.yellow,
        elevation: 0,
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createNewTask(context);
        },
        backgroundColor: Colors.yellow,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add
        )
      ),
      body: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, idx) => TodoTile(
              taskName: db.toDoList[idx]['taskName'],
              taskCompleted: db.toDoList[idx]['taskCompleted'],
              deleteFunction: (context) => deleteTodo(idx),
              onChanged: (p0) {
                checkBoxChanged(p0 ?? false, idx);
              }),
          ),
    );
  }
}
