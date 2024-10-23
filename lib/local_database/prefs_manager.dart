import 'package:salah/utils/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsManager {
  PrefsManager._();

  static PrefsManager? _instance;
  static SharedPreferences? _prefs;

  static PrefsManager get instance {
    _instance ??= PrefsManager._();
    return _instance!;
  }


  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }


  // Latitude & Longitude Section
  Future<void> saveLatLong({
    required double latitude,
    required double longitude,
  }) async {
    await _prefs?.setDouble('latitude', latitude);
  }

  double getLatitude() {
    return _prefs?.getDouble('latitude') ?? Constant.DEFAULT_LATITUDE;
  }

  double getLongitude() {
    return _prefs?.getDouble('longitude') ?? Constant.DEFAULT_LONGITUDE;
  }

  Future<void> clearLocation() async {
    await _prefs?.remove('latitude');
    await _prefs?.remove('longitude');
  }

  // User Status Section
  Future<void> saveIsUserNew(bool value) async {
    await _prefs?.setBool('isUserNew', value);
  }

  Future<bool> getIsUserNew() async {
    if (_prefs?.containsKey('isUserNew') == false) {
      await saveIsUserNew(true);
      return true;
    }
    return _prefs?.getBool('isUserNew') ?? false;
  }
  
  // Prayer Time Calculation Method
  Future<void> saveCalculationMethod(int value) async {
    await _prefs?.setInt('calculationMethod', value);
  }
  
  int getCalculationMethod() {
    if(_prefs?.containsKey('calculationMethod') == false) {
      saveCalculationMethod(Constant.DEFAULT_CALCULATION_METHOD);
      return Constant.DEFAULT_CALCULATION_METHOD;
    }
    return _prefs?.getInt('calculationMethod') ?? Constant.DEFAULT_CALCULATION_METHOD;
  }

  Future<void> clearCalculationMethod() async {
    await _prefs?.remove('calculationMethod');
  }

}
