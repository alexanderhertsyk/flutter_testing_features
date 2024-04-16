import 'package:flutter/material.dart';

import '../widgets/nav_button.dart';
import 'add_remove_widget_page.dart';
import 'animation_page.dart';
import 'Isolates/isolates_page.dart';
import 'paint_page.dart';
import 'web_request_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NavButton(route: AddRemoveWidgetPage.route),
            NavButton(route: AnimationPage.route),
            NavButton(route: PaintPage.route),
            NavButton(route: WebRequestPage.route),
            NavButton(route: IsolatesPage.route),
          ],
        ),
      ),
    );
  }
}
