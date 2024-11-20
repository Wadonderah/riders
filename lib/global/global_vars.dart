import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Global variables for location and shared preferences.
class GlobalVars {
  static Position? position; // Current position of the user
  static List<Placemark>? placeMarks; // List of placemarks for the current position
  static String fullAddress = ""; // Full address derived from the placemarks
  static SharedPreferences? sharedPreferences; // Shared preferences instance

  /// Initializes the shared preferences instance.
  static Future<void> initSharedPreferences() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }
}
