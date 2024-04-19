import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

import '../components/app_locale.dart';
import '../widgets/flutter_localization_dropdown.dart';

class LocalizationsPage extends StatelessWidget {
  const LocalizationsPage({super.key});

  static const route = '/localizations';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(route),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Flutter localization package:'),
            const FlutterLocalizationDropdown(),
            Text(AppLocale.testText.getString(context)),
          ],
        ),
      ),
    );
  }
}
