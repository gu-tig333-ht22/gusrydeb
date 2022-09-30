import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Todolist.dart';
import 'addtodoview.dart';

class TodoListView extends StatefulWidget {
  const TodoListView({super.key});

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
            onSelected: (value) {Provider.of<MyState>(context, listen: false).setFilterBy(value as String);
            },
            itemBuilder: (context) => [
              const PopupMenuItem(value: "all", child: Text("all")),
              const PopupMenuItem(value: "done", child: Text("done")),
              const PopupMenuItem(value: "undone", child: Text("undone")),
            ],
          )
        ],
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) =>Todolist(_filterList(state.list, state.filterBy)),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, 
        size: 50,
        color: Colors.white,
        ),
        backgroundColor: Colors.grey,
        onPressed: () async {
        var newtask = await Navigator.push(context,MaterialPageRoute(
          builder: (context) => AddToDoView(ToDo(
            message: " ",
            id: ''
            ),
          )
        )
      );
      if (newtask != null) {
        Provider.of<MyState>(context, listen: false).addTodo(newtask);
        }
       },
      ),
    );
  }
}

List<ToDo> _filterList(list, value) {
 if (value == 'all') return list;
    if (value == 'done') {
      return list.where((task) => task.isDone == true).toList(); } 
      if (value == 'undone') {
        return list.where((task) => task.isDone == false).toList(); }
    return list;
  }

