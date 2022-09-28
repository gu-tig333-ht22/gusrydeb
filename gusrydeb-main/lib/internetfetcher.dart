import 'dart:html';
import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'ToDoListView.dart';
import 'addtodoview.dart';
import 'main.dart';
import 'Todolist.dart';

import 'dart:convert';

class InternetFetcher {
  static Future<List<ToDo>> addTodo(ToDo card) async {
    Map<String, dynamic> obj = ToDo.toJson(card);
    var jsonString = jsonEncode(obj);
    var response = await http.post(
      Uri.parse(
          'https://todoapp-api.apps.k8s.gu.se/todos?key=06685d64-6849-4b12-a26a-1bb9a0544f63'),
      body: jsonString,
      headers: {'Content-Type': 'application/json'},
    );
    jsonString = response.body;
    var list = jsonDecode(jsonString);
    return list.map<ToDo>((data) {
      return ToDo.fromJson(data);
    }).toList();
  }

  static Future<List<ToDo>> fetchingToDos() async {
    http.Response response = await http.get(Uri.parse(
        "https://todoapp-api.apps.k8s.gu.se/todos?key=06685d64-6849-4b12-a26a-1bb9a0544f63"));
    var jsonData = response.body;
    var obj = jsonDecode(jsonData);
    return obj.map<ToDo>((data) {
      return ToDo.fromJson(data);
    }).toList();
  }

  static Future updateToDo(String todoId, ToDo card) async {
    Map<String, dynamic> obj = ToDo.toJson(card);
    var jsonString = jsonEncode(obj);
    var response = await http.put(
      Uri.parse(
          "https://todoapp-api.apps.k8s.gu.se/todos/$todoId?key=06685d64-6849-4b12-a26a-1bb9a0544f63"),
      body: jsonString,
      headers: {'Content-Type': 'application/json'},
    );
    jsonString = response.body;
    var list = jsonDecode(jsonString);
    return list.map<ToDo>((data) {
      return ToDo.fromJson(data);
    }).toList();
  }
    static Future DeletingToDo(String todoId) async {
    var response = await http.delete(Uri.parse(
        "https://todoapp-api.apps.k8s.gu.se/todos/$todoId?key=06685d64-6849-4b12-a26a-1bb9a0544f63"));
    var jsonString = response.body;
    var list = jsonDecode(jsonString);
    return list.map<ToDo>((data) {
      return ToDo.fromJson(data);
    }).toList();
  }


}
