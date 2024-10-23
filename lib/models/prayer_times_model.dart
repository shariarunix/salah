import 'package:intl/intl.dart';

class PrayerTimesModel {
  final Timings timings;
  final String englishDate;
  final String englishWeekday;
  final String arabicDate;
  // final String? holiday;

  PrayerTimesModel({
    required this.timings,
    required this.englishDate,
    required this.englishWeekday,
    required this.arabicDate,
    // this.holiday,
  });

  factory PrayerTimesModel.fromJson(Map<String, dynamic> json) {
    return PrayerTimesModel(
      timings: Timings.fromJson(json['data']['timings']),
      englishDate: json['data']['date']['gregorian']['date'],
      englishWeekday: json['data']['date']['gregorian']['weekday']['en'],
      arabicDate: _formatArabicDate(json['data']['date']['hijri']),
      // holiday: json['data']['date']['hijri']['holidays'] ?? null,
    );
  }

  static String _formatArabicDate(Map<String, dynamic> hijriDate) {
    return '${hijriDate['month']['en']} ${hijriDate['day']}, ${hijriDate['year']} ${hijriDate['designation']['abbreviated']}';
  }
}

class Timings {
  final DateTime fajr;
  final DateTime dhuhr;
  final DateTime asr;
  final DateTime maghrib;
  final DateTime isha;

  Timings({
    required this.fajr,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.isha,
  });

  factory Timings.fromJson(Map<String, dynamic> timings) {
    return Timings(
      fajr: _convertToDateTime(timings['Fajr']),
      dhuhr: _convertToDateTime(timings['Dhuhr']),
      asr: _convertToDateTime(timings['Asr']),
      maghrib: _convertToDateTime(timings['Maghrib']),
      isha: _convertToDateTime(timings['Isha']),
    );
  }

  static DateTime _convertToDateTime(String time) {
    var date = DateTime.now();

    final List<String> timeParts = time.split(':');
    if (timeParts.length != 2) {
      throw FormatException('Invalid time format: $time');
    }

    return DateTime(date.year, date.month, date.day,  int.parse(timeParts[0]), int.parse(timeParts[1]));
  }
}
