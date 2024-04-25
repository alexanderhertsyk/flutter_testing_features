import 'package:flutter/material.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  static const String route = '/game';

  @override
  State<GamePage> createState() => _GamePageState();
}

enum CZ { empty, zero, cross }

class _GamePageState extends State<GamePage> {
  static const int length = 3;

  final List<List<CZ>> values = List.generate(
      length, (_) => List.generate(length, (_) => CZ.empty),
      growable: false);
  bool isCross = false;

  bool checkResult() {
    return true;
  }

  void resetOldValues() {}

  void onTap(int i, int j) {
    setState(() {
      values[i][j] = isCross ? CZ.cross : CZ.zero;
    });

    isCross = !isCross;
  }

  IconData? getValue(CZ value) {
    return switch (value) {
      CZ.empty => null,
      CZ.zero => Icons.circle_outlined,
      CZ.cross => Icons.close
    };
  }

  Widget getField(int i, int j) {
    return GestureDetector(
      onTap: () => onTap(i, j),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black54,
            width: 0.3,
          ),
        ),
        child: Icon(getValue(values[i][j])),
      ),
    );
  }

  List<Widget> getFields() {
    List<Widget> fields = [];

    for (int i = 0; i < length; i++) {
      for (int j = 0; j < length; j++) {
        fields.add(getField(i, j));
      }
    }

    return fields;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(GamePage.route),
      ),
      body: Center(
        child: GridView.count(
          crossAxisCount: 3,
          children: getFields(),
        ),
      ),
    );
  }
}
