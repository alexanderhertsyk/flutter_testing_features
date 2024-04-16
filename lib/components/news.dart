import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news_model.dart';

Future<List<NewsModel>> getNews(String url) async {
  final Uri dataURL = Uri.parse(url);
  final http.Response response = await http.get(dataURL);
  List<NewsModel> news = List.empty();

  if (response.statusCode == 200) {
    var newsList = jsonDecode(response.body) as List;
    news = newsList.map((json) => NewsModel.fromJson(json)).toList();
  }
  print(news.length);
  return news;
}
