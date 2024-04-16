import 'package:flutter/material.dart';

import '../../widgets/nav_button.dart';
import 'isolates_dart_page.dart';
import 'isolates_flutter_page.dart';

class IsolatesPage extends StatelessWidget {
  const IsolatesPage({super.key});

  static const route = '/isolates';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(route),
      ),
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NavButton(route: IsolatesFlutterPage.route),
          NavButton(route: IsolatesDartPage.route),
        ],
      ),
    );
  }
}
