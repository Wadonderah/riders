import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riders_app/views/splashScreen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'global/global_vars.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp().catchError((error) {
    // Handle Firebase initialization error
    print("Firebase initialization error: $error");
  });

  sharedPreferences = await SharedPreferences.getInstance();

  await requestLocationPermission();
  runApp(const MyApp());
}

// New method for handling location permission
Future<void> requestLocationPermission() async {
  var status = await Permission.locationWhenInUse.status;
  if (status.isDenied) {
    await Permission.locationWhenInUse.request().catchError((error) {
      // Handle permission request error
      print("Location permission request error: $error");
    });
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Users App',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.white,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
