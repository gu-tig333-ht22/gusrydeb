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
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIG169 TODO"),
        centerTitle: true,
        actions: [PopupMenuButton(
          onSelected: (value) {
            Provider.of<MyState>(context, listen: false).setFilterBy();
          },
          itemBuilder: (context) => [
            PopupMenuItem(child: Text("all"), value: "all"),
            PopupMenuItem(child: Text("done"), value: "done"),
            PopupMenuItem(child: Text("not done"), value: "not done"),

          ],
        )],
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
                  builder: (context) => AddToDoView(ToDo(
                        message: "", checkbox: Checkbox(value: false, onChanged: null),
                      ))));
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
  return list.sublist(1,3);
}