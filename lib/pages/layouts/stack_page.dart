import 'package:flutter/material.dart';

class StackPage extends StatefulWidget {
  const StackPage({super.key});

  static const route = '/stack';

  @override
  State<StackPage> createState() => _StackPageState();
}

class _StackPageState extends State<StackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(StackPage.route)),
      body: const Stack(
        children: <Widget>[
          Icon(
            Icons.add_box,
            size: 50,
            color: Colors.green,
          ),
          Positioned(
            left: 15,
            child: Icon(
              Icons.add_circle,
              size: 50,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
