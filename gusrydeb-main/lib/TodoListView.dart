import 'dart:html';
import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Todolist.dart';
import 'addtodoview.dart';
import 'main.dart';

class TodoListView extends StatelessWidget {
    const TodoListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIG169 TODO"),
        centerTitle: true,
        actions: [PopupMenuButton(
          onSelected: (value) {
            Provider.of<MyState>(context, listen: false).setFilterBy("all" , value);
          },
          itemBuilder: (context) => [
            PopupMenuItem(child: Text("all"), value: "all"),
            PopupMenuItem(child: Text("done"), value: "done"),
            PopupMenuItem(child: Text("not done"), value: "not done"),

          ],
        )],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) => TodoList(state.list),
          ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var newCard = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddToDoView(ToDo(
                        message: " ", isDone: false),
                      )));
          if (newCard != null) {
            Provider.of<MyState>(context, listen: false).addCard(newCard);
          }
        },
      ),
    );
  }
}

List<ToDo>? _filterList(list, filterBy) {
  if (filterBy == "all") return list;
  if (filterBy == "done") return list.where((ToDo) => ToDo.isDone == true).toList();
  else if (filterBy == "not done") {
      return list.where((ToDo) => ToDo.isDone == false).toList();
    }
  return list;
}