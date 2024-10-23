import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:salah/models/prayer_times_model.dart';
import 'package:salah/services/auth_service.dart';
import 'package:salah/services/prayer_time_api_service.dart';
import 'package:salah/ui/components/s_button.dart';
import 'package:salah/ui/components/s_error_box.dart';
import 'package:salah/utils/constant.dart';

import '../../../utils/prayer.dart';
import '../../../utils/result_utils.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key, required this.onBackPressed});

  final VoidCallback onBackPressed;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _prayerTimeApi = PrayerTimeApiService.instance;

  DateTime _dateTime = DateTime.now();
  bool showDatePicker = true;
  var searchResponse = null;

  void _onSearch() {
    setState(() {
      showDatePicker = false;
    });
    searchResponse = _prayerTimeApi.searchPrayerTime(_dateTime);
  }

  DateTime _gatePrayerTime(Timings timings, Prayer prayer) {
    switch (prayer) {
      case Prayer.Fajr:
        return timings.fajr;
      case Prayer.Dhuhr:
        return timings.dhuhr;
      case Prayer.Asr:
        return timings.asr;
      case Prayer.Maghrib:
        return timings.maghrib;
      case Prayer.Isha:
        return timings.isha;
    }
  }

  List _getPrayerAndTimeList(Timings timings) {
    var timeList = [];
    for (var value in Prayer.values) {
      timeList.add({
        'prayerName': value.name,
        'prayerTime': DateFormat('hh:mm a').format(
            _gatePrayerTime(timings, value))
      });
    }
    return timeList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,

      // App Bar Section
      appBar: AppBar(
        leading: IconButton(
            onPressed: widget.onBackPressed,
            icon: const Icon(Icons.arrow_back_rounded)),
        title: const Text('Search Prayer Times'),
      ),

      // Body
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 0, right: 16, bottom: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showDatePicker = true;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: Theme
                              .of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.05),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(
                            DateFormat('dd MMM yyyy').format(_dateTime),
                            style:
                            Theme
                                .of(context)
                                .textTheme
                                .bodyLarge
                                ?.copyWith(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 1,
                    child: SButton(
                      text: 'Search',
                      onButtonClick: _onSearch,
                    ),
                  )
                ],
              ),

              // Date Picker Section
              if (showDatePicker) ...[
                const SizedBox(height: 16),
                Text(
                  "Select a Date",
                  style: Theme
                      .of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onSurface,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme
                        .of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.05),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4, right: 2),
                    child: CalendarDatePicker(
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2050),
                      onDateChanged: (dateTime) {
                        setState(() => _dateTime = dateTime);
                      },
                    ),
                  ),
                ),
              ],

              if(searchResponse != null) FutureBuilder(
                future: searchResponse, builder: (context, snapshot) {
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
                    Timings prayerTime = result.result;
                    return Column(
                      children: [
                        const SizedBox(height: 16),
                        for(var nameAndTime in _getPrayerAndTimeList(prayerTime)) ...[
                          Container(
                            width : double.infinity,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      nameAndTime['prayerName'], style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge,
                                      textAlign: TextAlign.start,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Text(
                                      nameAndTime['prayerTime'], style: Theme
                                        .of(context)
                                        .textTheme
                                        .titleLarge,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                        ],
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

                return const SErrorBox(message: Constant.TRY_AGAIN_MESSAGE);
              },),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
