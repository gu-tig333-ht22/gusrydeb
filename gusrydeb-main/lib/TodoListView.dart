import 'dart:html';
import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Todolist.dart';
import 'addtodoview.dart';
import 'main.dart';

class TodoListView extends StatefulWidget {
  @override
  State<TodoListView> createState() => _TodoListViewState();
}

class _TodoListViewState extends State<TodoListView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIG169 TODO"),
        centerTitle: true,
        actions: [
          PopupMenuButton(
            onSelected: (value) {
              Provider.of<MyState>(context, listen: false).setFilterBy(value as String);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "all", child: Text("all")),
              const PopupMenuItem(value: "done", child: Text("done")),
              const PopupMenuItem(value: "not done", child: Text("not done")),
            ],
          )
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) =>
            Todolist(_filterList(state.list, state.filterBy)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var newCard = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddToDoView(
                        ToDo(
                            message: " ",
                            checkbox:
                                const Checkbox(value: false, onChanged: null)),
                      )));
          if (newCard != null) {
            Provider.of<MyState>(context, listen: false).addCard(newCard);
          }
        },
      ),
    );
  }
}

List<ToDo> _filterList(list, filterBy) {
  if (filterBy == "not done") {
    List<ToDo> myList = [];
    for (var i = 0; i < list.length; i++) {
      // TO DO
      var currentElement = list[i];
      if (currentElement.value == false) myList.add(currentElement);
    }
    return myList;
  }
  if (filterBy == "done") {
    List<ToDo> myList = [];
    for (var i = 0; i < list.length; i++) {
      // TO DO
      var currentElement = list[i];
      if (currentElement.value == true) myList.add(currentElement);
    }
    return myList;
  }
  return list;
}
