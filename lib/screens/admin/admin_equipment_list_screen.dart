import 'package:flutter/material.dart';
import '../../models/equipment_model.dart';
import '../../services/admin_service.dart';
import '../../services/equipment_service.dart';

class AdminEquipmentListScreen extends StatefulWidget {
  @override
  _AdminEquipmentListScreenState createState() => _AdminEquipmentListScreenState();
}

class _AdminEquipmentListScreenState extends State<AdminEquipmentListScreen> {
  late Future<List<Equipment>> _futureEquipment;

  @override
  void initState() {
    super.initState();
    _loadEquipment();
  }

  void _loadEquipment() {
    setState(() {
      _futureEquipment = EquipmentService().fetchAllEquipment();
    });
  }

  void _confirmDelete(int equipmentId, String equipmentName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Confirm Delete'),
          content: Text('Are you sure you want to delete "$equipmentName"?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Delete'),
              onPressed: () async {
                Navigator.of(context).pop();
                final result = await AdminService().deleteEquipment(equipmentId);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(result)));
                _loadEquipment();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("All Equipment (Admin)")),
      body: FutureBuilder<List<Equipment>>(
        future: _futureEquipment,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());

          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));

          final items = snapshot.data!;
          if (items.isEmpty) return Center(child: Text("No equipment found."));

          return ListView.builder(
            padding: const EdgeInsets.only(bottom: 80, top: 10, left: 10, right: 10),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(item.name, style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text("${item.hourlyRate.toStringAsFixed(2)} ₺/hour"),
                            Text("Available: ${item.isAvailable ? 'Yes' : 'No'}"),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blue, size: 20),
                            onPressed: () {
                              Navigator.pushNamed(context, '/admin/update', arguments: item);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.red, size: 20),
                            onPressed: () => _confirmDelete(item.id, item.name),
                          ),
                        ],
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
}
