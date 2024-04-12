import 'dart:convert';
import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:testing_features/models/news_model.dart';

class WebRequestPage extends StatefulWidget {
  const WebRequestPage({super.key});

  static const String route = '/web_request_page';

  @override
  State<WebRequestPage> createState() => _WebRequestPageState();
}

class _WebRequestPageState extends State<WebRequestPage> {
  static const int ok = 200;
  List<NewsModel> news = <NewsModel>[];

  Future<List<NewsModel>> getNews() async {
    var uri = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(uri);

    if (response.statusCode == ok) {
      var newsList = jsonDecode(response.body) as List;

      return newsList.map((json) => NewsModel.fromJson(json)).toList();
    }

    return List.empty();
  }

  void refreshNews() async {
    var news = await getNews();
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
