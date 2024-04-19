import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';

class FlutterLocalizationDropdown extends StatefulWidget {
  const FlutterLocalizationDropdown({super.key});

  @override
  State<FlutterLocalizationDropdown> createState() =>
      _FlutterLocalizationDropdownState();
}

class _FlutterLocalizationDropdownState
    extends State<FlutterLocalizationDropdown> {
  final localization = FlutterLocalization.instance;

  void changeLocale(String languageCode) {
    setState(() {
      localization.translate(languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: localization.currentLocale!.languageCode,
      icon: const Icon(
        Icons.arrow_drop_down_circle,
        size: 20.0,
      ),
      onChanged: (languageCode) => changeLocale(languageCode!),
      items: localization.supportedLocales.map<DropdownMenuItem<String>>((l) {
        return DropdownMenuItem<String>(
          value: l.languageCode,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              l.languageCode,
              style: const TextStyle(
                fontSize: 25,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
