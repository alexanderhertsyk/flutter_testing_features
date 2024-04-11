import 'package:flutter/material.dart';
import 'package:testing_features/add_remove_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _hasSecondWidget = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: AddRemoveWidget(hasSecondWidget: _hasSecondWidget),
          ),
        ),
        floatingActionButton: IconButton(
          color: Colors.red,
          onPressed: () => setState(() => _hasSecondWidget = !_hasSecondWidget),
          icon: const Icon(Icons.update),
        ),
      ),
    );
  }
}
