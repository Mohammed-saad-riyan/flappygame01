import 'package:flutter/material.dart';

class FindsOneWidget extends StatelessWidget {
  const FindsOneWidget({
    super.key,
    required this.child,
    this.semanticsLabel,
  });

  final Widget child;
  final String? semanticsLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: child,
    );
  }
}