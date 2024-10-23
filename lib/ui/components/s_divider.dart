import 'package:flutter/material.dart';

class SDivider extends StatelessWidget {
  final EdgeInsets? margin;

  const SDivider({super.key, this.margin});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      width: double.infinity,
      height: 0.5,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.25),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
