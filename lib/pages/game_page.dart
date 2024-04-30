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

  final List<List<List<int>>> winLines = List.generate(size, (i) => []);
  late List<Sign?> signs;
  int move = 0;
  bool gameOver = false;

  List<Sign?> get initSigns =>
      List.generate(size, (_) => null, growable: false);

  @override
  void initState() {
    super.initState();

    setupWinLines();
    signs = initSigns;
  }

  void setupWinLines() {
    List<List<int>> checkLines = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (int i = 0; i < size; i++) {
      for (int j = 0; j < checkLines.length; j++) {
        if (checkLines[j].contains(i)) {
          winLines[i].add(checkLines[j]);
        }
      }
    }
  }

  void reset() {
    move = 0;
    setState(() => signs = initSigns);
    gameOver = false;
  }

  List<int>? checkWin(int i, bool? isCross) {
    for (var line in winLines[i]) {
      if (line.every((x) => signs[x]?.isCross == isCross)) {
        return line;
      }
    }

    return null;
  }

  void onTap(int i) {
    if (gameOver || signs[i] != null) return;

    move++;
    bool isCross = move % 2 == 1;
    setState(() => signs[i] = Sign(isCross: isCross, order: 0));

    var winLine = checkWin(i, isCross);

    if (winLine != null) {
      gameOver = true;
      highlightWinLine(winLine);
    }
  }

  void highlightWinLine(List<int> winLine) {
    for (var i in winLine) {
      setState(() => signs[i] = Sign.win(signs[i]!));
    }
  }

  IconData? getIcon(Sign? sign) {
    if (sign == null) return null;

    return sign.isCross ? Icons.close : Icons.circle_outlined;
  }

  Color? getColor(Sign? sign) {
    if (sign == null) return null;

    return sign.isWin ? Colors.green : Colors.black;
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
        child: Icon(
          getIcon(signs[i]),
          color: getColor(signs[i]),
          size: 100,
        ),
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
