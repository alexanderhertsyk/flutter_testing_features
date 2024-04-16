import 'dart:isolate';

import 'package:flutter/material.dart';

import '../../components/news.dart';
import '../../models/news_model.dart';

class IsolatesFlutterPage extends StatefulWidget {
  const IsolatesFlutterPage({super.key});

  static const route = '/isolates_flutter';

  @override
  State<IsolatesFlutterPage> createState() => _IsolatesFlutterPageState();
}

class _IsolatesFlutterPageState extends State<IsolatesFlutterPage> {
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
    setState(() => this.news = news);
  }

  static Future<void> dataLoader(SendPort initialSender) async {
    final isolatedPort = ReceivePort();
    initialSender.send(isolatedPort.sendPort);

    await for (final dynamic msg in isolatedPort) {
      final mainSender = msg[1] as SendPort;
      final url = msg[0] as String;
      var news = await getNews(url);

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
        title: const Text(IsolatesFlutterPage.route),
      ),
      body: getBody(),
    );
  }
}
