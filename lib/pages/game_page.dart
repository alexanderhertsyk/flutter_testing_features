import 'package:flutter/material.dart';

import '../models/sign.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  static const String route = '/game';

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const int length = 3;
  static const int size = length * length;

  late List<Sign?> signs;
  int move = 0;

  List<Sign?> get initSigns =>
      List.generate(size, (_) => null, growable: false);

  @override
  void initState() {
    super.initState();

    signs = initSigns;
  }

  void reset() {
    move = 0;
    setState(() => signs = initSigns);
  }

  bool checkResult() {
    return true;
  }

  void resetOldValues() {}

  void onTap(int i) {
    if (signs[i] != null) return;

    move++;
    bool isCross = move % 2 != 0;

    setState(() => signs[i] = Sign(isCross: isCross, order: 0));
  }

  IconData? getIcon(Sign? sign) {
    if (sign == null) return null;

    return sign.isCross ? Icons.close : Icons.circle_outlined;
  }

  Widget getField(int i) {
    return GestureDetector(
      onTap: () => onTap(i),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black54,
            width: 0.5,
          ),
        ),
        child: Icon(getIcon(signs[i])),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(GamePage.route),
      ),
      body: Center(
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: length,
          ),
          itemCount: size,
          itemBuilder: (BuildContext context, int i) => getField(i),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: reset,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
