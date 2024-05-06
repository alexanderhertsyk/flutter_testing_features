import 'dart:math';

import 'package:flutter/material.dart';

import '../components/settings.dart';
import '../models/sign.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  static const String route = '/game';

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final Settings settings = Settings();
  late int rowCount = settings.rowCount;
  late int columnCount = settings.columnCount;
  late int size = rowCount * columnCount;
  late int winCount = settings.winCount;
  late int minWinMoves = Settings.kDefaultPlayers * winCount - 1;
  late int maxSignsOnBoard = Settings.kDefaultPlayers * winCount;

  final List<List<List<int>>> fieldWinLines = [];
  int move = 0;
  bool gameOver = false;
  late List<Sign?> signs;

  @override
  void initState() {
    super.initState();

    initWinLines();
    reset();
  }

  List<List<int>> generateWinLines() {
    List<List<int>> winLines = [];
    var l = List.generate(winCount, (i) => i);
    // generate win rows
    if (winCount <= columnCount) {
      for (int k = 0; k < rowCount; k++) {
        for (int i = 0; i <= columnCount - winCount; i++) {
          winLines.add(l.map((j) => k * columnCount + i + j).toList());
        }
      }
    }
    // generate win columns
    if (winCount <= rowCount) {
      for (int k = 0; k < columnCount; k++) {
        for (int i = 0; i <= rowCount - winCount; i++) {
          winLines.add(l.map((j) => k + (i + j) * columnCount).toList());
        }
      }
    }
    // generate win diagonals
    if (winCount <= min(rowCount, columnCount)) {
      for (int r = 0; r <= rowCount - winCount; r++) {
        var shift = r * columnCount;

        for (int i = 0; i <= columnCount - winCount; i++) {
          winLines
              .add(l.map((j) => shift + i + j * (columnCount + 1)).toList());
          winLines.add(l
              .map((j) => shift + (columnCount - i - 1) + j * (columnCount - 1))
              .toList());
        }
      }
    }

    return winLines;
  }

  void initWinLines() {
    var winLines = generateWinLines();

    for (int i = 0; i < size; i++) {
      fieldWinLines.add([]);

      for (int j = 0; j < winLines.length; j++) {
        if (winLines[j].contains(i)) {
          fieldWinLines[i].add(winLines[j]);
        }
      }
    }
  }

  void makeMove(int i) {
    move++;
    bool isCrossTurn = move % 2 == 1;
    setState(() => signs[i] = Sign(isCross: isCrossTurn, move: move));

    if (move > maxSignsOnBoard) removeExtraSign();
    if (move >= minWinMoves) checkWin(fieldIndex: i, turn: isCrossTurn);
  }

  void removeExtraSign() {
    var extraSignIndex =
        signs.indexWhere((x) => x != null && move - x.move == maxSignsOnBoard);
    setState(() => signs[extraSignIndex] = null);
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
    setState(() => signs = List.generate(size, (_) => null, growable: false));
    gameOver = false;
  }

  void highlightWinLine(List<int> winLineIndexes) {
    var tempSigns = signs.toList();

    for (var i in winLineIndexes) {
      tempSigns[i] = Sign.win(tempSigns[i]!);
    }

    setState(() => signs = tempSigns);
  }

  void onFieldTap(int i) {
    var canMove = !gameOver && signs[i] == null;
    if (canMove) makeMove(i);
  }

  IconData? getIcon(Sign? sign) {
    if (sign == null) return null;

    return sign.isCross ? Icons.close : Icons.circle_outlined;
  }

  Color? getColor(Sign? sign) {
    if (sign == null) return null;

    return sign.isWin
        ? Colors.green
        : switch (sign.move - move) {
            -5 || -4 => Colors.black26,
            -3 || -2 => Colors.black54,
            _ => Colors.black
          };
  }

  Widget getField(int i) {
    return GestureDetector(
      onTap: () => onFieldTap(i),
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
          primary: false,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columnCount,
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
