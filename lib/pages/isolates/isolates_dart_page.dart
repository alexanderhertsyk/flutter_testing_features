import 'package:flutter/material.dart';

import '../../components/isolated_worker.dart';

class IsolatesDartPage extends StatefulWidget {
  const IsolatesDartPage({super.key});

  static const route = '/isolates_dart';

  @override
  State<IsolatesDartPage> createState() => _IsolatesDartPageState();
}

class _IsolatesDartPageState extends State<IsolatesDartPage> {
  @override
  void initState() {
    super.initState();

    loadNews();
  }

  Future<void> loadNews() async {
    final worker = WorkerWithIsolates();
    await worker.spawn();
    await worker.parseJson('{"key":"value"}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(IsolatesDartPage.route),
      ),
    );
  }
}
