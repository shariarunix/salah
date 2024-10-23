import 'package:flutter/material.dart';
import '../../../../utils/image_utils.dart';

class PrayerScreen extends StatelessWidget {
  final VoidCallback onButtonClick;

  const PrayerScreen({
    super.key,
    required this.onButtonClick,
  });

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Assalamu Alaikum',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 22),

            // Logo Section
            Image.asset(
              ImageUtils.PRAYING_IMAGE,
              width: screenWidth * 0.75,
            ),

            const SizedBox(height: 44),

            // Text Section
            Text(
              'Track Your Prayers with Ease',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              'To provide you with accurate prayer times and timely reminders, please allow the app to access your location and notification',
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
                shape: const WidgetStatePropertyAll(CircleBorder()),
              ),
            ),

            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}
