import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:salah/utils/image_utils.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onButtonClick;

  const WelcomeScreen({
    super.key,
    required this.onButtonClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo Section
            SvgPicture.asset(
              ImageUtils.APP_LOGO_SVG,
              width: 88,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            Text(
              'S A L A H',
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 44),

            // Text Section
            Text(
              'Welcome to Salah Tracker App',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              'Track, Reflect and Elevate Your Spiritual Journey',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 44),

            IconButton(
              onPressed: onButtonClick,
              icon: const Icon(Icons.arrow_forward_ios_rounded),
              iconSize: 32,
              style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.onSurface),
                  foregroundColor: WidgetStatePropertyAll(Theme.of(context).colorScheme.surface),
                  padding: const WidgetStatePropertyAll(EdgeInsets.only(left: 20, top: 16, right: 16, bottom: 16)),
                  shape: const WidgetStatePropertyAll(CircleBorder())),
            ),

            const SizedBox(height: 44),
          ],
        ),
      ),
    );
  }
}
