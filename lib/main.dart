import 'package:flutter/material.dart';

import 'pages/images_page.dart';
import 'pages/isolates/isolates_dart_page.dart';
import 'pages/isolates/isolates_dart_robust_page.dart';
import 'pages/isolates/isolates_flutter_page.dart';
import 'pages/add_remove_widget_page.dart';
import 'pages/animation_page.dart';
import 'pages/Isolates/isolates_page.dart';
import 'pages/paint_page.dart';
import 'pages/web_request_page.dart';
import 'pages/welcome_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomePage.route,
      routes: {
        WelcomePage.route: (context) => const WelcomePage(),
        AddRemoveWidgetPage.route: (context) => const AddRemoveWidgetPage(),
        AnimationPage.route: (context) => const AnimationPage(),
        PaintPage.route: (context) => const PaintPage(),
        WebRequestPage.route: (context) => const WebRequestPage(),
        IsolatesPage.route: (context) => const IsolatesPage(),
        IsolatesFlutterPage.route: (context) => const IsolatesFlutterPage(),
        IsolatesDartPage.route: (context) => const IsolatesDartPage(),
        IsolatesDartRobustPage.route: (context) =>
            const IsolatesDartRobustPage(),
        ImagesPage.route: (context) => const ImagesPage(),
      },
    );
  }
}
