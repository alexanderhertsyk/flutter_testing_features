import 'dart:convert';
import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/news_model.dart';

class IsolatesPage extends StatefulWidget {
  const IsolatesPage({super.key});

  static const route = '/isolates';

  @override
  State<IsolatesPage> createState() => _IsolatesPageState();
}

class _IsolatesPageState extends State<IsolatesPage> {
  List<NewsModel> data = <NewsModel>[];
  bool get isLoading => data.isEmpty;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    final receivePort = ReceivePort();
    await Isolate.spawn(dataLoader, receivePort.sendPort);

    // The 'echo' isolate sends its SendPort as the first message
    final sendPort = await receivePort.first as SendPort;
    final msg = await sendReceive(
      sendPort,
      'https://jsonplaceholder.typicode.com/posts',
    );
    setState(() {
      data = msg;
    });
  }

// The entry point for the isolate
  static Future<void> dataLoader(SendPort sendPort) async {
    // Open the ReceivePort for incoming messages.
    final port = ReceivePort();
    // Notify any other isolates what port this isolate listens to.
    sendPort.send(port.sendPort);
    await for (final dynamic msg in port) {
      final url = msg[0] as String;
      final replyTo = msg[1] as SendPort;

      final Uri dataURL = Uri.parse(url);
      final http.Response response = await http.get(dataURL);
      // Lots of JSON to parse
      // replyTo.send(jsonDecode(response.body) as List<Map<String, dynamic>>);
      List<NewsModel> news = List.empty();

      if (response.statusCode == 200) {
        var newsList = jsonDecode(response.body) as List;
        news = newsList.map((json) => NewsModel.fromJson(json)).toList();
      }

      replyTo.send(news);
    }
  }

  Future<List<NewsModel>> sendReceive(SendPort port, String msg) async {
    final ReceivePort response = ReceivePort();
    port.send(<dynamic>[msg, response.sendPort]);

    var a = await response.first;
    return a as List<NewsModel>;
  }

  Widget getBody() => isLoading ? getLoadingIndicator() : getListView();

  Widget getLoadingIndicator() =>
      const Center(child: CircularProgressIndicator());

  Widget getListView() {
    return ListView.builder(
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('Row ${data[i].title}'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(IsolatesPage.route),
      ),
      body: getBody(),
    );
  }
}
