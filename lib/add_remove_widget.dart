import 'package:flutter/material.dart';

class AddRemoveWidget extends StatelessWidget {
  const AddRemoveWidget({super.key, required this.hasSecondWidget});

  final bool hasSecondWidget;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text('This is the first widget'),
        if (hasSecondWidget) const Text('This is the second widget'),
      ],
    );
  }
}
