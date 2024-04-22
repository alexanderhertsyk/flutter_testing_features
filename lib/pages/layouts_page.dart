import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LayoutsPage extends StatefulWidget {
  const LayoutsPage({super.key});

  static const route = '/layouts';

  @override
  State<LayoutsPage> createState() => _LayoutsPageState();
}

class _LayoutsPageState extends State<LayoutsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(LayoutsPage.route)),
      body: GridView.count(
        crossAxisCount: 2,
        children: List<Widget>.generate(
          10,
          (index) => Center(
            child: Text('Item $index'),
          ),
        ),
      ),
    );
  }
}
