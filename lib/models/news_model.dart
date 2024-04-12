import 'dart:core';

class NewsModel {
  static const String _kTitle = 'title';
  static const String _kBody = 'body';

  final String title;
  final String body;

  NewsModel({required this.title, required this.body});

  NewsModel.fromJson(Map<String, dynamic> json)
      : title = json[_kTitle],
        body = json[_kBody];

  Map<String, dynamic> toJson() => {
        _kTitle: title,
        _kBody: body,
      };
}
