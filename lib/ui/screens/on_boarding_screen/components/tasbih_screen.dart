import 'package:flutter/material.dart';
import 'package:salah/ui/components/s_button.dart';

import '../../../../utils/image_utils.dart';

class TasbihScreen extends StatelessWidget {
  final VoidCallback onButtonClick;

  const TasbihScreen({
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
            // Logo Section
            Image.asset(
              ImageUtils.TASBIH_IMAGE,
              width: screenWidth * 0.75,
            ),

            const SizedBox(height: 44),

            // Text Section
            Text(
              'Enhance Your Spiritual Practice',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              'Also helps you incorporate tasbih and other daily Islamic rituals into your routine',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 44),

            SButton(text: 'Get Started', onButtonClick: onButtonClick),

            const SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}
