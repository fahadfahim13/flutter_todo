import 'package:hive/hive.dart';

class TodoDatabase {
  List toDoList = [];
  final _todoBox = Hive.box('todoBox');

  void createInitialdata() {
    toDoList = [];
  }


  // load data from database
  void loaddata() {
    toDoList = _todoBox.get('TODOLIST');
  }

  // update database
  void updateData() {
    _todoBox.put('TODOLIST', toDoList);
  }

}