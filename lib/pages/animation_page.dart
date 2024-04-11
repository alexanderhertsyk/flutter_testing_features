import 'package:flutter/material.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  static const String route = '/animation';

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  late final AnimationController controller;
  late final CurvedAnimation animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.bounceIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AnimationPage.route),
      ),
      body: SafeArea(
        child: Center(
          child: RotationTransition(
            turns: animation,
            child: const FlutterLogo(size: 200),
          ),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () =>
            controller.forward().then((value) => controller.reset()),
        icon: const Icon(Icons.play_arrow_sharp),
      ),
    );
  }

  @override
  void dispose() {
    animation.dispose();
    controller.dispose();

    super.dispose();
  }
}
