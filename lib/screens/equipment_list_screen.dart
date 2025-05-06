/*import 'package:flutter/material.dart';
import '../models/equipment_model.dart';
import '../services/equipment_service.dart';

class EquipmentListScreen extends StatefulWidget {
  final int categoryId;

  EquipmentListScreen({required this.categoryId});

  @override
  _EquipmentListScreenState createState() => _EquipmentListScreenState();
}

class _EquipmentListScreenState extends State<EquipmentListScreen> {
  late Future<List<Equipment>> _futureEquipment;

  @override
  void initState() {
    super.initState();
    _futureEquipment = EquipmentService().fetchAllEquipment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Equipment"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Equipment>>(
        future: _futureEquipment,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return Center(child: Text("No equipment found."));

          final equipmentList = snapshot.data!
              .where((e) => e.categoryId == widget.categoryId)
              .toList();

          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: equipmentList.length,
              itemBuilder: (context, index) {
                final equipment = equipmentList[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 4,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        equipment.imageUrl,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(
                      equipment.name,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${equipment.hourlyRate.toStringAsFixed(2)} ₺ / hour'),
                    trailing: Icon(Icons.arrow_forward_ios, size: 18),
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/equipment-detail',
                        arguments: equipment,
                      );
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}*/

import 'package:flutter/material.dart';
import '../models/equipment_model.dart';
import '../services/equipment_service.dart';

class EquipmentListScreen extends StatefulWidget {
  final int categoryId;

  EquipmentListScreen({required this.categoryId});

  @override
  _EquipmentListScreenState createState() => _EquipmentListScreenState();
}

class _EquipmentListScreenState extends State<EquipmentListScreen> {
  late Future<List<Equipment>> _futureEquipment;
  bool _isGridView = true;
  String _selectedSort = 'Featured';

  @override
  void initState() {
    super.initState();
    _futureEquipment = EquipmentService().fetchAllEquipment();
  }

  void _toggleView() {
    setState(() {
      _isGridView = !_isGridView;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Equipment"),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(_isGridView ? Icons.view_list : Icons.grid_view),
            tooltip: _isGridView ? 'Switch to list view' : 'Switch to grid view',
            onPressed: _toggleView,
          ),
        ],
      ),
      body: FutureBuilder<List<Equipment>>(
        future: _futureEquipment,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return const Center(child: CircularProgressIndicator());
          if (snapshot.hasError)
            return Center(child: Text("Error: ${snapshot.error}"));
          if (!snapshot.hasData || snapshot.data!.isEmpty)
            return const Center(child: Text("No equipment found."));

          List<Equipment> equipmentList = snapshot.data!
              .where((e) => e.categoryId == widget.categoryId)
              .toList();

          // Fiyata göre sırala
          if (_selectedSort == 'Price: Low to High') {
            equipmentList.sort((a, b) => a.hourlyRate.compareTo(b.hourlyRate));
          } else if (_selectedSort == 'Price: High to Low') {
            equipmentList.sort((a, b) => b.hourlyRate.compareTo(a.hourlyRate));
          }

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 12.0, top: 8.0, bottom: 4.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blueAccent, width: 1),
                      borderRadius: BorderRadius.circular(16),
                      color: Colors.grey.shade100,
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedSort,
                        iconSize: 18,
                        style: const TextStyle(fontSize: 12, color: Colors.black),
                        isDense: true,
                        alignment: Alignment.center,
                        items: [
                          'Featured',
                          'Price: Low to High',
                          'Price: High to Low',
                        ].map((label) {
                          return DropdownMenuItem(
                            value: label,
                            child: Text(
                              'Sort by: $label',
                              style: const TextStyle(fontSize: 12),
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSort = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ),
              ),


              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: _isGridView
                      ? GridView.builder(
                    itemCount: equipmentList.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.8,
                    ),
                    itemBuilder: (context, index) {
                      final equipment = equipmentList[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/equipment-detail',
                            arguments: equipment,
                          );
                        },
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(12)),
                                  child: Image.network(
                                    equipment.imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      equipment.name,
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                        '${equipment.hourlyRate.toStringAsFixed(2)} ₺ / hour'),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  )
                      : ListView.builder(
                    itemCount: equipmentList.length,
                    itemBuilder: (context, index) {
                      final equipment = equipmentList[index];
                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(12),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              equipment.imageUrl,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(
                            equipment.name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                              '${equipment.hourlyRate.toStringAsFixed(2)} ₺ / hour'),
                          trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/equipment-detail',
                              arguments: equipment,
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

