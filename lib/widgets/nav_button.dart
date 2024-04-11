import 'package:flutter/material.dart';

class NavButton extends StatelessWidget {
  const NavButton({super.key, required this.route});

  final String route;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: 0.0,
          horizontal: 10.0,
        ),
      ),
      onPressed: () => Navigator.pushNamed(context, route),
      child: Text(route),
    );
  }
}
