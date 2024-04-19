import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:testing_features/components/app_locale.dart';

class LocalizationsPage extends StatefulWidget {
  const LocalizationsPage({super.key});

  static const route = '/localizations';

  @override
  State<LocalizationsPage> createState() => _LocalizationsPageState();
}

class _LocalizationsPageState extends State<LocalizationsPage> {
  final FlutterLocalization localization = FlutterLocalization.instance;
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(LocalizationsPage.route),
      ),
      body: Text(AppLocale.testText.getString(context)),
      floatingActionButton: IconButton(
        icon: const Icon(Icons.language),
        onPressed: () {
          var locale = localization.supportedLocales.elementAt(i++);
          localization.translate(locale.languageCode);

          if (i == localization.supportedLocales.length) i = 0;
        },
      ),
    );
  }
}
