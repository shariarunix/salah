import 'package:geocoding/geocoding.dart';

class LocationUtils{
  LocationUtils._();


  static Future<String?> getAddressFromLatLng(double latitude, double longitude) async {
    try {
      List<Placemark> placeMarks = await placemarkFromCoordinates(latitude, longitude,);

      if (placeMarks.isNotEmpty) {
        Placemark place = placeMarks[0];
        return '${place.locality}, ${place.country}';
      }
      return null;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}