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
                             id: ''),
                      )));
          if (newCard != null) {
            Provider.of<MyState>(context, listen: false).addCard(newCard);
          }
        },
      ),
    );
  }
}

List<ToDo> _filterList(list, value) {
 if (value == 'all') return list;
    if (value == 'done') {
      return list.where((card) => card.IsDone == true).toList();
    } else if (value == 'not done') {
      return list.where((card) => card.IsDone == false).toList();
    }
    return list;
  }

