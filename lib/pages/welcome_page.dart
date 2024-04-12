import 'package:flutter/material.dart';

import '../widgets/nav_button.dart';
import 'add_remove_widget_page.dart';
import 'animation_page.dart';
import 'paint_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavButton(route: AddRemoveWidgetPage.route),
            NavButton(route: AnimationPage.route),
            NavButton(route: PaintPage.route),
          ],
        ),
      ),
    );
  }
}
