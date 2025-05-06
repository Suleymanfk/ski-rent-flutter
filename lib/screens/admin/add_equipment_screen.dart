import 'package:flutter/material.dart';
import '../../models/equipment_model.dart';
import '../../services/admin_service.dart';

class AddEquipmentScreen extends StatefulWidget {
  @override
  _AddEquipmentScreenState createState() => _AddEquipmentScreenState();
}

class _AddEquipmentScreenState extends State<AddEquipmentScreen> {
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _imageController = TextEditingController();
  final _priceController = TextEditingController();
  final _categoryIdController = TextEditingController();
  bool _isAvailable = true;
  String message = "";

  void _submit() async {
    final categoryId = int.tryParse(_categoryIdController.text) ?? 1;
    final equipment = Equipment(
      id: 0,
      name: _nameController.text.trim(),
      description: _descController.text.trim(),
      imageUrl: _imageController.text.trim(),
      hourlyRate: double.tryParse(_priceController.text.trim()) ?? 0,
      isAvailable: _isAvailable,
      categoryId: categoryId,
    );

    final result = await AdminService().addEquipment(equipment, categoryId);

    setState(() {
      message = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Equipment")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _descController,
              decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _imageController,
              decoration: InputDecoration(
                labelText: 'Image URL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _priceController,
              decoration: InputDecoration(
                labelText: 'Hourly Rate',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            TextField(
              controller: _categoryIdController,
              decoration: InputDecoration(
                labelText: 'Category ID',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 12),
            SwitchListTile(
              value: _isAvailable,
              onChanged: (val) => setState(() => _isAvailable = val),
              title: Text("Is Available?"),
            ),
            SizedBox(height: 12),
            ElevatedButton.icon(
              icon: Icon(Icons.add),
              label: Text("Submit"),
              style: ElevatedButton.styleFrom(minimumSize: Size(double.infinity, 45)),
              onPressed: _submit,
            ),
            SizedBox(height: 20),
            if (message.isNotEmpty)
              Text(
                message,
                style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }
}
