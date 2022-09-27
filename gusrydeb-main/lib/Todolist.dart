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
          decoration: card.value ? TextDecoration.lineThrough : null,
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
      value: card.value,
      onChanged: (val) {
        setState(() {
          card.value = val!;
        });
      },
    ));
  }
}

class ToDo {
  Checkbox checkbox = const Checkbox(value: false, onChanged: null);
  String message = 'nothing';
  bool value = false;

  ToDo({required this.message, required this.checkbox});

  }

  

class MyState extends ChangeNotifier {
  final List<ToDo> _list = [];
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
    _filterBy = filterBy;
    notifyListeners();
  }
}
