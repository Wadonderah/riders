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
            if (index == 0) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => const NewAvilableOrdersScreen()));
            }
            if (index == 1) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => const ParcelInProgressScreen()));
            }
            if (index == 2) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => const NotYetDeliveredScreen()));
            }
            if (index == 3) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const HistoryScreen()));
            }
            if (index == 4) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (c) => const TotalEarningsScreen()));
            }
            if (index == 5) {
              FirebaseAuth.instance.signOut();
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => const SplashScreen()));
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
              )),
            ],
          ),
        ),
      ),
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
          children: [
            dashboardItem("New Available Orders", Icons.assignment, 0),
            dashboardItem("Parcel in progress", Icons.airport_shuttle, 1),
            dashboardItem("Not Yet Delivered", Icons.location_history, 2),
            dashboardItem("History", Icons.done_all, 3),
            dashboardItem("Total Earnings", Icons.monetization_on, 4),
            dashboardItem("Logout", Icons.logout, 5),
          ],
        ),
      ),
    );
  }
}
