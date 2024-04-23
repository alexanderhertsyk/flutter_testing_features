import 'package:flutter/material.dart';

import '../../widgets/nav_button.dart';
import 'grid_page.dart';
import 'stack_page.dart';

class LayoutsPage extends StatelessWidget {
  const LayoutsPage({super.key});

  static const route = '/layouts';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(route)),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavButton(route: GridViewPage.route),
          NavButton(route: StackPage.route),
        ],
      ),
    );
  }
}
