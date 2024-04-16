import 'package:flutter/material.dart';

class IsolatesDartPage extends StatefulWidget {
  const IsolatesDartPage({super.key});

  static const route = '/isolates_dart';

  @override
  State<IsolatesDartPage> createState() => _IsolatesDartPageState();
}

class _IsolatesDartPageState extends State<IsolatesDartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(IsolatesDartPage.route),
      ),
    );
  }
}
