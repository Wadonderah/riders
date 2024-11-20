import 'package:flutter/material.dart';

class NewAvailableOrdersScreen extends StatefulWidget {
  const NewAvailableOrdersScreen({super.key});

  @override
  State<NewAvailableOrdersScreen> createState() =>
      _NewAvailableOrdersScreenState();
}

class _NewAvailableOrdersScreenState extends State<NewAvailableOrdersScreen> {
  List<String>? newOrders; // List to hold new orders
  bool isLoading = true; // Loading state
  String? errorMessage; // Error message state

  @override
  void initState() {
    super.initState();
    fetchNewOrders(); // Fetch new orders when the screen initializes
  }

  // Simulated data fetching function
  Future<void> fetchNewOrders() async {
    try {
      // Simulate a network delay
      await Future.delayed(const Duration(seconds: 2));
      // Simulate fetching new orders (replace this with actual data fetching logic)
      newOrders = [
        "Order #1: Delivery from A to B",
        "Order #2: Delivery from C to D",
        "Order #3: Delivery from E to F",
      ];
    } catch (e) {
      // Handle any errors that occur during data fetching
      errorMessage = "Failed to load new orders: $e";
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
        title: const Text('New Available Orders'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : errorMessage != null
              ? Center(child: Text(errorMessage!)) // Error message
              : newOrders!.isEmpty
                  ? const Center(child: Text('No new orders available.')) // Empty state
                  : ListView.builder(
                      itemCount: newOrders!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(newOrders![index]),
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
