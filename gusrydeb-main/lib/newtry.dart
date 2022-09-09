import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'TIG169 TODO';
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(appTitle),
          actions: [
            IconButton(
              icon: Icon(
                Icons.keyboard_arrow_left_outlined,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => secondView()));
              },
            )
          ],
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 28),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'What are you going to do?',
              ),
            )),
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: Container(
              child: Center(
                child: Text(
                  "+ ADD",
                  style: TextStyle(color: Colors.black, fontSize: 22),
                ),
              ),
            )),
      ],
    );
  }
}

class secondView extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _list(),
    );
  }

  Widget _list() {
    return ListView(
      children: [
        _item("Write a book"),
        _item("Do homework"),
        _item("Tidy room"),
        _item("Watch TV"),
        _item("Nap"),
        _item("Shop groceries"),
        _item("Have fun"),
        _item("Meditate"),
      ],
    );
  }

  Widget _item(text) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(text, style: TextStyle(fontSize: 36)),
    );
  }
}
