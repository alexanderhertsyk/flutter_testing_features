import 'package:flutter/material.dart';

import '../widgets/nav_button.dart';
import 'animation_page.dart';
import 'Isolates/isolates_page.dart';
import 'app_state_page.dart';
import 'game_page.dart';
import 'images_page.dart';
import 'layouts/layouts_page.dart';
import 'localization_page.dart';
import 'paint_page.dart';
import 'settings_page.dart';
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
            NavButton(route: AnimationPage.route),
            NavButton(route: PaintPage.route),
            NavButton(route: WebRequestPage.route),
            NavButton(route: IsolatesPage.route),
            NavButton(route: ImagesPage.route),
            NavButton(route: LocalizationsPage.route),
            NavButton(route: AppStatePage.route),
            NavButton(route: LayoutsPage.route),
            NavButton(route: GamePage.route),
            NavButton(route: SettingsPage.route),
          ],
        ),
      ),
    );
  }
}
