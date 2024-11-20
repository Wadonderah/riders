import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../global/global_vars.dart';
import '../splashScreen/splash_screen.dart';
import 'history_screen.dart';
import 'new_avilable_orders_screen.dart';
import 'not_yet_delivered_screen.dart';
import 'parcel_in_progress_screen.dart';
import 'total_earnings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List of dashboard items
  final List<Map<String, dynamic>> dashboardItems = [
    {
      "title": "New Available Orders",
      "icon": Icons.assignment,
      "screen": const NewAvilableOrdersScreen()
    },
    {
      "title": "Parcel in Progress",
      "icon": Icons.airport_shuttle,
      "screen": const ParcelInProgressScreen()
    },
    {
      "title": "Not Yet Delivered",
      "icon": Icons.location_history,
      "screen": const NotYetDeliveredScreen()
    },
    {
      "title": "History",
      "icon": Icons.done_all,
      "screen": const HistoryScreen()
    },
    {
      "title": "Total Earnings",
      "icon": Icons.monetization_on,
      "screen": const TotalEarningsScreen()
    },
    {"title": "Logout", "icon": Icons.logout, "screen": null}, // Logout does not have a screen
  ];

  Card dashboardItem(String title, IconData iconData, int index) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.all(8),
      child: Container(
        decoration: index == 0 || index == 3 || index == 4
            ? const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.blue,
                    Colors.green,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  tileMode: TileMode.clamp,
                ),
              )
            : const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.grey,
                    Colors.purple,
                  ],
                  begin: FractionalOffset(0.0, 0.0),
                  end: FractionalOffset(1.0, 0.0),
                  tileMode: TileMode.clamp,
                ),
              ),
        child: InkWell(
          onTap: () {
            if (index == 5) {
              // Logout logic
              _confirmLogout();
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (c) => dashboardItems[index]["screen"]),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: [
              const SizedBox(height: 50.0),
              Center(
                child: Icon(
                  iconData,
                  size: 40.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10.0),
              Center(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signOut();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (c) => const SplashScreen()),
                  );
                } catch (e) {
                  // Handle sign-out error
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Error signing out: $e")),
                  );
                }
              },
              child: const Text('Logout'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Welcome ${sharedPreferences!.getString("name")}',
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            letterSpacing: 2,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 6),
        child: GridView.count(
          crossAxisCount: 2,
          children: List.generate(dashboardItems.length, (index) {
            return dashboardItem(
              dashboardItems[index]["title"],
              dashboardItems[index]["icon"],
              index,
            );
          }),
        ),
      ),
    );
  }
}
