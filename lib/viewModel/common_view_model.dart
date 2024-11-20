import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../global/global_vars.dart';

class CommonViewModel {
  Future<String?> getCurrentLocation(BuildContext context) async {
    try {
      Position cposition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      position = cposition;

      placeMarks = await placemarkFromCoordinates(cposition.latitude, cposition.longitude);

      if (placeMarks != null && placeMarks.isNotEmpty) {
        Placemark placeVar = placeMarks[0];

        String fullAddress =
            "${placeVar.subThoroughfare} ${placeVar.thoroughfare}, ${placeVar.subLocality} ${placeVar.locality}, ${placeVar.subAdministrativeArea} ${placeVar.administrativeArea}, ${placeVar.postalCode} ${placeVar.country}";

        return fullAddress;
      } else {
        showSnackBar("No address found", context);
        return null;
      }
    } catch (e) {
      showSnackBar("Error getting location: $e", context);
      return null;
    }
  }

  Future<void> updateLocationInDatabase(BuildContext context) async {
    String? address = await getCurrentLocation(context);

    if (address != null) {
      try {
        await FirebaseFirestore.instance
            .collection("sellers")
            .doc(sharedPreferences!.getString("uid"))
            .update({
          "address": address,
          "lat": position!.latitude,
          "lng": position!.longitude,
        });
        showSnackBar("Location updated successfully", context);
      } catch (e) {
        showSnackBar("Error updating location: $e", context);
      }
    }
  }

  void showSnackBar(String message, BuildContext context) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
