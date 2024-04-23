import 'package:flutter/material.dart';

class ScrollviewPage extends StatefulWidget {
  const ScrollviewPage({super.key});

  static const route = '/scrollview';

  @override
  State<ScrollviewPage> createState() => _ScrollviewPageState();
}

class _ScrollviewPageState extends State<ScrollviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(ScrollviewPage.route)),
      body: SingleChildScrollView(
        child: Text(List.generate(300, (index) => 'I' 'm scroll! ').join()),
      ),
    );
  }
}
