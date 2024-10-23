import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salah/local_database/prefs_manager.dart';
import 'package:salah/models/hadith_model.dart';
import 'package:salah/services/prayer_time_api_service.dart';
import 'package:salah/ui/components/s_divider.dart';
import 'package:salah/ui/screens/home_screen/components/all_prayer_section.dart';
import 'package:salah/ui/screens/home_screen/components/daily_hadith_section.dart';
import 'package:salah/ui/screens/home_screen/components/features_row.dart';
import 'package:salah/ui/screens/home_screen/components/home_app_bar.dart';
import 'package:salah/ui/screens/home_screen/components/home_screen_header.dart';
import 'package:salah/ui/screens/home_screen/components/track_prayer_section.dart';
import 'package:salah/utils/constant.dart';
import 'package:salah/utils/prayer.dart';
import 'package:salah/utils/result_utils.dart';

import '../../../models/prayer_times_model.dart';
import '../../components/s_error_box.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _prefsManager = PrefsManager.instance;
  final _prayerTimeApiService = PrayerTimeApiService.instance;

  final hadithList = [
    demoHadit,
    demoHadit,
    demoHadit,
  ];

  String _getSuhurTime(PrayerTimesModel prayerTimesModel) {
    return DateFormat('hh:mm a').format(
        prayerTimesModel.timings.fajr.subtract(const Duration(minutes: 1)));
  }

  String _getIftarTime(PrayerTimesModel prayerTimesModel) {
    return DateFormat('hh:mm a').format(prayerTimesModel.timings.maghrib);
  }

  Prayer _getCurrentPrayer(PrayerTimesModel prayerTimesModel) {
    var timings = prayerTimesModel.timings;
    var currentTime = DateTime.now();

    if (currentTime == timings.fajr ||
        (currentTime.isAfter(timings.fajr) &&
            currentTime.isBefore(timings.dhuhr))) {
      return Prayer.Fajr;
    } else if (currentTime == timings.dhuhr ||
        (currentTime.isAfter(timings.dhuhr) &&
            currentTime.isBefore(timings.asr))) {
      return Prayer.Dhuhr;
    } else if (currentTime == timings.asr ||
        (currentTime.isAfter(timings.asr) &&
            currentTime.isBefore(timings.maghrib))) {
      return Prayer.Asr;
    } else if (currentTime == timings.maghrib ||
        (currentTime.isAfter(timings.maghrib) &&
            currentTime.isBefore(timings.isha))) {
      return Prayer.Maghrib;
    } else if (currentTime == timings.isha ||
        currentTime.isAfter(timings.isha)) {
      return Prayer.Isha;
    } else {
      return Prayer.Isha;
    }
  }

  String _nextPrayerRemainingTime(PrayerTimesModel prayerTimesModel) {
    var timings = prayerTimesModel.timings;
    var currentTime = DateTime.now();
    Prayer nextPrayer;
    Duration difference;

    switch (_getCurrentPrayer(prayerTimesModel)) {
      case Prayer.Fajr:
        difference = timings.dhuhr.difference(currentTime);
        nextPrayer = Prayer.Dhuhr;
        break;
      case Prayer.Dhuhr:
        difference = timings.asr.difference(currentTime);
        nextPrayer = Prayer.Asr;
        break;
      case Prayer.Asr:
        difference = timings.maghrib.difference(currentTime);
        nextPrayer = Prayer.Maghrib;
        break;
      case Prayer.Maghrib:
        difference = timings.isha.difference(currentTime);
        nextPrayer = Prayer.Isha;
        break;
      case Prayer.Isha:
        difference =
            timings.fajr.add(const Duration(days: 1)).difference(currentTime);
        nextPrayer = Prayer.Fajr;
        break;
    }

    return '${difference.inHours} hr ${difference.inMinutes % 60} min until ${nextPrayer.name}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,

      // App Bar Section
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: HomeAppBar(
          onActionPress: () {},
        ),
      ),

      // Body Section
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Future Builder For Top Section Where data needs from API
            FutureBuilder<Result>(
              future: _prayerTimeApiService.getPrayerTime(),
              builder: (context, snapshot) {
                // If ConnectionState is Waiting then show a Circular Progress Bar
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.all(32),
                      child: const CircularProgressIndicator(),
                    ),
                  );
                }

                // If Snapshot has data then it will execute
                if (snapshot.hasData) {
                  final result = snapshot.data!;

                  if (result is Success) {
                    PrayerTimesModel prayerTimes = result.result;

                    return Column(
                      children: [
                        // Header Section
                        HomeScreenHeader(
                          latitude: _prefsManager.getLatitude(),
                          longitude: _prefsManager.getLongitude(),
                          arabicDate: prayerTimes.arabicDate,
                          enDate: prayerTimes.englishDate,
                          weekDay: prayerTimes.englishWeekday,
                          suhurTime: _getSuhurTime(prayerTimes),
                          iftarTime: _getIftarTime(prayerTimes),
                          currentPrayer: _getCurrentPrayer(prayerTimes).name,
                          nextPrayerRemainingTime:
                              _nextPrayerRemainingTime(prayerTimes),
                        ),

                        // Divider
                        const SDivider(
                          margin: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 16,
                          ),
                        ),

                        // All Prayers Row
                        AllPrayerSection(
                          currentPrayer: _getCurrentPrayer(prayerTimes),
                          prayers: Prayer.values,
                          prayersTime: [
                            prayerTimes.timings.fajr,
                            prayerTimes.timings.dhuhr,
                            prayerTimes.timings.asr,
                            prayerTimes.timings.maghrib,
                            prayerTimes.timings.isha,
                          ],
                        ),

                        const SizedBox(height: 8),

                        // Prayer Tracker Section
                        TrackPrayerSection(
                          currentPrayer: _getCurrentPrayer(prayerTimes),
                          onCheckPress: (currentPrayer) {},
                          onCrossPress: (currentPrayer) {},
                        ),
                      ],
                    );
                  } else if (result is Failure) {
                    // If Result got some error it will show the message here.
                    return Padding(
                      padding: const EdgeInsets.all(16),
                      child: SErrorBox(
                        message: result.message,
                      ),
                    );
                  }
                }

                // If there is no data then it will show
                return const Padding(
                  padding: EdgeInsets.all(16),
                  child: SErrorBox(
                    message: Constant.TRY_AGAIN_MESSAGE,
                  ),
                );
              },
            ),

            // Features Row
            Padding(
              padding: const EdgeInsets.all(16),
              child: FeaturesRow(
                onPressed: (index) {
                  String? message;
                  switch (index) {
                    case 0:
                      message = "Al-Quran Screen";
                      break;
                    case 1:
                      message = "Hadith Screen";
                      break;
                    case 2:
                      message = "Dua Screen";
                      break;
                    case 3:
                      message = "Tasbih Screen";
                      break;
                    case 4:
                      message = "Qibla Screen";
                      break;
                  }

                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(message!),
                      margin: const EdgeInsets.all(16),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
              ),
            ),

            // Daily Hadith Section
            DailyHadithSection(hadithList: hadithList),

            // Space For Bottom Nav
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
