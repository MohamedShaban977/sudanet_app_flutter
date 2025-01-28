import 'package:flutter/material.dart';

class UnFocusedKeyboard extends StatelessWidget {
  final Widget child;

  const UnFocusedKeyboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: child,
    );
  }
}
