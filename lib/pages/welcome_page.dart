import 'package:flutter/material.dart';
import 'package:testing_features/pages/add_remove_widget_page.dart';
import 'package:testing_features/widgets/nav_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            NavButton(route: AddRemoveWidgetPage.route),
          ],
        ),
      ),
    );
  }
}
