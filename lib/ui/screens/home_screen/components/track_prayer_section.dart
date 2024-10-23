import 'package:flutter/material.dart';
import 'package:salah/utils/image_utils.dart';

import '../../../../utils/prayer.dart';

class TrackPrayerSection extends StatelessWidget {
  final Prayer currentPrayer;
  final void Function(Prayer prayer) onCrossPress;
  final void Function(Prayer prayer) onCheckPress;

  const TrackPrayerSection({
    super.key,
    required this.currentPrayer,
    required this.onCrossPress,
    required this.onCheckPress,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Container(
      margin: const EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage(ImageUtils.PRAYER_TRACKER_BG),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Did you pray',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.white),
            ),
            Text(
              currentPrayer.name,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Colors.white, fontWeight: FontWeight.w700),
            ),
            SizedBox(height: width * 0.4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Cancel Button
                IconButton(
                  onPressed: () => onCrossPress(currentPrayer),
                  padding: const EdgeInsets.all(12),
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  icon: const Icon(
                    Icons.close_rounded,
                    size: 24,
                    color: Colors.red,
                  ),
                ),

                IconButton(
                  onPressed: () => onCheckPress(currentPrayer),
                  padding: const EdgeInsets.all(12),
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(Colors.white),
                  ),
                  icon: const Icon(
                    Icons.check_rounded,
                    size: 24,
                    color: Colors.green,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
