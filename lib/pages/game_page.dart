import 'dart:math';

import 'package:flutter/material.dart';

import '../models/sign.dart';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  static const String route = '/game';

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  static const int defaultWinCount = 3;
  static const int defaultRowCount = defaultWinCount;
  static const int defaultColumnCount = defaultWinCount;
  static const int size = defaultRowCount * defaultColumnCount;

  static const int minMovesToWin = defaultWinCount + defaultWinCount - 1;
  static const int maxSignsOnBoard = 2 * defaultWinCount;

  final List<List<List<int>>> fieldWinLines = List.generate(size, (i) => []);

  late List<Sign?> signs;
  late int move;
  late bool gameOver;

  @override
  void initState() {
    super.initState();

    setupWinLines();
    reset();
  }

  void generateAllWinLines(
      {int rowCount = defaultRowCount,
      int columnCount = defaultColumnCount,
      int winCount = defaultWinCount}) {
    if (columnCount < winCount) return; // TODO: add column's check

    var l = List.generate(winCount, (i) => i);
    List<List<int>> availableRows = [];

    if (winCount <= columnCount) {
      for (int r = 0; r < rowCount; r++) {
        for (int i = 0; i <= columnCount - winCount; i++) {
          availableRows.add(l.map((j) => r * columnCount + i + j).toList());
        }
      }
    }

    print1('Rows', availableRows);
    List<List<int>> availableColumns = [];

    if (winCount <= rowCount) {
      for (int c = 0; c < columnCount; c++) {
        for (int i = 0; i <= rowCount - winCount; i++) {
          availableColumns
              .add(l.map((j) => c + (i + j) * columnCount).toList());
        }
      }
    }

    print1('Columns', availableColumns);
    List<List<int>> availableDiagonals = [];

    if (winCount <= min(rowCount, columnCount)) {
      for (int r = 0; r <= rowCount - winCount; r++) {
        var shift = r * columnCount;

        for (int i = 0; i <= columnCount - winCount; i++) {
          availableDiagonals
              .add(l.map((j) => shift + i + j * (columnCount + 1)).toList());
          availableDiagonals.add(l
              .map((j) => shift + (columnCount - i - 1) + j * (columnCount - 1))
              .toList());
        }
      }
    }

    print1('Diagonals', availableDiagonals);
    print1(
        'Board',
        List.generate(rowCount,
            (i) => List.generate(columnCount, (j) => i * columnCount + j)));
  }

  void print1(String title, List<List<int>> lines) {
    print(title);
    for (var i in lines) {
      print(i.map((e) => '${e < 10 ? '0' : ''}$e').join(' '));
    }
  }

  void setupWinLines() {
    List<List<int>> allLines = [
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
      for (int j = 0; j < allLines.length; j++) {
        if (allLines[j].contains(i)) {
          fieldWinLines[i].add(allLines[j]);
        }
      }
    }
  }

  void makeMove(int i) {
    move++;
    bool isCrossTurn = move % 2 == 1;
    setState(() => signs[i] = Sign(isCross: isCrossTurn, move: move));

    if (move > maxSignsOnBoard) removeExtraSign();
    if (move >= minMovesToWin) checkWin(fieldIndex: i, turn: isCrossTurn);
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
    generateAllWinLines(rowCount: 3, columnCount: 3, winCount: 3);

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
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: defaultWinCount,
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
