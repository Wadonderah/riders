import 'package:flutter/material.dart';

class NotYetDeliveredScreen extends StatefulWidget {
  const NotYetDeliveredScreen({super.key});

  @override
  State<NotYetDeliveredScreen> createState() => _NotYetDeliveredScreenState();
}

class _NotYetDeliveredScreenState extends State<NotYetDeliveredScreen> {
  List<String>? notDeliveredOrders; // List to hold not yet delivered orders
  bool isLoading = true; // Loading state
  String? errorMessage; // Error message state

  @override
  void initState() {
    super.initState();
    fetchNotDeliveredOrders(); // Fetch not delivered orders when the screen initializes
  }

  // Simulated data fetching function
  Future<void> fetchNotDeliveredOrders() async {
    try {
      // Simulate a network delay
      await Future.delayed(const Duration(seconds: 2));
      // Simulate fetching not delivered orders (replace this with actual data fetching logic)
      notDeliveredOrders = [
        "Order #1: Delivery from A to B",
        "Order #2: Delivery from C to D",
        "Order #3: Delivery from E to F",
      ];
    } catch (e) {
      // Handle any errors that occur during data fetching
      errorMessage = "Failed to load not yet delivered orders: $e";
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
        title: const Text('Not Yet Delivered Orders'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : errorMessage != null
              ? Center(child: Text(errorMessage!)) // Error message
              : notDeliveredOrders!.isEmpty
                  ? const Center(child: Text('No not yet delivered orders available.')) // Empty state
                  : ListView.builder(
                      itemCount: notDeliveredOrders!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(notDeliveredOrders![index]),
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
