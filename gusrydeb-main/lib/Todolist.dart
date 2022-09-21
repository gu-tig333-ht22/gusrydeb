import 'dart:html';
import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ToDoListView.dart';
import 'addtodoview.dart';
import 'main.dart';


class Todolist extends StatelessWidget {
  final List<ToDo> list;

  Todolist(this.list);

  Widget build(BuildContext context) {
    return ListView(
        children: list.map((card) => _cardItem(context, card)).toList());
  }

  Widget _cardItem(context, card) {
    return ListTile(
        title: Text(card.message),
        trailing: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            var state = Provider.of<MyState>(context, listen: false);
            state.removeCard(card);
          },
        ));
  }
}

class ToDo {
  String message;

  ToDo({required this.message});
}

class MyState extends ChangeNotifier {
  List<ToDo> _list = [];

  List<ToDo> get list => _list;

  void addCard(ToDo card) {
    _list.add(card);
    notifyListeners();
  }

  void removeCard(ToDo card) {
    _list.remove(card);
    notifyListeners();
  }
}


