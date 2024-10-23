import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:salah/local_database/prefs_manager.dart';
import 'package:salah/models/prayer_times_model.dart';
import 'package:salah/utils/constant.dart';
import 'package:salah/utils/result_utils.dart';
import 'package:http/http.dart' as http;

class PrayerTimeApiService {
  PrayerTimeApiService._();

  static final PrayerTimeApiService _instance = PrayerTimeApiService._();

  static PrayerTimeApiService get instance => _instance;

  // Prefs Manager
  final PrefsManager prefsManager = PrefsManager.instance;

  Future<Result> searchPrayerTime(DateTime dateTime) async {
    try {
      final apiResponse = await http.get(Uri.parse(constructApi(dateTime))).timeout(const Duration(seconds: 10));

      if (apiResponse.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(apiResponse.body);
        return Success(Timings.fromJson(jsonResponse['data']['timings']));

      } else if (apiResponse.statusCode == 404) {
        return Failure('Error 404: Not Found. The requested resource was not found');

      } else {
        return Failure(Constant.TRY_AGAIN_MESSAGE);

      }
    } on SocketException {
      return Failure('No internet connection. Please check your internet');

    } on TimeoutException {
      return Failure('The request has timed out. Please try again later');

    } catch (e) {
      return Failure(Constant.TRY_AGAIN_MESSAGE + e.toString());

    }
  }

  Future<Result> getPrayerTime() async {
    try {
      final apiResponse = await http.get(Uri.parse(constructApi(DateTime.now()))).timeout(const Duration(seconds: 10));

      if (apiResponse.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = json.decode(apiResponse.body);
        return Success(PrayerTimesModel.fromJson(jsonResponse));

      } else if (apiResponse.statusCode == 404) {
        return Failure('Error 404: Not Found. The requested resource was not found');

      } else {
        return Failure(Constant.TRY_AGAIN_MESSAGE);

      }
    } on SocketException {
      return Failure('No internet connection. Please check your internet');

    } on TimeoutException {
      return Failure('The request has timed out. Please try again later');

    } catch (e) {
      return Failure(Constant.TRY_AGAIN_MESSAGE + e.toString());

    }
  }

  String constructApi(DateTime dateTime) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

    // If Latitude from PrefsManager is null then Constant.DEFAULT_LATITUDE will
    double latitude = prefsManager.getLatitude();
    double longitude = prefsManager.getLongitude();

    int calculationMethod = prefsManager.getCalculationMethod();

    return "${Constant.API_URL}/$formattedDate?latitude=$latitude&longitude=$longitude&method=$calculationMethod&iso8601=false";
  }
}
