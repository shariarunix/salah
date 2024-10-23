import 'package:flutter/material.dart';

import '../../../../utils/location_utils.dart';

class HomeScreenHeader extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String suhurTime;
  final String iftarTime;
  final String nextPrayerRemainingTime;
  final String currentPrayer;
  final String weekDay;
  final String enDate;
  final String arabicDate;

  const HomeScreenHeader({
    super.key,
    required this.latitude,
    required this.longitude,
    required this.suhurTime,
    required this.iftarTime,
    required this.nextPrayerRemainingTime,
    required this.currentPrayer,
    required this.weekDay,
    required this.enDate,
    required this.arabicDate,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            // Left Section
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Current Prayer
                      Text(
                        currentPrayer,
                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                      ),

                      // Active Dot
                      Container(
                        margin: const EdgeInsets.only(left: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),

                  // Remaining Time For Next Prayer
                  Container(
                    margin: const EdgeInsets.only(top: 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 6),
                      child: Text(
                        nextPrayerRemainingTime,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                            ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Suhur
                  Text(
                    'Suhur : $suhurTime',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 20),
                  ),

                  const SizedBox(height: 8),

                  // Iftar
                  Text(
                    'Iftar : $iftarTime',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 20),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 16),

            // Right Section
            Expanded(
              flex: 1,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Day & Date
                  Wrap(
                    alignment: WrapAlignment.start,
                    children: [
                      Text(
                        weekDay,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '($enDate)',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),

                  // Hijri Date
                  Text(
                    arabicDate,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(fontSize: 20),
                  ),

                  const SizedBox(height: 8),

                  FutureBuilder(
                      future: LocationUtils.getAddressFromLatLng(latitude, longitude),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data!,
                            maxLines: 1,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(fontSize: 20),
                            overflow: TextOverflow.ellipsis,
                          );
                        }

                        return Text(
                          'Dhaka, Bangladesh',
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge
                              ?.copyWith(fontSize: 20),
                          overflow: TextOverflow.ellipsis,
                        );
                      }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
