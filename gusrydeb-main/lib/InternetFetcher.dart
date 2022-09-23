import 'dart:html';
import 'dart:js';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'ToDoListView.dart';
import 'addtodoview.dart';
import 'main.dart';

import 'dart:convert';

class InternetFetcher {
  static Future<String> fetchIp() async {
    http.Response response = await http.get(Uri.parse('https://todoapp-api.apps.k8s.gu.se/'));
    var jsonData = response.body;
    var obj = jsonDecode(jsonData);
    return obj['ip'];
  }
}
