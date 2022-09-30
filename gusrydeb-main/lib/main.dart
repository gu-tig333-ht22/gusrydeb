import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ToDoListView.dart';
import 'Todolist.dart';

void main() {
  var state = MyState();
  state.getTodo();
  runApp(ChangeNotifierProvider(
      create: (context) => state,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "TIG169 TODO",
      theme: ThemeData( 
        primarySwatch: Colors.grey,
        unselectedWidgetColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.grey,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: TodoListView(),
    );
  }
}
