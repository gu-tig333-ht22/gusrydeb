import 'dart:html';
import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  var state = MyState();

  runApp(
    ChangeNotifierProvider(
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
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TodoListView(),
    );
  }
}

class TodoListView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TIG169 TODO"),
        centerTitle: true,
      ),
      body: Consumer<MyState>(
        builder: (context, state, child) => Todolist(state.list),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async {
          var newCard = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddToDoView(ToDo(
                        message: "",
                      ))));
          if (newCard != null) {
            Provider.of<MyState>(context, listen: false).addCard(newCard);
          }
        },
      ),
    );
  }
}

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

class AddToDoView extends StatefulWidget {
  final ToDo card;

  AddToDoView(this.card);

  @override
  State<StatefulWidget> createState() {
    return AddToDoViewState(card);
  }
}

class ToDoWidget extends StatelessWidget {
  final ToDo card;

  ToDoWidget(this.card);

  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0), child: Text(card.message));
  }
}

class AddToDoViewState extends State<AddToDoView> {
  String message = " ";

  TextEditingController textEditingController = TextEditingController();
  

  AddToDoViewState(ToDo card) {
    this.message = card.message;

    textEditingController = TextEditingController(text: card.message);

    textEditingController.addListener(() {
      setState(() {
        message = textEditingController.text;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("TIG169 TODO"), 
        centerTitle: true, 
        ),
        body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(height: 24),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: 
              TextField(
                controller: textEditingController,
                decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(width: 5.0, color: Colors.black)), 
                  hintText: 'What are you going to do?'),
                ), 
                ),
            Container(height: 24),
            TextButton(
            child: Text("ADD +", style: TextStyle(color: Colors.black, fontWeight: FontWeight. bold)),
            onPressed: () {
              Navigator.pop(context, ToDo(message: message));
            },
          )
          ]
        )
        )
            );
  }
}
