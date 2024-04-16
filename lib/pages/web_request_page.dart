import 'dart:core';

import 'package:flutter/material.dart';

import '../components/news.dart';
import '../models/news_model.dart';

class WebRequestPage extends StatefulWidget {
  const WebRequestPage({super.key});

  static const String route = '/web_request';

  @override
  State<WebRequestPage> createState() => _WebRequestPageState();
}

class _WebRequestPageState extends State<WebRequestPage> {
  List<NewsModel> news = <NewsModel>[];

  void refreshNews() async {
    var news = await getNews('https://jsonplaceholder.typicode.com/posts');
    setState(() => this.news = news);
  }

  @override
  void initState() {
    super.initState();

    refreshNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(WebRequestPage.route),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: news.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NewsPage(news[i])),
            ),
            child: ListTile(
              title: Row(
                children: [
                  const Icon(Icons.info),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      news[i].body,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              subtitle: Text(news[i].title),
            ),
          );
        },
      ),
    );
  }
}

class NewsPage extends StatelessWidget {
  const NewsPage(this.news, {super.key});

  final NewsModel news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(news.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(news.body),
      ),
    );
  }
}
