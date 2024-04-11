import 'package:flutter/material.dart';
import 'package:testing_features/pages/add_remove_widget_page.dart';
import 'package:testing_features/pages/animation_page.dart';
import 'package:testing_features/widgets/nav_button.dart';

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
          ],
        ),
      ),
    );
  }
}
