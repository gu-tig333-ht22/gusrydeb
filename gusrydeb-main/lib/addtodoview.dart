import 'package:flutter/material.dart';

import 'Todolist.dart';

class AddToDoView extends StatefulWidget {
  final ToDo task;
  AddToDoView(this.task);

  @override
  State<StatefulWidget> createState() => AddToDoViewState(task);
  }

class AddToDoViewState extends State<AddToDoView> {
  String message = " ";

  TextEditingController textEditingController = TextEditingController();

  AddToDoViewState(ToDo task) {
    this.message = task.message;

    textEditingController = TextEditingController(text: task.message);

    textEditingController.addListener(() {
      setState(() {
        message = textEditingController.text;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TIG169 TODO"),
        centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(height: 24),
                Padding(padding: const EdgeInsets.all(20.0),
                  child: TextField(
                    controller: textEditingController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 5.0, color: Colors.black)
                          ),
                          hintText: 'What are you going to do?',
                      ),
                    ),
                  ),
                  Container(height: 24),
                  TextButton(
                    child: const Text("+ ADD",
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                    ),
                    onPressed: () {
                      Navigator.pop(context, ToDo(
                        message: message, 
                        id: ''
                        )
                      );
                    },
                  )
                ]
              )
          )
        );
      }
}

