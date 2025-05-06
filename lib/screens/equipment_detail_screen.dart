import 'package:flutter/material.dart';
import '../models/equipment_model.dart';

class EquipmentDetailScreen extends StatelessWidget {
  final Equipment equipment;

  const EquipmentDetailScreen({Key? key, required this.equipment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(equipment.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                equipment.imageUrl,
                height: 250,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 20),

            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Text(equipment.description, style: TextStyle(fontSize: 16)),

                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Price per hour:",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${equipment.hourlyRate.toStringAsFixed(2)} ₺",
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),

                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Available:", style: TextStyle(fontWeight: FontWeight.bold)),
                        Text(equipment.isAvailable ? "Yes" : "No",
                            style: TextStyle(
                                color: equipment.isAvailable ? Colors.green : Colors.red,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            if (equipment.isAvailable)
              ElevatedButton.icon(
                icon: Icon(Icons.shopping_cart),
                label: Text("Rent Now"),
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/rent',
                    arguments: {
                      'equipment': equipment,
                      'userId': 1, // geçici
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  textStyle: TextStyle(fontSize: 16),
                ),
              )
            else
              Text(
                "Not available for rent.",
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import '../models/equipment_model.dart';

class EquipmentDetailScreen extends StatelessWidget {
  final Equipment equipment;

  const EquipmentDetailScreen({Key? key, required this.equipment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(equipment.name),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    equipment.imageUrl,
                    width: double.infinity,
                    height: 240,
                    fit: BoxFit.cover,
                  ),
                ),
                if (!equipment.isAvailable)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Not Available",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Description",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      equipment.description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Price per hour:",
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        Text(
                          "${equipment.hourlyRate.toStringAsFixed(2)} ₺",
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Availability:", style: TextStyle(fontWeight: FontWeight.w600)),
                        Text(
                          equipment.isAvailable ? "Available" : "Unavailable",
                          style: TextStyle(
                            color: equipment.isAvailable ? Colors.green : Colors.red,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            if (equipment.isAvailable)
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  icon: const Icon(Icons.shopping_cart_checkout_rounded),
                  label: const Text("Rent This Equipment"),
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/rent',
                      arguments: {
                        'equipment': equipment,
                        'userId': 1, // geçici kullanıcı ID
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(fontSize: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              )
            else
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 12),
                  child: Text(
                    "This item is currently unavailable for rent.",
                    style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
*/