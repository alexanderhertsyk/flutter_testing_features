import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import 'components/app_locale.dart';
import 'pages/app_state_page.dart';
import 'pages/images_page.dart';
import 'pages/isolates/isolates_dart_page.dart';
import 'pages/isolates/isolates_dart_robust_page.dart';
import 'pages/isolates/isolates_flutter_page.dart';
import 'pages/add_remove_widget_page.dart';
import 'pages/animation_page.dart';
import 'pages/Isolates/isolates_page.dart';
import 'pages/layouts/grid_page.dart';
import 'pages/layouts/layouts_page.dart';
import 'pages/layouts/stack_page.dart';
import 'pages/localization_page.dart';
import 'pages/paint_page.dart';
import 'pages/web_request_page.dart';
import 'pages/welcome_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FlutterLocalization localization = FlutterLocalization.instance;

  @override
  void initState() {
    super.initState();

    initLocalizations();
  }

  void initLocalizations() {
    localization.init(
      mapLocales: [
        // TODO: replace w/ named enum
        const MapLocale('en', AppLocale.en),
        const MapLocale('ru', AppLocale.ru),
        const MapLocale('by', AppLocale.by),
        const MapLocale('fr', AppLocale.fr),
        const MapLocale('de', AppLocale.de),
        const MapLocale('it', AppLocale.it),
        const MapLocale('sp', AppLocale.sp),
        const MapLocale('pt', AppLocale.pt),
        const MapLocale('zh', AppLocale.zh),
        const MapLocale('jp', AppLocale.jp),
        const MapLocale('hi', AppLocale.hi),
      ],
      initLanguageCode: 'en',
    );
    localization.onTranslatedLanguage = (_) => setState(() {});
  }

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
        LocalizationsPage.route: (context) => const LocalizationsPage(),
        AppStatePage.route: (context) => const AppStatePage(),
        LayoutsPage.route: (context) => const LayoutsPage(),
        GridViewPage.route: (context) => const GridViewPage(),
        StackPage.route: (context) => const StackPage(),
      },
      supportedLocales: localization.supportedLocales,
      localizationsDelegates: localization.localizationsDelegates,
    );
  }
}
