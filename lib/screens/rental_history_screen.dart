/*
import 'package:flutter/material.dart';
import '../models/rental_model.dart';
import '../services/rental_service.dart';
import 'package:intl/intl.dart'; // tarih formatı için

class RentalHistoryScreen extends StatefulWidget {
  @override
  _RentalHistoryScreenState createState() => _RentalHistoryScreenState();
}

class _RentalHistoryScreenState extends State<RentalHistoryScreen> {
  late Future<List<Rental>> _futureRentals;

  @override
  void initState() {
    super.initState();
    _futureRentals = RentalService().fetchMyRentals();
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("My Rentals"), centerTitle: true),
      body: FutureBuilder<List<Rental>>(
        future: _futureRentals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text("Something went wrong."));

          final rentals = snapshot.data!;
          if (rentals.isEmpty) {
            return Center(child: Text("You haven't rented anything yet."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: rentals.length,
            itemBuilder: (context, index) {
              final rental = rentals[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        rental.equipmentName,
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text("Start: ${formatDate(rental.startTime)}"),
                      Text("End:   ${formatDate(rental.endTime)}"),
                      SizedBox(height: 10),
                      Text(
                        "Total Price: ${rental.totalPrice.toStringAsFixed(2)} ₺",
                        style: TextStyle(color: Colors.green[700], fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import '../models/rental_model.dart';
import '../services/rental_service.dart';
import 'package:intl/intl.dart';

class RentalHistoryScreen extends StatefulWidget {
  @override
  _RentalHistoryScreenState createState() => _RentalHistoryScreenState();
}

class _RentalHistoryScreenState extends State<RentalHistoryScreen> {
  late Future<List<Rental>> _futureRentals;

  @override
  void initState() {
    super.initState();
    _futureRentals = RentalService().fetchMyRentals();
  }

  String formatDate(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, HH:mm').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Rentals"), centerTitle: true),
      body: FutureBuilder<List<Rental>>(
        future: _futureRentals,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return const Center(child: Text("Something went wrong."));

          final rentals = snapshot.data!;
          if (rentals.isEmpty) {
            return const Center(child: Text("You haven't rented anything yet."));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: rentals.length,
            itemBuilder: (context, index) {
              final rental = rentals[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                elevation: 4,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 📸 Equipment Image
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      ),
                      child: Image.network(
                        rental.imageUrl, // <- bu alan backend’den gelmeli
                        width: 110,
                        height: 110,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Container(
                          width: 110,
                          height: 110,
                          color: Colors.grey[200],
                          child: const Icon(Icons.broken_image, color: Colors.grey),
                        ),
                      ),
                    ),

                    // 📄 Rental Info
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              rental.equipmentName,
                              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text("Start: ${formatDate(rental.startTime)}"),
                            Text("End:   ${formatDate(rental.endTime)}"),
                            const SizedBox(height: 10),
                            Text(
                              "Total Price: ${rental.totalPrice.toStringAsFixed(2)} ₺",
                              style: TextStyle(
                                color: Colors.green[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

