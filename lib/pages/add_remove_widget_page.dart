import 'package:flutter/material.dart';

import '../widgets/add_remove_widget.dart';

class AddRemoveWidgetPage extends StatefulWidget {
  const AddRemoveWidgetPage({super.key});

  @override
  State<AddRemoveWidgetPage> createState() => _AddRemoveWidgetPageState();
}

class _AddRemoveWidgetPageState extends State<AddRemoveWidgetPage> {
  bool _hasSecondWidget = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
