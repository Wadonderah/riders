import 'package:flutter/material.dart';

class ParcelInProgressScreen extends StatefulWidget {
  const ParcelInProgressScreen({super.key});

  @override
  State<ParcelInProgressScreen> createState() => _ParcelInProgressScreenState();
}

class _ParcelInProgressScreenState extends State<ParcelInProgressScreen> {
  List<String>? parcelsInProgress; // List to hold parcels in progress
  bool isLoading = true; // Loading state
  String? errorMessage; // Error message state

  @override
  void initState() {
    super.initState();
    fetchParcelsInProgress(); // Fetch parcels in progress when the screen initializes
  }

  // Simulated data fetching function
  Future<void> fetchParcelsInProgress() async {
    try {
      // Simulate a network delay
      await Future.delayed(const Duration(seconds: 2));
      // Simulate fetching parcels in progress (replace this with actual data fetching logic)
      parcelsInProgress = [
        "Parcel #1: From A to B",
        "Parcel #2: From C to D",
        "Parcel #3: From E to F",
      ];
    } catch (e) {
      // Handle any errors that occur during data fetching
      errorMessage = "Failed to load parcels in progress: $e";
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
        title: const Text('Parcels In Progress'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator()) // Loading indicator
          : errorMessage != null
              ? Center(child: Text(errorMessage!)) // Error message
              : parcelsInProgress!.isEmpty
                  ? const Center(child: Text('No parcels in progress available.')) // Empty state
                  : ListView.builder(
                      itemCount: parcelsInProgress!.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(parcelsInProgress![index]),
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
