import 'dart:html';
import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ToDoListView.dart';
import 'addtodoview.dart';
import 'main.dart';

class Todolist extends StatefulWidget {
  final List<ToDo> list;

  Todolist(this.list);

  @override
  State<Todolist> createState() => _TodolistState();
}

class _TodolistState extends State<Todolist> {
  bool value = false;

  bool _checked = true; //fel- hela listan blir checkad

  Widget build(BuildContext context) {
    return ListView(
        children: widget.list.map((card) => _cardItem(context, card)).toList());
  }

  Widget _cardItem(context, card) {
    return CheckboxListTile(
      title: Text(card.message),
      secondary: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          var state = Provider.of<MyState>(context, listen: false);
          state.removeCard(card);
        },
      ),
      value: _checked,
      onChanged: (val) {
        setState(() {
          _checked = val!;
          if (val == true) {
            _checked;
          }
          _checked;
        });
      },
    );
  }
}

class ToDo {
  Checkbox checkbox;
  String message;

  bool value = false;

  ToDo({required this.message, required this.checkbox});
}

class MyState extends ChangeNotifier {
  List<ToDo> _list = [];
  String _filterBy = "all";

  List<ToDo> get list => _list;

  String get filterBy => _filterBy;

  void addCard(ToDo card) {
    _list.add(card);
    notifyListeners();
  }

  void removeCard(ToDo card) {
    _list.remove(card);
    notifyListeners();
  }

  void setFilterBy(String filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }
}
