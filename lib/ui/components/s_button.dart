import 'package:flutter/material.dart';

class SButton extends StatelessWidget {
  final String text;
  final VoidCallback onButtonClick;
  final double? width;
  final bool? isLoading;

  const SButton({super.key, required this.text, required this.onButtonClick, this.width, this.isLoading});

  @override
  Widget build(BuildContext context) {

    return ElevatedButton(
      onPressed: onButtonClick,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onSurface),
        foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
        padding: const WidgetStatePropertyAll(EdgeInsets.all(16)),
        minimumSize: WidgetStatePropertyAll(Size(width == null ? double.infinity : width!, 60)),
        elevation: const WidgetStatePropertyAll(0),
      ),
      child: isLoading == true ? CircularProgressIndicator(
        backgroundColor: Theme.of(context).colorScheme.surface.withOpacity(0.3),
        color: Theme.of(context).colorScheme.surface,
      ) :Text(
        text,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontSize: 18,
          color: Theme.of(context).colorScheme.surface,
        ),
      ),
    );
  }
}
