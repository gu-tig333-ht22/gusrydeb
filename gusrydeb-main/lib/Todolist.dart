import 'dart:html';
import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ToDoListView.dart';
import 'addtodoview.dart';
import 'main.dart';

class TodoList extends StatelessWidget {
  final List<ToDo> list;

  const TodoList(this.list, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: list.map((ToDo card) => _cardItem(context, card)).toList());
  }

  Widget _cardItem(context, card) {
    var state = Provider.of<MyState>(context, listen: false);
    return Container(
        child: CheckboxListTile(
      title: Text(
        card.message,
        style: (TextStyle(
          fontSize: 20,
          decoration: card.isDone ? TextDecoration.lineThrough : null,
          decorationThickness: 1,
        )),
      ),
      secondary: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          var state = Provider.of<MyState>(context, listen: false);
          state.removeCard(card);
        },
      ),
      controlAffinity: ListTileControlAffinity.leading,
      value: card.isDone,
      onChanged: (value) {
        state;
      },
    ));
  }
}

class ToDo {
  String message;
  bool isDone;

  ToDo({required this.message, required this.isDone});

  void ToDoisDone(ToDo todo) {
    isDone = !isDone;
  }

  static Map<String, dynamic> toJson(ToDo todo) {
    return {
      'title': todo.message,
      'done': todo.isDone,
    };
  }
}

class MyState extends ChangeNotifier {
  List<ToDo> _list = [];
  int _filterBy = 0;

  List<ToDo> get list => _list;
  int get filterBy => _filterBy;

  void isDone(ToDo card) {
    card.isDone;
    notifyListeners();
  }

  void addCard(ToDo card) {
    _list.add(card);
    notifyListeners();
  }

  void removeCard(ToDo card) {
    _list.remove(card);
    notifyListeners();
  }

  void setFilterBy(String filterBy, Object? value) {
    _filterBy = filterBy as int;
    notifyListeners();
  }

  void updatingTodo(ToDo card) {
    card.ToDoisDone(card);
    notifyListeners();
  }
}
