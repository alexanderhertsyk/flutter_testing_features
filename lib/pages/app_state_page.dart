import 'package:flutter/material.dart';

class AppStatePage extends StatefulWidget {
  const AppStatePage({super.key});

  static const route = '/app_state';

  @override
  State<AppStatePage> createState() => _AppStatePageState();
}

class _AppStatePageState extends State<AppStatePage>
    with WidgetsBindingObserver {
  final List<AppLifecycleState> states = [];

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    if (WidgetsBinding.instance.lifecycleState != null) {
      states.add(WidgetsBinding.instance.lifecycleState!);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    setState(() => states.add(state));

    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStatePage.route),
      ),
      body: ListView.builder(
        itemCount: states.length,
        itemBuilder: (context, i) => ListTile(
          title: Text('$i state: ${states[i].name}'),
        ),
      ),
    );
  }
}
