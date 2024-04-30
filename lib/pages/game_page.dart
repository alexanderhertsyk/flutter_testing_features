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
  static const int minMovesToWin = length + length - 1;
  static final List<Sign?> emptySigns =
      List.generate(size, (_) => null, growable: false);

  List<Sign?> signs = emptySigns;
  int move = 0;
  bool gameOver = false;
  final List<List<List<int>>> fieldWinLines = List.generate(size, (i) => []);

  @override
  void initState() {
    super.initState();

    setupWinLines();
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
          fieldWinLines[i].add(checkLines[j]);
        }
      }
    }
  }

  void makeMove(int i) {
    move++;
    bool isCrossTurn = move % 2 == 1;
    setState(() => signs[i] = Sign(isCross: isCrossTurn, fromMove: move));

    if (move >= minMovesToWin) checkWin(fieldIndex: i, turn: isCrossTurn);
  }

  void checkWin({required int fieldIndex, required bool? turn}) {
    for (var winLine in fieldWinLines[fieldIndex]) {
      if (winLine.every((x) => signs[x]?.isCross == turn)) {
        gameOver = true;
        highlightWinLine(winLine);

        return;
      }
    }
  }

  void reset() {
    move = 0;
    setState(() => signs = emptySigns);
    gameOver = false;
  }

  void highlightWinLine(List<int> winLineIndexes) {
    for (var i in winLineIndexes) {
      setState(() => signs[i] = Sign.win(signs[i]!));
    }
  }

  void onTap(int i) {
    var canMove = !gameOver && signs[i] == null;
    if (canMove) makeMove(i);
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
          itemBuilder: (context, i) => getField(i),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: reset,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
