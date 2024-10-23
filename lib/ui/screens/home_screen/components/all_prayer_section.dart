import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salah/utils/prayer.dart';

class AllPrayerSection extends StatelessWidget {
  final List<Prayer> prayers;
  final List<DateTime> prayersTime;
  final Prayer currentPrayer;

  const AllPrayerSection({
    super.key,
    required this.prayers,
    required this.prayersTime,
    required this.currentPrayer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (int i = 0; i < 5; i++)
            Column(
              children: [
                Text(
                  prayers[i].name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: prayers[i] == currentPrayer
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      ),
                ),
                Text(
                  DateFormat('hh:mm a').format(prayersTime[i]),
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 14,
                        color: prayers[i] == currentPrayer
                            ? Theme.of(context).colorScheme.onSurface
                            : Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                      ),
                )
              ],
            )
        ],
      ),
    );
  }
}
