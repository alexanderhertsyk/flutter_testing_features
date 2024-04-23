import 'package:flutter/material.dart';

class GridViewPage extends StatefulWidget {
  const GridViewPage({super.key});

  static const route = '/gridview';

  @override
  State<GridViewPage> createState() => _GridViewPageState();
}

class _GridViewPageState extends State<GridViewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(GridViewPage.route)),
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
