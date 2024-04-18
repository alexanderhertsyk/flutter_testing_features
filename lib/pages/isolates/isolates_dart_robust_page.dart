import 'package:flutter/material.dart';
import 'package:testing_features/components/isolated_robust_worker.dart';

import '../../models/news_model.dart';

class IsolatesDartRobustPage extends StatefulWidget {
  const IsolatesDartRobustPage({super.key});

  static const route = '/isolates_dart_robust';

  @override
  State<IsolatesDartRobustPage> createState() => _IsolatesDartRobustPageState();
}

class _IsolatesDartRobustPageState extends State<IsolatesDartRobustPage> {
  List<NewsModel> news = <NewsModel>[];
  bool get isLoading => news.isEmpty;

  @override
  void initState() {
    super.initState();

    loadNews();
  }

  Future<void> loadNews() async {
    // TODO: add exception handling
    final worker = await WorkerWithRobustIsolates.spawn();
    var news = await worker
        .getNews<List<NewsModel>>('https://jsonplaceholder.typicode.com/posts');
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
        title: const Text(IsolatesDartRobustPage.route),
      ),
      body: getBody(),
    );
  }
}
