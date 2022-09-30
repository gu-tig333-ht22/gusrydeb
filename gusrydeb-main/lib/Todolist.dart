import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ToDoListView.dart';
import 'addtodoview.dart';
import 'main.dart';
import 'InternetFetcher.dart';

class Todolist extends StatefulWidget {
  final List<ToDo> list;

  Todolist(this.list);

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.list.map((task) => _taskItem(context, task)).toList());
  }

  Widget _taskItem(context, task) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey, 
          width: 0.25)
          ),
          child: CheckboxListTile(
            activeColor: Colors.transparent,
            checkColor: Colors.black54,
            title: Text(
              task.message,
              style: (TextStyle(
                fontSize: 20,
                decoration: task.isDone ? TextDecoration.lineThrough : null,
                decorationThickness: 1,
                )
              ),
            ),
            secondary: IconButton(
              icon:  Icon(Icons.close),
              onPressed: () {
                var state = Provider.of<MyState>(context, 
                listen: false);
                state.removeTodo(task);
              },
            ),
            controlAffinity: ListTileControlAffinity.leading,
            value: task.isDone,
            onChanged: (value) {
              var state = Provider.of<MyState>(context, 
              listen: false);
              state.updateTodo(task);
        }
      ),
    );
  }
}

class ToDo {
  String message = 'nothing';
  String id;
  bool isDone;

  ToDo({required this.message, required this.id, this.isDone =false});

    void TodoIsDone(ToDo task) {
    isDone = !isDone;
    }

  static Map<String, dynamic> toJson(ToDo task) {
    return {
      'title': task.message,
      'done': task.isDone,
    };
  }

  static ToDo fromJson(Map<String, dynamic> obj) {
    return ToDo(
      message: obj['title'],
      id: obj['id'],
      isDone: obj['done'],
    );
  }
}
  
class MyState extends ChangeNotifier {
  List<ToDo> _list = [];
  String _filterBy = "all";

  List<ToDo> get list => _list;
  String get filterBy => _filterBy;

  Future getTodo() async {
    List<ToDo> list = await InternetFetcher.fetchingTodo();
    _list = list;
    notifyListeners();
  }

  void addTodo(ToDo task) async {
    _list = await InternetFetcher.addingTodo(task);
    notifyListeners();
  }

  void removeTodo(ToDo task) async {
    _list = await InternetFetcher.deletingToDo(task.id);
    notifyListeners();
  }

   void updateTodo(ToDo task) async {
    task.TodoIsDone(task);
    _list = await InternetFetcher.updatingTodo(task.id, task);
    notifyListeners();
  }
  
  void isDone(ToDo task) {
    task.TodoIsDone(task);
    notifyListeners();
  }

  void setFilterBy(String filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }
}
