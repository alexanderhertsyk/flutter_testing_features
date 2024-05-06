import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:testing_features/components/settings.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  static const route = '/settings';

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final settings = Settings();
  double winCount = Settings.kDefaultWinCount.toDouble(),
      rowCount = Settings.kDefaultRowCount.toDouble(),
      columnCount = Settings.kDefaultColumnCount.toDouble();

  void onWinCountChanged(double winCount) {
    setState(() => this.winCount = winCount);
  }

  void onRowCountChanged(double rowCount) {
    setState(() => this.rowCount = rowCount);
  }

  void onColumnCountChanged(double columnCount) {
    setState(() => this.columnCount = columnCount);
  }

  void save(BuildContext context) {
    if (settings.save(
      winCount: winCount.toInt(),
      rowCount: rowCount.toInt(),
      columnCount: columnCount.toInt(),
    )) {
      Navigator.pop(context);
    } else {
      // TODO: handle error from the saving settings.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(SettingsPage.route),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Text('  ${winCount.toInt()} in row to win'),
              Expanded(
                child: Slider(
                  divisions: 2,
                  min: 3,
                  max: 5,
                  value: winCount,
                  onChanged: onWinCountChanged,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('  ${rowCount.toInt()} rows              '),
              Expanded(
                child: Slider(
                  divisions: 2,
                  min: 3,
                  max: 5,
                  value: rowCount,
                  onChanged: onRowCountChanged,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text('  ${columnCount.toInt()} columns       '),
              Expanded(
                child: Slider(
                  divisions: 2,
                  min: 3,
                  max: 5,
                  value: columnCount,
                  onChanged: onColumnCountChanged,
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.save),
        onPressed: () => save(context),
      ),
    );
  }
}
