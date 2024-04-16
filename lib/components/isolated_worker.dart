import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:http/http.dart' as http;

import '../models/news_model.dart';

class WorkerWithIsolates {
  late SendPort _isolateSender;
  static late SendPort _mainSender;
  final _isolateReady = Completer<void>.sync();
  final _newsDownloaded = Completer<List<NewsModel>>.sync();

  Future<void> spawn() async {
    final mainReceiver = ReceivePort();
    mainReceiver.listen(_listenToIsolate);
    await Isolate.spawn(_runIsolate, mainReceiver.sendPort);
  }

  Future<List<NewsModel>> getNews(String url) async {
    await _isolateReady.future;
    _isolateSender.send(url);
    return await _newsDownloaded.future;
  }

  void _listenToIsolate(dynamic message) {
    if (message is SendPort) {
      _isolateSender = message;
      _isolateReady.complete();
    } else if (message is List<NewsModel>) {
      _newsDownloaded.complete(message);
    }
  }

  static void _runIsolate(SendPort mainSender) {
    _mainSender = mainSender;
    final isolateReceiver = ReceivePort();
    _mainSender.send(isolateReceiver.sendPort);
    isolateReceiver.listen(_listenToMain);
  }

  static void _listenToMain(dynamic message) {
    if (message is String) _downloadNews(message);
  }

  static void _downloadNews(String url) async {
    final Uri dataURL = Uri.parse(url);
    final http.Response response = await http.get(dataURL);
    List<NewsModel> news = List.empty();

    if (response.statusCode == 200) {
      var newsList = jsonDecode(response.body) as List;
      news = newsList.map((json) => NewsModel.fromJson(json)).toList();
    }

    _mainSender.send(news);
  }
}
