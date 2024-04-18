import 'dart:async';
import 'dart:isolate';

import '../models/news_model.dart';
import 'news.dart' as news_maker;

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
    var news = await news_maker.getNews(url);
    _mainSender.send(news);
  }
}
