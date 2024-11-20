import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<String>? historyItems; // List to hold history items
  bool isLoading = true; // Loading state
  String? errorMessage; // Error message state

  @override
  void initState() {
    super.initState();
    fetchHistoryData(); // Fetch data when the screen initializes
  }

  // Simulated data fetching function
  Future<void> fetchHistoryData() async {
    try {
      // Simulate a network delay
      await Future.delayed(const Duration(seconds: 2));
      // Simulate fetching data (replace this with actual data fetching logic)
      historyItems = [
        "Ride from A to B",
        "Ride from C to D",
        "Ride from E to F",
      ];
    } catch (e) {
      // Handle any errors that occur during data fetching
      errorMessage = "Failed to load history: $e";
    } finally {
      setState(() {
        isLoading = false; // Update loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : errorMessage != null
              ? Center(child: Text(errorMessage!)) // Error message
              : historyItems!.isEmpty
                  ? const Center(child: Text('No history available.')) // Empty state
                  : ListView.builder(
                      itemCount: historyItems!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(historyItems![index]),
                          // You can add more details or actions here
                          onTap: () {
                            // Handle item tap if needed
                          },
                        );
                      },
                    ),
    );
  }
}
