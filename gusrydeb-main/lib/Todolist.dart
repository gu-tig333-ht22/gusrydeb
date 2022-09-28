import 'dart:html';
import 'dart:js';

import 'package:flutter/gestures.dart';
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
   bool value = false;
  //final List<ToDo> list;

  //const TodoList(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.list.map((card) => _cardItem(context, card)).toList());
  }

  Widget _cardItem(context, card) {
    return Container(
        child: CheckboxListTile(
      title: Text(
        card.message,
        style: (TextStyle(
          fontSize: 20,
          decoration: card.IsDone ? TextDecoration.lineThrough : null,
          decorationThickness: 1,
        )),
      ),
      secondary: IconButton(
        icon:  Icon(Icons.close),
        onPressed: () {
          var state = Provider.of<MyState>(context, listen: false);
          state.removeCard(card);
        },
      ),
      controlAffinity: ListTileControlAffinity.leading,
      value: card.IsDone,
      onChanged: (value) {
        var state = Provider.of<MyState>(context, listen: false);
          state.updatingTodo(card);
          }
        ),
    );
  }
}

class ToDo {
 // Checkbox checkbox = const Checkbox(value: false, onChanged: null);
  String message = 'nothing';
  bool IsDone;
  String id;

  ToDo({required this.message, this.IsDone =false, required this.id});

    void todoIsDone(ToDo card) {
    IsDone = !IsDone;
    }

  static Map<String, dynamic> toJson(ToDo card) {
    return {
      'title': card.message,
      'done': card.IsDone,
    };
  }

  static ToDo fromJson(Map<String, dynamic> obj) {
    return ToDo(
      message: obj['title'],
      IsDone: obj['done'],
      id: obj['id'],
    );
  }
}
  

class MyState extends ChangeNotifier {
  List<ToDo> _list = [];
  String _filterBy = "all";


  List<ToDo> get list => _list;
  String get filterBy => _filterBy;

  Future getTodo() async {
    List<ToDo> list = await InternetFetcher.fetchingToDos();
    _list = list;
    notifyListeners();
  }


  void addCard(ToDo card) async {
    _list = await InternetFetcher.addTodo(card);
    notifyListeners();
  }

  void removeCard(ToDo card) async {
    _list = await InternetFetcher.DeletingToDo(card.id);
    notifyListeners();
  }

  void setFilterBy(String filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }

   void updatingTodo(ToDo card) async {
    card.todoIsDone(card);
    _list = await InternetFetcher.updateToDo(card.id, card);
    notifyListeners();
  }

  void IsDone(ToDo card) {
    card.todoIsDone(card);
    notifyListeners();
  }
}
