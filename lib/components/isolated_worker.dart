import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

class WorkerWithIsolates {
  late SendPort _isolateSender;
  final Completer<void> _isolateReady = Completer.sync();

  Future<void> spawn() async {
    final mainReceiver = ReceivePort();
    mainReceiver.listen(_listenToIsolate);
    await Isolate.spawn(_runIsolate, mainReceiver.sendPort);
  }

  void _listenToIsolate(dynamic message) {
    if (message is SendPort) {
      _isolateSender = message;
      _isolateReady.complete();
    } else if (message is Map<String, dynamic>) {
      print(message);
    }
  }

  static void _runIsolate(SendPort mainSender) {
    final isolateReceiver = ReceivePort();
    mainSender.send(isolateReceiver.sendPort);
    isolateReceiver.listen((dynamic message) async {
      if (message is String) {
        final transformed = jsonDecode(message);
        mainSender.send(transformed);
      }
    });
  }

  Future<void> parseJson(String message) async {
    await _isolateReady.future;
    _isolateSender.send(message);
  }
}
