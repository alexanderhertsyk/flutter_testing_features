import 'package:flutter/material.dart';

class ImagesPage extends StatelessWidget {
  const ImagesPage({super.key});

  static const String route = '/images';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(ImagesPage.route),
      ),
      body: Center(
        child: Image.asset('images/raccoon.png'),
      ),
    );
  }
}
