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
  List<NewsModel> news = <NewsModel>[];
  bool get isLoading => news.isEmpty;

  @override
  void initState() {
    super.initState();

    loadData();
  }

  Future<void> loadData() async {
    final initialReceiver = ReceivePort();
    await Isolate.spawn<SendPort>(dataLoader, initialReceiver.sendPort);
    var isolateSender = await initialReceiver.first as SendPort;
    var mainReceiver = ReceivePort();
    isolateSender.send(<dynamic>[
      'https://jsonplaceholder.typicode.com/posts',
      mainReceiver.sendPort,
    ]);
    var news = await mainReceiver.first as List<NewsModel>;
    print(news.length);
    setState(() => this.news = news);
  }

  static Future<void> dataLoader(SendPort initialSender) async {
    final isolatedPort = ReceivePort();
    initialSender.send(isolatedPort.sendPort);

    await for (final dynamic msg in isolatedPort) {
      final mainSender = msg[1] as SendPort;
      final url = msg[0] as String;
      final Uri dataURL = Uri.parse(url);
      final http.Response response = await http.get(dataURL);
      List<NewsModel> news = List.empty();

      print(response.statusCode);

      if (response.statusCode == 200) {
        var newsList = jsonDecode(response.body) as List;
        news = newsList.map((json) => NewsModel.fromJson(json)).toList();
      }

      mainSender.send(news);
    }
  }

  Widget getBody() => isLoading ? getLoadingIndicator() : getListView();

  Widget getLoadingIndicator() =>
      const Center(child: CircularProgressIndicator());

  Widget getListView() {
    return ListView.builder(
      itemBuilder: (context, i) => Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text('Row ${news[i].title}'),
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
