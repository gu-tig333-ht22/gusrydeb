
import 'dart:html';
import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'ToDoListView.dart';
import 'Todolist.dart';
import 'main.dart';

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
