import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  const NavButton({super.key, required this.route});

  final String route;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(route),
    );
  }
}
