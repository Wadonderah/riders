import 'package:flutter/material.dart';

class TotalEarningsScreen extends StatefulWidget {
  const TotalEarningsScreen({super.key});

  @override
  State<TotalEarningsScreen> createState() => _TotalEarningsScreenState();
}

class _TotalEarningsScreenState extends State<TotalEarningsScreen> {
  double totalEarnings = 0.0; // Variable to hold total earnings
  bool isLoading = true; // Loading state
  String? errorMessage; // Error message state

  @override
  void initState() {
    super.initState();
    fetchTotalEarnings(); // Fetch total earnings when the screen initializes
  }

  // Simulated data fetching function
  Future<void> fetchTotalEarnings() async {
    try {
      // Simulate a network delay
      await Future.delayed(const Duration(seconds: 2));
      // Simulate fetching total earnings (replace this with actual data fetching logic)
      totalEarnings = 150.75; // Example earnings
    } catch (e) {
      // Handle any errors that occur during data fetching
      errorMessage = "Failed to load total earnings: $e";
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
        title: const Text('Total Earnings'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : errorMessage != null
              ? Center(child: Text(errorMessage!)) // Error message
              : Center(
                  child: Text(
                    'Total Earnings: \$${totalEarnings.toStringAsFixed(2)}', // Display total earnings
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
    );
  }
}
