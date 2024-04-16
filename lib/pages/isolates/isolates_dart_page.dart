import 'package:flutter/material.dart';

import '../../components/isolated_worker.dart';
import '../../models/news_model.dart';

class IsolatesDartPage extends StatefulWidget {
  const IsolatesDartPage({super.key});

  static const route = '/isolates_dart';

  @override
  State<IsolatesDartPage> createState() => _IsolatesDartPageState();
}

class _IsolatesDartPageState extends State<IsolatesDartPage> {
  List<NewsModel> news = <NewsModel>[];
  bool get isLoading => news.isEmpty;

  @override
  void initState() {
    super.initState();

    loadNews();
  }

  Future<void> loadNews() async {
    final worker = WorkerWithIsolates();
    await worker.spawn();
    var news =
        await worker.getNews('https://jsonplaceholder.typicode.com/posts');
    setState(() => this.news = news);
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
        title: const Text(IsolatesDartPage.route),
      ),
      body: getBody(),
    );
  }
}
