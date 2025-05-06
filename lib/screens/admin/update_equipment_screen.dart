import 'package:flutter/material.dart';
import '../../models/equipment_model.dart';
import '../../services/admin_service.dart';


class UpdateEquipmentScreen extends StatefulWidget {
  final Equipment equipment;

  UpdateEquipmentScreen({required this.equipment});

  @override
  _UpdateEquipmentScreenState createState() => _UpdateEquipmentScreenState();
}

class _UpdateEquipmentScreenState extends State<UpdateEquipmentScreen> {
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _imageController;
  late TextEditingController _priceController;
  late TextEditingController _categoryIdController;
  late bool _isAvailable;

  String message = "";

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.equipment.name);
    _descController = TextEditingController(text: widget.equipment.description);
    _imageController = TextEditingController(text: widget.equipment.imageUrl);
    _priceController = TextEditingController(text: widget.equipment.hourlyRate.toString());
    _categoryIdController = TextEditingController(text: widget.equipment.categoryId.toString());
    _isAvailable = widget.equipment.isAvailable;
  }

  void _submitUpdate() async {
    final updated = Equipment(
      id: widget.equipment.id,
      name: _nameController.text,
      description: _descController.text,
      imageUrl: _imageController.text,
      hourlyRate: double.tryParse(_priceController.text) ?? 0,
      isAvailable: _isAvailable,
      categoryId: int.tryParse(_categoryIdController.text) ?? 1,
    );

    final result = await AdminService().updateEquipment(updated);
    setState(() {
      message = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Update Equipment")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView(
          children: [
            TextField(controller: _nameController, decoration: InputDecoration(labelText: 'Name')),
            TextField(controller: _descController, decoration: InputDecoration(labelText: 'Description')),
            TextField(controller: _imageController, decoration: InputDecoration(labelText: 'Image URL')),
            TextField(controller: _priceController, decoration: InputDecoration(labelText: 'Hourly Rate'), keyboardType: TextInputType.number),
            TextField(controller: _categoryIdController, decoration: InputDecoration(labelText: 'Category ID'), keyboardType: TextInputType.number),
            SwitchListTile(
              value: _isAvailable,
              onChanged: (val) => setState(() => _isAvailable = val),
              title: Text("Is Available?"),
            ),
            ElevatedButton(
              onPressed: _submitUpdate,
              child: Text("Update"),
            ),
            SizedBox(height: 10),
            Text(message),
          ],
        ),
      ),
    );
  }
}
