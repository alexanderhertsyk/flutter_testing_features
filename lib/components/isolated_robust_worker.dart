import 'dart:async';
import 'dart:isolate';

import 'news.dart' as news_maker;

class WorkerWithRobustIsolates {
  static const _kShutdown = 'shutdown';

  final SendPort _commands;
  final ReceivePort _responses;
  final Map<int, Completer<Object?>> _activeRequests = {};
  int _idCounter = 0;
  bool _closed = false;

  WorkerWithRobustIsolates._(this._responses, this._commands) {
    _responses.listen(_handleResponse);
  }

  static Future<WorkerWithRobustIsolates> spawn() async {
    final initPort = RawReceivePort();
    final connection = Completer<(ReceivePort, SendPort)>.sync();
    initPort.handler = (initialMessage) {
      final commandPort = initialMessage as SendPort;
      connection.complete((
        ReceivePort.fromRawReceivePort(initPort),
        commandPort,
      ));
    };

    try {
      await Isolate.spawn(_startIsolate, (initPort.sendPort));
    } on Object {
      initPort.close();
      rethrow;
    }

    final (ReceivePort receivePort, SendPort sendPort) =
        await connection.future;

    return WorkerWithRobustIsolates._(receivePort, sendPort);
  }

  Future<T> getNews<T>(String url) async {
    if (_closed) throw StateError('Closed');

    final completer = Completer<T>.sync();
    final id = _idCounter++;
    _activeRequests[id] = completer;
    _commands.send((id, url));

    return await completer.future;
  }

  void _handleResponse(dynamic message) {
    final (int id, Object? response) = message as (int, Object?);
    final completer = _activeRequests.remove(id)!;

    if (response is RemoteError) {
      completer.completeError(response);
    } else {
      completer.complete(response);
    }

    if (_closed && _activeRequests.isEmpty) _responses.close();
  }

  static void _startIsolate(SendPort sendPort) {
    final receivePort = ReceivePort();
    sendPort.send(receivePort.sendPort);
    _executeCommand(receivePort, sendPort);
  }

  static void _executeCommand(
    ReceivePort receivePort,
    SendPort sendPort,
  ) {
    receivePort.listen((message) async {
      if (message == _kShutdown) {
        receivePort.close();

        return;
      }

      final (int id, String url) = message as (int, String);

      try {
        var news = await news_maker.getNews(url);
        sendPort.send((id, news));
      } catch (e) {
        sendPort.send((id, RemoteError(e.toString(), '')));
      }
    });
  }

  void close() {
    if (!_closed) {
      _closed = true;
      _commands.send(_kShutdown);

      if (_activeRequests.isEmpty) _responses.close();
      print('--- port closed --- ');
    }
  }
}
